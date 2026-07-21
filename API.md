# API — Beneficios Establecimiento

API REST para la gestión de beneficios Junaeb en establecimientos. Este documento está pensado
principalmente para quien desarrolla la **app de entrega de beneficios** (Encargado / Operario),
pero incluye el resto de endpoints para referencia completa del sistema.

- **Base URL (desde esta misma máquina):** `http://localhost:8541/api`
- **Base URL (desde otro dispositivo en la misma red local — celular, emulador, etc.):**
  `http://192.168.11.141:8541/api`
- **Formato:** JSON (`Content-Type: application/json`, salvo la carga de CSV que es `multipart/form-data`)
- **Autenticación:** JWT (Bearer token)

> La IP `192.168.11.141` es la del computador donde corre el servidor dentro de la red WiFi/LAN
> actual — solo alcanzable por dispositivos conectados a esa misma red, no desde internet. Puede
> cambiar si el router reasigna la IP (DHCP) o si el computador cambia de red; si la app deja de
> conectar, confirma la IP actual con quien tenga el servidor corriendo. Es HTTP plano (no hay
> certificado válido para esa IP), así que en Android puede requerir permitir tráfico "cleartext"
> para ese host en desarrollo.

---

## 1. Autenticación

Todas las rutas salvo `POST /auth/login` requieren el header:

```
Authorization: Bearer {access_token}
```

El token incluye el rol y el establecimiento del usuario. Todo lo que devuelve la API está
automáticamente acotado al establecimiento del usuario autenticado — nunca hay que enviar un
`establecimiento_id` a mano.

### POST /auth/login

```json
{
  "email": "operario@escuela.cl",
  "password": "password"
}
```

**200 OK**

```json
{
  "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...",
  "token_type": "bearer",
  "expires_in": 28800,
  "user": {
    "id": 3,
    "establecimiento_id": 1,
    "name": "Operario Demo",
    "email": "operario@escuela.cl",
    "rol": "operario",
    "activo": true,
    "establecimiento": { "id": 1, "nombre": "Escuela Demo", "rut": "76543210-3", "activo": true }
  }
}
```

`expires_in` está en segundos (token válido por 8 horas por defecto). Si el usuario está
inactivo o la contraseña es incorrecta: **401** `{"message": "Credenciales inválidas."}` o
`{"message": "Usuario inactivo."}`.

### GET /auth/me

Devuelve el usuario autenticado (con su establecimiento). Útil para verificar si el token
sigue siendo válido al abrir la app.

### POST /auth/refresh

Devuelve un `access_token` nuevo (misma forma que el login), invalidando el anterior. Úsalo
antes de que expire para no forzar un nuevo login.

### POST /auth/logout

Invalida el token actual. **200** `{"message": "Sesión cerrada."}`.

---

## 2. Roles y qué puede hacer cada uno

| Rol | Usuarios | Ingreso stock | Carga nómina | Reportes | Entrega de beneficios |
|---|---|---|---|---|---|
| Administrador | CRUD | Sí | Sí | Sí | **No** |
| Encargado | No | Sí | Sí | Sí | Sí |
| Operario | No | No | No | No | Sí |

**La app de entrega la usan Encargado y Operario.** Un intento de `POST /beneficios/entrega`
con un usuario Administrador devuelve **403**. Los endpoints de "solo lectura operativa"
(`GET /beneficios`, `GET /alumnos`) están disponibles para cualquier rol autenticado.

---

## 3. Endpoints para la app de entrega

Estos cuatro son los que la app necesita para su flujo completo: elegir beneficio → buscar
alumno → marcar entrega (o dar de alta al alumno si no aparece).

### GET /beneficios

Beneficios **habilitados** para el establecimiento, agrupados por área. Si un beneficio es
`stockeable`, incluye el stock disponible; si no, `stock_actual` viene `null` (no aplica).

**200 OK**

```json
{
  "areas": [
    {
      "id": 3,
      "nombre": "Útiles y Textos Escolares",
      "beneficios": [
        { "id": 7, "nombre": "Kit de Útiles Escolares", "stockeable": true, "stock_actual": 49 }
      ]
    },
    {
      "id": 1,
      "nombre": "Alimentación Escolar",
      "beneficios": [
        { "id": 1, "nombre": "Desayuno Escolar", "stockeable": false, "stock_actual": null }
      ]
    }
  ]
}
```

Un área sin beneficios habilitados no aparece en la lista.

### GET /alumnos?q={texto}

Busca por nombre o RUT (en cualquier formato) dentro de la nómina del establecimiento.
Devuelve como máximo **20 resultados**, sin paginación — es para el buscador rápido de la app,
no para un listado administrativo.

`GET /alumnos?q=ana` o `GET /alumnos?q=11.111.111-1`

**200 OK**

```json
[
  {
    "id": 1,
    "rut": "11111111-1",
    "nombre": "Ana Torres Pérez",
    "nacimiento": "2012-03-14",
    "curso": "6° Básico A",
    "validado": true,
    "verificado": true
  }
]
```

- `validado: true` → el alumno viene de una nómina CSV oficial.
- `verificado: false` → el alumno fue ingresado manualmente en terreno (ver siguiente
  endpoint) y todavía no ha sido confirmado contra una nómina oficial. Conviene mostrar esto
  en la UI (ej. un badge "sin verificar") para que el Encargado/Operario sepa que la
  identidad fue solo una verificación visual.

### POST /alumnos — alta manual (alumno no está en la nómina)

Solo cuando la búsqueda anterior no encuentra al alumno. Requiere verificación visual del
Encargado/Operario en terreno; el registro queda marcado `verificado: false` para poder
identificarlo después.

```json
{
  "rut": "20.123.456-7",
  "nombre": "Nuevo Alumno",
  "nacimiento": "2013-05-10",
  "curso": "5° Básico B"
}
```

`nacimiento` y `curso` son opcionales. `rut` acepta cualquier formato (con o sin puntos/guion).

**201 Created** → el alumno creado (con `validado: false, verificado: false`).
**422** si el RUT no es válido (dígito verificador incorrecto) o si ya existe un alumno con
ese RUT en el establecimiento (en ese caso el body incluye `"alumno": {...}` con el existente,
para que la app pueda reintentar la entrega directo con ese RUT).

### POST /beneficios/entrega

Marca la entrega de un beneficio a un alumno.

```json
{
  "beneficio": 7,
  "codigo": "ABC-123",
  "alumno": "11111111-1"
}
```

- `beneficio`: id del beneficio (del listado de `GET /beneficios`).
- `codigo`: **obligatorio solo si el beneficio es `stockeable: true`** (es el código/serie del
  ítem físico entregado). Si el beneficio no es stockeable, se ignora aunque se envíe.
- `alumno`: RUT del alumno, en cualquier formato.

**201 Created**

```json
{
  "id": 10,
  "establecimiento_id": 1,
  "beneficio_id": 7,
  "alumno_id": 1,
  "user_id": 2,
  "codigo": "ABC-123",
  "created_at": "2026-07-21T14:46:19.000000Z",
  "beneficio": { "id": 7, "nombre": "Kit de Útiles Escolares", "stockeable": true },
  "alumno": { "id": 1, "rut": "11111111-1", "nombre": "Ana Torres Pérez" }
}
```

**Errores posibles:**

| Código | Motivo |
|---|---|
| 404 | El alumno no está en la nómina (`POST /alumnos` primero) |
| 422 | El beneficio no está habilitado en este establecimiento |
| 422 | Falta el código de entrega en un beneficio stockeable |
| 422 | No hay stock disponible (`stock_actual = 0`) — la entrega **se bloquea**, no hay forma de forzarla |
| 403 | El usuario autenticado no tiene rol Encargado u Operario |

No hay control de periodicidad: un mismo beneficio puede entregarse más de una vez al mismo
alumno (fuera del alcance de este MVP). Lo único que bloquea una entrega es la falta de stock.

---

## 4. RUT chileno

Se acepta en cualquier formato de entrada: `11222333-4`, `112223334`, `11.222.333-4`. La API
siempre normaliza y valida con **dígito verificador (módulo 11)** antes de procesar. Un RUT con
DV incorrecto devuelve `422` con el detalle en `errors`. No hace falta que la app normalice
nada antes de enviarlo — sí conviene validar el formato en el cliente para dar feedback rápido,
pero la validación real ocurre en el servidor.

---

## 5. Formato de errores

Los errores de validación (422) siguen el formato estándar de Laravel, con mensajes en español:

```json
{
  "message": "El campo beneficio es obligatorio.",
  "errors": {
    "beneficio": ["El campo beneficio es obligatorio."],
    "alumno": ["El campo RUT del alumno es obligatorio."]
  }
}
```

`message` siempre trae el primer error como resumen legible; `errors` trae el detalle completo
por campo (puede haber más de un mensaje por campo, y más de un campo con errores).

Otros errores (401, 403, 404, 422 de negocio) devuelven solo:

```json
{ "message": "descripción legible del error" }
```

Códigos usados: `200` OK, `201` creado, `204` eliminado sin contenido, `401` no autenticado /
credenciales inválidas, `403` no autorizado para esa acción, `404` no encontrado, `422`
validación o regla de negocio, `500` error inesperado.

---

## 6. Endpoints de administración (panel web, no usados por la app móvil)

El resto de la API existe para el panel web de Administrador/Encargado. Se documentan por
completitud, pero la app de entrega no debería necesitarlos.

### Usuarios — solo Administrador

| Método | Ruta | Body | Descripción |
|---|---|---|---|
| GET | `/usuarios` | — | Lista usuarios del establecimiento |
| POST | `/usuarios` | `name, email, password, password_confirmation, rol, activo?` | Crea usuario |
| PUT | `/usuarios/{id}` | igual, todos opcionales | Edita (password vacío = no la cambia) |
| DELETE | `/usuarios/{id}` | — | Elimina (no se puede auto-eliminar) |

`rol` es uno de `administrador`, `encargado`, `operario`.

### Catálogo y habilitación de beneficios — solo Administrador

| Método | Ruta | Body | Descripción |
|---|---|---|---|
| GET | `/beneficios/catalogo` | — | Catálogo completo (habilitado o no) con stock |
| POST | `/beneficios/habilitacion` | `beneficio_id, habilitado` | Habilita/deshabilita un beneficio |

### Stock — Administrador y Encargado

| Método | Ruta | Body | Descripción |
|---|---|---|---|
| GET | `/stock` | — | Stock actual de beneficios stockeables habilitados |
| GET | `/stock/historico` | — | Histórico de cargas (paginado) |
| POST | `/stock` | `beneficio_id, cantidad` | Suma cantidad al stock disponible (queda como histórico) |

### Nómina — Administrador y Encargado

| Método | Ruta | Body | Descripción |
|---|---|---|---|
| GET | `/alumnos/panel` | `q?, curso?, validado?, verificado?, page?` | Buscador avanzado paginado |
| POST | `/alumnos/nomina-csv` | `archivo` (multipart, CSV) | Carga masiva de nómina |

CSV esperado con columnas `rut, nombre, nacimiento, curso` (delimitador `,` o `;`,
fecha `YYYY-MM-DD`, `DD-MM-YYYY` o `DD/MM/YYYY`). Si el alumno ya existe se actualiza y queda
`validado: true`.

### Reportes — Administrador y Encargado

| Método | Ruta | Query | Descripción |
|---|---|---|---|
| GET | `/reportes/resumen` | `desde?, hasta?` (YYYY-MM-DD, default últimos 30 días) | Totales, cobertura, entregas por beneficio/área/curso/día, stock actual |
| GET | `/reportes/entregas` | `desde?, hasta?, beneficio_id?, area_id?, curso?, rut?, page?` | Detalle paginado de entregas |
| GET | `/reportes/entregas/exportar` | mismos filtros | Igual que el anterior, como CSV descargable |

---

## 7. Datos de prueba (ambiente de desarrollo)

| Usuario | Email | Password | Rol |
|---|---|---|---|
| Administrador Demo | administrador@escuela.cl | password | administrador |
| Encargado Demo | encargado@escuela.cl | password | encargado |
| Operario Demo | operario@escuela.cl | password | operario |

Alumnos de ejemplo en la nómina: `11111111-1` (Ana Torres Pérez), `22222222-2` (Benjamín Soto
Rivas), `33333333-3` (Camila Fuentes Díaz).

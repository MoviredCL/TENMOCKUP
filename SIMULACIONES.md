# Modo simulación (demo sin conexión)

Este documento es para **Claude Code trabajando en el repo de la app de entrega de
beneficios** (la app móvil que consume esta API). Explica cómo usar `simulaciones.json`
para que la app funcione en una presentación **sin conexión a internet ni al backend real**.

## Contexto

La app se va a mostrar en una presentación cerrada, sin garantía de conectividad. En vez de
correr el backend real, la app debe **simular** las respuestas de la API contra la que
normalmente conversa (documentada en `API.md` de este mismo repo). `simulaciones.json` trae,
para cada endpoint relevante, tres respuestas HTTP 200 de ejemplo — reales en forma y contenido,
solo que con datos ficticios — para que la app elija una al azar cada vez que "llama" a ese
endpoint.

**Esto es exclusivamente para la demo.** No reemplaza la integración real con la API ni debe
quedar activo por defecto en producción.

## Archivo `simulaciones.json`

Estructura:

```json
{
  "endpoints": [
    {
      "method": "POST",
      "url": "/api/auth/login",
      "responses": [ { /* respuesta 200 #1 */ }, { /* #2 */ }, { /* #3 */ } ]
    },
    {
      "method": "GET",
      "url": "/api/beneficios",
      "responses": [ { /* ... */ }, { /* ... */ }, { /* ... */ } ]
    }
  ]
}
```

- `method`: verbo HTTP (`GET` o `POST`).
- `url`: el path del endpoint **sin query string** (ej. `/api/alumnos`, no
  `/api/alumnos?q=ana`). Para hacer match, ignora cualquier `?...` de la URL real que la app
  arme y compara solo el path.
- `responses`: siempre un array de **exactamente 3** respuestas 200 válidas. Cada una es el
  body JSON tal cual lo devolvería la API real para ese endpoint — mismos campos, mismos tipos,
  mismas relaciones anidadas (ver `API.md` para el significado de cada campo). Los datos son
  ficticios pero con la forma real: RUTs válidos, códigos QR con el mismo alfabeto/largo que usa
  el backend, fechas ISO, etc.

Endpoints incluidos (los mismos que la app realmente usa, ver `API.md` sección 3):

| Method | URL | Nota |
|---|---|---|
| POST | `/api/auth/login` | Login |
| GET | `/api/auth/me` | Usuario autenticado |
| POST | `/api/auth/refresh` | Renovar token |
| POST | `/api/auth/logout` | Cerrar sesión |
| GET | `/api/beneficios` | Catálogo habilitado + stock |
| GET | `/api/alumnos` | Búsqueda (nombre, RUT o código QR escaneado) |
| POST | `/api/alumnos` | Alta manual de alumno |
| POST | `/api/beneficios/entrega` | Marcar entrega |

Si la app usa algún endpoint que no está en esta lista, agrégalo siguiendo el mismo patrón
(method + url + 3 responses con la forma documentada en `API.md`) en vez de inventar una
estructura nueva.

## Cómo integrarlo en la app

1. **Copia `simulaciones.json`** a los assets de la app (en Flutter, por ejemplo
   `assets/simulaciones.json`, declarado en `pubspec.yaml` bajo `flutter/assets`).
2. **Agrega un flag de modo simulación** (ej. `const bool kModoSimulacion = true;` o una
   variable de entorno/config leída al arrancar). Con el flag en `true`, ningún request debe
   salir a la red real.
3. **Intercepta las llamadas HTTP** en el punto único donde la app arma sus requests (el
   cliente HTTP / repositorio de datos), de forma que el resto de la app (pantallas, estado,
   navegación) no sepa ni le importe si la respuesta es real o simulada:
   - Carga `simulaciones.json` una vez (al iniciar o de forma perezosa) y parsea el JSON.
   - Al interceptar un request, busca en `endpoints` la entrada cuyo `method` coincida y cuyo
     `url` coincida con el path del request (sin query string).
   - Si hay match, elige **una respuesta al azar** de las 3 (`responses[Random().nextInt(3)]`
     en Dart, o equivalente) y resuélvela como si fuera el body de una respuesta 200 real
     (mismo `Content-Type: application/json`, sin delay artificial o con uno breve para que se
     sienta real).
   - Si no hay match (endpoint no cubierto), decide un fallback razonable — por ejemplo, devolver
     la primera respuesta del endpoint más parecido, o loggear una advertencia en consola; no
     debe crashear la app en medio de la presentación.
4. **No mezcles estado entre respuestas simuladas.** Cada llamada es independiente y elige al
   azar; no intentes mantener consistencia de stock/entregas entre una respuesta y la siguiente
   más allá de lo que ya viene reflejado en las 3 variantes de `GET /api/beneficios` (que bajan
   de a poco el stock para dar sensación de uso real).
5. **Verifica el flujo completo offline** antes de la presentación: login → ver beneficios →
   buscar alumno (por nombre y por código QR) → marcar entrega → (opcional) dar de alta un
   alumno manualmente. Todo debe andar con el wifi/datos del dispositivo apagados.

## Qué NO hacer

- No conectar `simulaciones.json` a ninguna lógica de negocio real (validaciones de stock,
  periodicidad, etc.) — es solo texto de relleno para que la UI se vea poblada, no hay que
  replicar las reglas del backend.
- No dejar el modo simulación como default en un build de producción/tienda; debe ser explícito
  (flag de build, o pantalla oculta de configuración) y estar apagado por defecto.
- No inventar campos que no estén en `API.md` — si falta algo que la UI necesita, es mejor
  avisar para agregarlo a `simulaciones.json` con la forma correcta que inventar una estructura
  distinta a la que la API real usa.

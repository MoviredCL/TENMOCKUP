---
name: TNE Digital Impeccable
description: Rediseño moderno, pulcro y juvenil para la gestión de transporte escolar.
colors:
  primary: "#6929C4"
  secondary: "#00E5FF"
  accent: "#FF3D00"
  neutral-bg: "#F8F9FE"
  neutral-surface: "#FFFFFF"
  neutral-text: "#1A1A1B"
typography:
  display:
    fontFamily: "Outfit, Inter, sans-serif"
    fontSize: "32px"
    fontWeight: 700
    lineHeight: 1.2
  body:
    fontFamily: "Inter, sans-serif"
    fontSize: "16px"
    fontWeight: 400
    lineHeight: 1.5
rounded:
  sm: "8px"
  md: "16px"
  lg: "24px"
spacing:
  xs: "4px"
  sm: "8px"
  md: "16px"
  lg: "24px"
components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.neutral-surface}"
    rounded: "{rounded.md}"
    padding: "16px 24px"
  card-main:
    backgroundColor: "{colors.neutral-surface}"
    rounded: "{rounded.lg}"
    padding: "24px"
---

# Design System: TNE Digital Impeccable

## 1. Overview

**Creative North Star: "The Student Pulse"**

Un sistema de diseño que captura la energía y la inmediatez de la vida estudiantil. Se aleja de la estética burocrática para adoptar un lenguaje visual cercano a las apps de "fintech" modernas: limpio, espacioso y con un uso audaz del color y la tipografía.

**Key Characteristics:**
- **Geometría Amigable**: Bordes muy redondeados (24px) que transmiten accesibilidad.
- **Micro-interacciones Fluídas**: El movimiento valida cada acción del usuario.
- **Espaciado Generoso**: Nada se siente apretado; la información respira.

## 2. Colors

La paleta es vibrante pero equilibrada, utilizando un índigo profundo como ancla y un cian eléctrico para momentos de alta energía.

### Primary
- **Deep Indigo** (#6929C4): Color de marca principal. Se usa en botones de acción primaria y elementos de navegación activos.

### Secondary
- **Electric Cyan** (#00E5FF): Color de energía. Se usa para estados de éxito, barras de progreso y acentos juveniles.

### Neutral
- **Pure Slate** (#1A1A1B): Para texto principal y títulos.
- **Cloud Gray** (#F8F9FE): Color de fondo general para evitar el blanco puro y reducir la fatiga visual.

**The Rarity Rule.** El color Electric Cyan se usa solo en <5% de la interfaz para que cuando aparezca, realmente capture la atención.

## 3. Typography

**Display Font:** Outfit
**Body Font:** Inter

### Hierarchy
- **Display** (700, 32px, 1.2): Para saludos de bienvenida y estados principales.
- **Headline** (600, 24px, 1.3): Títulos de secciones y nombres de tarjetas.
- **Body** (400, 16px, 1.5): Texto informativo y descripciones.
- **Label** (500, 12px, 1.2, Uppercase): Categorías y metadatos.

## 4. Elevation

El sistema es mayoritariamente plano, utilizando capas tonales en lugar de sombras pesadas.

**The Response Shadow Rule.** Los elementos solo proyectan sombras suaves cuando están en estado de "elevación" (ej. al ser presionados o al flotar sobre un fondo complejo).

## 5. Components

### Buttons
- **Shape:** Muy redondeado (16px).
- **Primary:** Fondo Indigo con texto blanco. Elevación sutil al presionar.
- **Secondary:** Borde Cyan con fondo transparente.

### Cards
- **Corner Style:** 24px.
- **Background:** Blanco puro sobre fondo Cloud Gray.
- **Border:** Borde sutil de 1px (#F0F0F0) para definición en pantallas de baja calidad.

### QR Container
- **Style:** Un área blanca central con bordes suavizados, diseñada para máxima legibilidad por los validadores de transporte.

## 6. Do's and Don'ts

### Do:
- **Do** usar espaciado de al menos 24px entre secciones principales.
- **Do** utilizar el radio de 24px para todos los contenedores de tarjetas.
- **Do** animar las transiciones de pantalla con un "fade-in" suave y un ligero desplazamiento vertical.

### Don't:
- **Don't** usar sombras negras puras. Usar sombras tintadas con Indigo.
- **Don't** usar el color rojo para nada que no sea un error crítico o eliminación de cuenta.
- **Don't** utilizar iconos con líneas demasiado delgadas; preferir iconos de peso "Medium" o "Semi-bold".

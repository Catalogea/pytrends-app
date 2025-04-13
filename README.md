# PyTrends Content Generator

Una aplicación web en Flutter para generar contenido basado en tendencias de Google Trends utilizando inteligencia artificial.

## Características Principales

### Panel de Control (Dashboard)
- Visualización de estadísticas de artículos generados
- Métricas de rendimiento y actividad
- Información del modelo de IA actual

### Tendencias en Tiempo Real
- Integración con Google Trends mediante PyTrends
- Filtros por país, categoría y periodo de tiempo
- Visualización detallada de tendencias

### Generación de Contenido con IA
- Múltiples modelos de IA disponibles (GPT-4, Claude, Mistral)
- Editor de texto enriquecido
- Optimización SEO automática

### Gestión de Artículos
- Organización por categorías
- Sistema de búsqueda y filtrado
- Exportación en múltiples formatos

## Requisitos Técnicos

- Flutter SDK >=3.0.0 <4.0.0
- Python (para PyTrends)
- Conexión a Internet
- API Keys para servicios de IA

## Configuración

1. Instalar dependencias:
```bash
flutter pub get
```

2. Configurar Firebase:
- Crear un proyecto en Firebase
- Agregar las credenciales en `lib/main.dart`

3. Configurar API Keys:
- OpenAI
- Claude (opcional)
- Mistral (opcional)

## Ejecución

```bash
flutter run -d chrome
```

## Estructura del Proyecto

```
lib/
  ├── main.dart
  ├── screens/
  │   ├── home_screen.dart
  │   ├── trends_screen.dart
  │   ├── interests_screen.dart
  │   ├── editor_screen.dart
  │   ├── articles_screen.dart
  │   └── settings_screen.dart
  └── services/
      └── theme_provider.dart
```

## Licencia

MIT
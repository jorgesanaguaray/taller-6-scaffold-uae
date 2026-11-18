# Verificación del Taller 6

Fecha: 18 de noviembre de 2026.

## Entorno

- Flutter 3.47.7, canal stable.
- Dart 3.13.5.
- Emulador Android Pixel 5, identificado como `emulator-5554`.
- Aplicación Android: `ec.edu.uae.hola_uae`.

## Resultados

| Comprobación | Resultado |
| --- | --- |
| `flutter analyze --fatal-infos --fatal-warnings` | Sin errores, advertencias ni observaciones |
| `flutter test --reporter expanded` | 6 pruebas aprobadas |
| `flutter build apk --debug` | APK generado correctamente |
| Instalación del APK con ADB | `Success` |
| Inicio de la app en el emulador | Pantalla «Hola UAE» y botón «Saludar» visibles |
| Pulsación de «Saludar» | Texto de resultado y SnackBar «¡Bienvenido a la UAE!» |
| Espera tras el saludo | El resultado permanece cuando se cierra el SnackBar |
| Acción de información | Diálogo de información visible |

## Evidencias

- [Pantalla inicial](capturas/inicio.png).
- [Saludo y SnackBar](capturas/saludo.png).
- [Resultado persistente](capturas/resultado-persistente.png).
- [Diálogo de información](capturas/informacion.png).
- [Árbol del proyecto](capturas/estructura-proyecto.png), captura del proyecto abierto en Android Studio con las carpetas de `lib/` y `test/` expandidas.
- [Árbol en texto](estructura.txt).

Las capturas de la app proceden del emulador Android con el APK compilado de este proyecto.

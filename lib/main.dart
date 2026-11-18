import 'package:flutter/material.dart'; // Importa los widgets de Material.

import 'presentation/screens/home/home_screen.dart'; // Importa la pantalla inicial.

// Flutter comienza la ejecución en esta función.
void main() {
  runApp(const HolaUaeApp()); // Monta el widget raíz de la aplicación.
} // Finaliza el punto de entrada.

// Configura el tema y la pantalla que se abre al iniciar.
class HolaUaeApp extends StatelessWidget {
  const HolaUaeApp({super.key}); // Recibe la clave del widget y permite const.

  @override // Implementa la construcción del widget raíz.
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hola UAE', // Identifica la aplicación.
      debugShowCheckedModeBanner: false, // Oculta el banner de desarrollo.
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF203C60), // Define el color principal.
        scaffoldBackgroundColor: Colors.white, // Usa un fondo blanco.
        useMaterial3: true, // Aplica los componentes de Material 3.
      ), // Finaliza el tema.
      home: const HomeScreen(), // Abre el screen organizado por feature.
    ); // Finaliza MaterialApp.
  } // Finaliza build.
} // Finaliza la aplicación.

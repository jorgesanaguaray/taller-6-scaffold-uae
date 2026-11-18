import 'package:flutter/material.dart'; // Proporciona Scaffold y sus widgets.
import 'package:flutter/services.dart'; // Controla el contraste de la barra del sistema.

// La pantalla principal es StatelessWidget, como indica el taller.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}); // Permite identificar y reutilizar el widget.

  // Explica la función de los elementos del taller al tocar información.
  void _showInformation(BuildContext context) {
    showDialog<void>(
      context: context, // Busca el navegador de esta pantalla.
      builder: (dialogContext) => AlertDialog(
        title: const Text('Acerca del taller'), // Presenta el diálogo.
        content: const Text(
          'Taller 6 · Lenguaje de Programación 5\n\n'
          'Scaffold organiza la pantalla, AppBar muestra el título y '
          'ScaffoldMessenger presenta el saludo en un SnackBar.',
        ), // Explica los widgets utilizados.
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(dialogContext).pop(), // Cierra el diálogo.
            child: const Text('Cerrar'), // Etiqueta de la acción.
          ), // Finaliza el botón del diálogo.
        ], // Finaliza las acciones.
      ), // Finaliza AlertDialog.
    ); // Muestra el diálogo.
  } // Finaliza la acción de información.

  @override // Construye la estructura fija de la pantalla.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hola UAE'), // Título solicitado en el AppBar.
        backgroundColor: const Color(0xFF203C60), // Aplica azul oscuro.
        foregroundColor: Colors.white, // Mantiene legibles título e icono.
        systemOverlayStyle:
            SystemUiOverlayStyle.light, // Usa iconos claros en Android.
        actions: [
          IconButton(
            tooltip: 'Información', // Describe el icono para accesibilidad.
            onPressed: () => _showInformation(context), // Abre la información.
            icon: const Icon(Icons.info_outline), // Identifica la acción.
          ), // Finaliza IconButton.
        ], // Finaliza la lista de acciones.
      ), // Finaliza AppBar.
      body: const SafeArea(
        child: _GreetingContent(
          key: Key('greeting-content'), // Identifica el contenido con estado.
        ), // Conserva el estado del saludo dentro de su propio widget.
      ), // Evita las áreas reservadas del dispositivo.
    ); // Devuelve el Scaffold de la pantalla.
  } // Finaliza build.
} // Finaliza HomeScreen.

// Este widget conserva únicamente el resultado que cambia al saludar.
class _GreetingContent extends StatefulWidget {
  const _GreetingContent({
    super.key,
  }); // Acepta key y permite construcción const.

  @override // Crea el estado asociado al contenido.
  State<_GreetingContent> createState() => _GreetingContentState();
} // Finaliza el widget con estado.

// El estado pertenece al contenido, por lo que HomeScreen sigue siendo stateless.
class _GreetingContentState extends State<_GreetingContent> {
  static const _welcome =
      '¡Bienvenido a la UAE!'; // Mantiene el mensaje exacto.
  bool _hasGreeted = false; // Inicia sin mostrar el resultado persistente.

  // Actualiza el resultado y muestra el aviso temporal del saludo.
  void _greet() {
    setState(() {
      _hasGreeted = true; // Conserva el saludo aunque desaparezca el SnackBar.
    }); // Solicita reconstruir el contenido con el nuevo resultado.
    final messenger = ScaffoldMessenger.of(context); // Accede al mensajero.
    messenger
        .clearSnackBars(); // Descarta avisos pendientes de pulsaciones previas.
    messenger.showSnackBar(
      const SnackBar(
        content: Text(
          _welcome, // Muestra el saludo solicitado en el aviso.
          style: TextStyle(
            color: Color(0xFF9AE6A0), // Usa verde claro sobre fondo oscuro.
            fontWeight: FontWeight.bold, // Destaca el mensaje.
          ), // Finaliza el estilo del texto.
        ), // Finaliza el contenido del SnackBar.
        backgroundColor: Color(0xFF1D2B45), // Define el fondo del aviso.
        behavior: SnackBarBehavior.floating, // Separa el aviso de los bordes.
        duration: Duration(
          seconds: 4,
        ), // Mantiene el aviso visible cuatro segundos.
      ), // Finaliza SnackBar.
    ); // Presenta el aviso mediante ScaffoldMessenger.
  } // Finaliza la acción Saludar.

  @override // Dibuja el contenido con el resultado actual.
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight, // Centra en la altura disponible.
          ), // Permite crecer cuando hay poco espacio o texto grande.
          child: Padding(
            padding: const EdgeInsets.all(24), // Separa el texto de los bordes.
            child: Center(
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Ocupa solo la altura necesaria.
                children: [
                  const Text(
                    'Hola UAE', // Texto centrado de bienvenida.
                    textAlign:
                        TextAlign.center, // Centra también varias líneas.
                    style: TextStyle(
                      color: Color(0xFF192C49), // Aplica azul oscuro al título.
                      fontSize: 30, // Resalta el título principal.
                      fontWeight: FontWeight.bold, // Usa negrita.
                    ), // Finaliza el estilo del título.
                  ), // Finaliza el título del contenido.
                  const SizedBox(height: 8), // Separa título y subtítulo.
                  const Text(
                    'Scaffold · AppBar + body', // Identifica la estructura usada.
                    textAlign: TextAlign.center, // Centra el subtítulo.
                    style: TextStyle(
                      color: Color(0xFF667085),
                    ), // Usa gris legible.
                  ), // Finaliza el subtítulo.
                  const SizedBox(height: 32), // Separa el texto del botón.
                  ElevatedButton(
                    key: const Key(
                      'greet-button',
                    ), // Identifica la acción en pruebas.
                    onPressed: _greet, // Ejecuta el saludo al pulsar.
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D8B3C), // Fondo verde.
                      foregroundColor: Colors.white, // Texto blanco.
                      minimumSize: const Size(160, 50), // Tamaño táctil cómodo.
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24, // Conserva espacio lateral.
                        vertical: 12, // Permite crecer con el tamaño del texto.
                      ), // Finaliza el espaciado interior.
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Redondea esquinas.
                      ), // Finaliza la forma del botón.
                    ), // Finaliza el estilo del botón.
                    child: const Text('Saludar'), // Etiqueta solicitada.
                  ), // Finaliza ElevatedButton.
                  if (_hasGreeted) ...[
                    const SizedBox(
                      height: 24,
                    ), // Separa el resultado del botón.
                    Semantics(
                      liveRegion:
                          true, // Anuncia el resultado al lector de pantalla.
                      child: const Text(
                        _welcome, // Mantiene el resultado visible tras el aviso.
                        key: Key(
                          'greeting-result',
                        ), // Identifica el Text de resultado.
                        textAlign:
                            TextAlign.center, // Admite varias líneas centradas.
                        style: TextStyle(
                          color: Color(0xFF237232), // Usa verde con contraste.
                          fontWeight: FontWeight.bold, // Destaca el resultado.
                        ), // Finaliza el estilo del resultado.
                      ), // Finaliza el Text de resultado.
                    ), // Finaliza la región accesible.
                  ], // Incluye el resultado únicamente después de saludar.
                ], // Finaliza los elementos de la columna.
              ), // Finaliza Column.
            ), // Finaliza Center.
          ), // Finaliza Padding.
        ), // Finaliza ConstrainedBox.
      ), // Permite desplazarse en pantallas pequeñas o con texto ampliado.
    ); // Finaliza LayoutBuilder.
  } // Finaliza build.
} // Finaliza el estado del contenido.

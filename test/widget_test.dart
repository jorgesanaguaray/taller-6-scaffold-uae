import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hola_uae/main.dart';
import 'package:hola_uae/presentation/screens/home/home_screen.dart';

const greeting = '¡Bienvenido a la UAE!';

void main() {
  testWidgets('Muestra la pantalla inicial y oculta el banner de desarrollo', (
    tester,
  ) async {
    await tester.pumpWidget(const HolaUaeApp());

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.debugShowCheckedModeBanner, isFalse);
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(
      find.descendant(of: find.byType(AppBar), matching: find.text('Hola UAE')),
      findsOneWidget,
    );
    expect(find.text('Scaffold · AppBar + body'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Saludar'), findsOneWidget);
    expect(find.byTooltip('Información'), findsOneWidget);
    expect(find.text(greeting), findsNothing);
    expect(find.byType(SnackBar), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Saludar muestra el resultado y un SnackBar temporal', (
    tester,
  ) async {
    await tester.pumpWidget(const HolaUaeApp());
    await tester.tap(find.widgetWithText(ElevatedButton, 'Saludar'));
    await tester.pumpAndSettle();

    expect(find.text(greeting), findsNWidgets(2));
    expect(find.widgetWithText(SnackBar, greeting), findsOneWidget);

    // El resultado permanece cuando termina la notificación temporal.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.byType(SnackBar), findsNothing);
    expect(find.text(greeting), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Los saludos rápidos no acumulan notificaciones', (tester) async {
    await tester.pumpWidget(const HolaUaeApp());
    final button = find.widgetWithText(ElevatedButton, 'Saludar');

    // Reproduce varias pulsaciones antes de terminar la animación de entrada.
    await tester.tap(button);
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(button);
    await tester.tap(button);
    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.widgetWithText(SnackBar, greeting), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.byType(SnackBar), findsNothing);
    expect(find.text(greeting), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('La acción Información abre y cierra el diálogo', (tester) async {
    await tester.pumpWidget(const HolaUaeApp());
    await tester.tap(find.byTooltip('Información'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Cerrar'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.widgetWithText(ElevatedButton, 'Saludar'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  for (final size in [const Size(320, 480), const Size(480, 320)]) {
    testWidgets('Funciona en pantalla $size con texto ampliado', (
      tester,
    ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      await tester.pumpWidget(const HolaUaeApp());
      expect(tester.takeException(), isNull);

      final button = find.widgetWithText(ElevatedButton, 'Saludar');
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pumpAndSettle();
      expect(find.text(greeting), findsNWidgets(2));
      expect(tester.takeException(), isNull);
    });
  }
}

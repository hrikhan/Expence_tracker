// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_tracker/app.dart';
import 'package:expense_tracker/features/authentication/presentation/screens/splash_screen.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    final dpi = tester.binding.platformDispatcher.views.first.devicePixelRatio;
    tester.binding.platformDispatcher.views.first.physicalSize = Size(360 * dpi, 875 * dpi);

    await tester.pumpWidget(const MyApp());
    expect(find.byType(SplashScreen), findsOneWidget);

    // Flush the splash screen navigation timer and animations
    await tester.pump(const Duration(seconds: 4));
  });
}

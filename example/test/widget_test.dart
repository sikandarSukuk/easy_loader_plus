import 'package:easy_loader_plus/easy_loader_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../main.dart';

void main() {
  // A finder that is specific to the FadeTransition inside the EasyLoaderWidget.
  // This prevents the test from failing due to other FadeTransitions in the app.
  final loaderFadeTransition = find.descendant(
    of: find.byType(EasyLoaderWidget),
    matching: find.byType(FadeTransition),
  );

  setUp(() => EasyLoader.reset());

  testWidgets('tap on show loader displays the loader and it dismisses', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // 1. Initially, no loader content should be visible.
    expect(loaderFadeTransition, findsNothing, reason: 'Loader should be hidden initially');

    // 2. Tap the button to show the loader.
    await tester.tap(find.byKey(const Key('show_loader_button')));
    await tester.pumpAndSettle();

    // 3. The loader content should now be visible.
    expect(loaderFadeTransition, findsOneWidget, reason: 'Loader should be visible after tap');
    expect(find.text('Loading...'), findsOneWidget);

    // 4. Wait for the loader to be dismissed and for animations to complete.
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(loaderFadeTransition, findsNothing, reason: 'Loader should be hidden after dismiss');
  });

  testWidgets('tap on show success displays and auto-dismisses', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(const Key('show_success_button')));
    await tester.pumpAndSettle();

    // The success toast should be visible.
    expect(loaderFadeTransition, findsOneWidget);
    expect(find.text('Success!'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);

    // Wait for the toast to auto-dismiss and for animations to complete.
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(loaderFadeTransition, findsNothing, reason: 'Success toast should auto-dismiss');
  });

  testWidgets('tap on show error displays and auto-dismisses', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(const Key('show_error_button')));
    await tester.pumpAndSettle();

    // The error toast should be visible.
    expect(loaderFadeTransition, findsOneWidget);
    expect(find.text('Error!'), findsOneWidget);
    expect(find.byIcon(Icons.close), findsOneWidget);

    // Wait for the toast to auto-dismiss and for animations to complete.
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(loaderFadeTransition, findsNothing, reason: 'Error toast should auto-dismiss');
  });
}

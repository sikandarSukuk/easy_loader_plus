import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:easy_loader_plus/easy_loader_plus.dart';

void main() {
  testWidgets('EasyLoader initial state is hidden', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: EasyLoader.init(),
        home: const Scaffold(
          body: Center(
            child: Text('Test'),
          ),
        ),
      ),
    );

    expect(EasyLoader.isShow, isFalse);
  });

  testWidgets('show/dismiss updates isShow state', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: EasyLoader.init(),
        home: const Scaffold(
          body: Center(
            child: Text('Test'),
          ),
        ),
      ),
    );

    // Use runAsync to allow Futures within the loader to complete
    await tester.runAsync(() async {
      await EasyLoader.show();
    });

    // Rebuild the widget tree
    await tester.pump();

    expect(EasyLoader.isShow, isTrue);
    expect(find.byType(EasyLoaderWidget), findsOneWidget);

    await tester.runAsync(() async {
      await EasyLoader.dismiss();
    });

    // Pump and settle to allow animations to finish
    await tester.pumpAndSettle();

    expect(EasyLoader.isShow, isFalse);
    expect(find.byType(EasyLoaderWidget), findsNothing);
  });
}

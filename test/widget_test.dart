import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calculatrice_scientifique/main.dart';

void main() {
  testWidgets('Calculator button press test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify initial state
    expect(find.text('0'), findsOneWidget); // Check if '0' is displayed initially
    expect(find.text('1'), findsNothing); // Check if '1' is not displayed initially

    // Tap the button '1' and trigger a frame.
    await tester.tap(find.widgetWithText(ElevatedButton, '1'));
    await tester.pump();

    // Verify state after tapping '1'
    expect(find.text('0'), findsNothing); // Check if '0' is no longer displayed
    expect(find.text('1'), findsOneWidget); // Check if '1' is displayed after tapping

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify state after tapping '+'
    expect(find.text('1'), findsNothing); // Check if '1' is no longer displayed
    expect(find.text('1'), findsOneWidget); // Check if '1' remains displayed (indicating operation)

    // Example of further testing steps can be added here for a comprehensive test suite
  });
}

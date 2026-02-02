import 'package:flutter_test/flutter_test.dart';
import 'package:workspace/main.dart';

void main() {
  group('Calculator UI Tests', () {
    testWidgets('Calculator app launches successfully', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());
      expect(find.text('Liam\'s Calculator app made with CoPilot'), findsWidgets);
    });

    testWidgets('Display shows 0 initially', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());
      expect(find.text('0'), findsWidgets);
    });
  });
}


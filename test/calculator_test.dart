import 'package:expressions/expressions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calculator Expression Tests', () {
    test('Simple addition: 2 + 3 = 5', () {
      final exp = Expression.parse('2+3');
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(exp, {});
      expect(result, equals(5));
    });

    test('Simple subtraction: 10 - 4 = 6', () {
      final exp = Expression.parse('10-4');
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(exp, {});
      expect(result, equals(6));
    });

    test('Simple multiplication: 3 * 4 = 12', () {
      final exp = Expression.parse('3*4');
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(exp, {});
      expect(result, equals(12));
    });

    test('Simple division: 12 / 4 = 3', () {
      final exp = Expression.parse('12/4');
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(exp, {});
      expect(result, equals(3));
    });

    test('Order of operations: 2 + 3 * 4 = 14', () {
      final exp = Expression.parse('2+3*4');
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(exp, {});
      expect(result, equals(14));
    });

    test('Order of operations: 10 - 2 * 3 = 4', () {
      final exp = Expression.parse('10-2*3');
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(exp, {});
      expect(result, equals(4));
    });

    test('Complex expression: (2 + 3) * 4 = 20', () {
      final exp = Expression.parse('(2+3)*4');
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(exp, {});
      expect(result, equals(20));
    });

    test('Division with decimals: 5 / 2 = 2.5', () {
      final exp = Expression.parse('5/2');
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(exp, {});
      expect(result, equals(2.5));
    });

    test('Decimal numbers: 1.5 + 2.5 = 4', () {
      final exp = Expression.parse('1.5+2.5');
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(exp, {});
      expect(result, equals(4));
    });

    test('Zero multiplication: 5 * 0 = 0', () {
      final exp = Expression.parse('5*0');
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(exp, {});
      expect(result, equals(0));
    });

    test('Division by zero returns Infinity', () {
      final exp = Expression.parse('5/0');
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(exp, {});
      expect(result.isInfinite, equals(true));
    });

    test('Negative numbers: -5 + 3 = -2', () {
      final exp = Expression.parse('-5+3');
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(exp, {});
      expect(result, equals(-2));
    });

    test('Multiple operations: 10 + 5 - 3 * 2 = 9', () {
      final exp = Expression.parse('10+5-3*2');
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(exp, {});
      expect(result, equals(9));
    });
  });
}

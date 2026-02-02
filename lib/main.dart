import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liam\'s Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String expression = '';
  String result = '0';
  String displayText = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liam\'s Calculator App Made With CoPilot'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display Area
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Expression Display (Accumulator)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Text(
                          expression.isEmpty ? '0' : expression,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Result Display
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Text(
                          displayText,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Buttons Grid
                GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildButton(
                      'C',
                      onPressed: _clearDisplay,
                      isOperator: true,
                    ),
                    _buildButton('←', onPressed: _backspace, isOperator: true),
                    _buildButton(
                      '/',
                      onPressed: () => _appendOperator('/'),
                      isOperator: true,
                    ),
                    _buildButton(
                      '*',
                      onPressed: () => _appendOperator('*'),
                      isOperator: true,
                    ),
                    _buildButton('7', onPressed: () => _appendNumber('7')),
                    _buildButton('8', onPressed: () => _appendNumber('8')),
                    _buildButton('9', onPressed: () => _appendNumber('9')),
                    _buildButton(
                      '-',
                      onPressed: () => _appendOperator('-'),
                      isOperator: true,
                    ),
                    _buildButton('4', onPressed: () => _appendNumber('4')),
                    _buildButton('5', onPressed: () => _appendNumber('5')),
                    _buildButton('6', onPressed: () => _appendNumber('6')),
                    _buildButton(
                      'x²',
                      onPressed: _squareNumber,
                      isOperator: true,
                    ),
                    _buildButton('1', onPressed: () => _appendNumber('1')),
                    _buildButton('2', onPressed: () => _appendNumber('2')),
                    _buildButton('3', onPressed: () => _appendNumber('3')),
                    _buildButton(
                      '+',
                      onPressed: () => _appendOperator('+'),
                      isOperator: true,
                    ),
                    _buildButton('0', onPressed: () => _appendNumber('0')),
                    _buildButton('.', onPressed: () => _appendDecimal()),
                    _buildButton('00', onPressed: () => _appendNumber('00')),
                    _buildButton(
                      '=',
                      onPressed: _calculateResult,
                      isEquals: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    String label, {
    required VoidCallback onPressed,
    bool isOperator = false,
    bool isEquals = false,
  }) {
    Color buttonColor;
    Color textColor = Colors.black;

    if (isEquals) {
      buttonColor = Colors.lightBlue[400]!;
    } else if (isOperator) {
      buttonColor = Colors.lightBlue[300]!;
    } else {
      buttonColor = Colors.grey[300]!;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _appendNumber(String number) {
    setState(() {
      if (expression.isEmpty ||
          expression.endsWith('+') ||
          expression.endsWith('-') ||
          expression.endsWith('*') ||
          expression.endsWith('/')) {
        expression += number;
      } else {
        expression += number;
      }
      _updateDisplay();
    });
  }

  void _appendOperator(String operator) {
    setState(() {
      if (expression.isEmpty) {
        return;
      }

      // Prevent multiple consecutive operators
      if (expression.endsWith('+') ||
          expression.endsWith('-') ||
          expression.endsWith('*') ||
          expression.endsWith('/')) {
        // Replace the last operator
        expression = expression.substring(0, expression.length - 1) + operator;
      } else {
        expression += operator;
      }
      _updateDisplay();
    });
  }

  void _appendDecimal() {
    setState(() {
      if (expression.isEmpty) {
        expression = '0.';
      } else {
        // Get the last number in the expression
        String lastNumber = _getLastNumber();

        if (!lastNumber.contains('.')) {
          expression += '.';
        }
      }
      _updateDisplay();
    });
  }

  String _getLastNumber() {
    String lastNumber = '';
    for (int i = expression.length - 1; i >= 0; i--) {
      if (expression[i] == '+' ||
          expression[i] == '-' ||
          expression[i] == '*' ||
          expression[i] == '/') {
        break;
      }
      lastNumber = expression[i] + lastNumber;
    }
    return lastNumber;
  }

  void _squareNumber() {
    setState(() {
      if (expression.isEmpty) {
        return;
      }

      try {
        // Get the last number in the expression
        String lastNumber = _getLastNumber();
        if (lastNumber.isEmpty) {
          return;
        }

        // Parse the last number and square it
        double number = double.parse(lastNumber);
        double squared = number * number;

        // Replace the last number with the squared result
        expression = expression.substring(0, expression.length - lastNumber.length);
        
        // Format squared result
        if (squared == squared.toInt()) {
          expression += squared.toInt().toString();
        } else {
          expression += squared.toString();
        }
        
        _updateDisplay();
      } catch (e) {
        // If parsing fails, do nothing
        return;
      }
    });
  }

  void _backspace() {
    setState(() {
      if (expression.isNotEmpty) {
        expression = expression.substring(0, expression.length - 1);
      }
      _updateDisplay();
    });
  }

  void _clearDisplay() {
    setState(() {
      expression = '';
      result = '0';
      displayText = '0';
    });
  }

  void _calculateResult() {
    setState(() {
      if (expression.isEmpty) {
        return;
      }

      try {
        // Use the expressions package to evaluate
        final Expression exp = Expression.parse(expression);
        final evaluator = const ExpressionEvaluator();
        final evalResult = evaluator.eval(exp, {});

        // Check for infinity (division by zero)
        if (evalResult is double && evalResult.isInfinite) {
          displayText = 'Error: Division by zero';
          result = 'Error';
          expression = expression + ' = Error: Division by zero';
        } else if (evalResult is double && evalResult.isNaN) {
          displayText = 'Error: Invalid operation';
          result = 'Error';
          expression = expression + ' = Error: Invalid operation';
        } else {
          result = evalResult.toString();
          // Format result to remove unnecessary decimals
          if (evalResult is double &&
              evalResult.toStringAsFixed(0) == evalResult.toString()) {
            result = evalResult.toStringAsFixed(0);
          }
          expression = expression + ' = ' + result;
          displayText = result;
        }
      } catch (e) {
        // Handle evaluation errors
        displayText = 'Error: Invalid expression';
        result = 'Error';
        expression = expression + ' = Error';
      }
    });
  }

  void _updateDisplay() {
    if (expression.isEmpty) {
      displayText = '0';
    } else if (expression.endsWith('+') ||
        expression.endsWith('-') ||
        expression.endsWith('*') ||
        expression.endsWith('/')) {
      displayText = expression;
    } else {
      try {
        // Try to evaluate and show live preview
        final Expression exp = Expression.parse(expression);
        final evaluator = const ExpressionEvaluator();
        final evalResult = evaluator.eval(exp, {});

        // Format result nicely
        if (evalResult is double) {
          if (evalResult.isInfinite) {
            displayText = 'Infinity';
          } else if (evalResult.isNaN) {
            displayText = 'NaN';
          } else if (evalResult == evalResult.toInt()) {
            displayText = evalResult.toInt().toString();
          } else {
            // Limit decimal places to 10
            displayText = double.parse(
              evalResult.toStringAsFixed(10),
            ).toString();
          }
        } else {
          displayText = evalResult.toString();
        }
      } catch (e) {
        // If evaluation fails, just show the expression
        displayText = expression;
      }
    }
  }
}

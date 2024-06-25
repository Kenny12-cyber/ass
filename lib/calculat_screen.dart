import 'package:flutter/material.dart';
import 'button_values.dart'; // Assuming you have defined Btn constants in button_values.dart

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = ''; // Holds the current display text
  double? num1; // Holds the first number
  String? operand; // Holds the current operand (+, -, *, /)
  double? num2; // Holds the second number

  // List of button values
  List<List<String>> buttonValues = [
    ['7', '8', '9', '/'],
    ['4', '5', '6', '*'],
    ['1', '2', '3', '-'],
    ['.', '0', '=', '+'],
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Output Display
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(16),
                child: Text(
                  display.isEmpty ? '0' : display,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ),

            // Buttons
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  itemCount: buttonValues.length * buttonValues[0].length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: buttonValues[0].length,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemBuilder: (context, index) {
                    // Calculate row and column index
                    int row = index ~/ buttonValues[0].length;
                    int col = index % buttonValues[0].length;
                    String value = buttonValues[row][col];
                    return buildButton(value);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build a calculator button
  Widget buildButton(String value) {
    return TextButton(
      onPressed: () => onButtonPressed(value),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: getButtonColor(value),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // Method to handle button press events
  void onButtonPressed(String value) {
    if (value == 'C') {
      clear();
    } else if (value == '=') {
      if (num1 != null && operand != null && display.isNotEmpty) {
        num2 = double.tryParse(display);
        calculate();
      }
    } else if (value == '+' || value == '-' || value == '*' || value == '/') {
      if (num1 == null && display.isNotEmpty) {
        num1 = double.tryParse(display);
        operand = value;
        display = '';
      }
    } else {
      display += value;
      setState(() {});
    }
  }

  // Method to perform the calculation based on operand
  void calculate() {
    switch (operand) {
      case '+':
        display = (num1! + num2!).toString();
        break;
      case '-':
        display = (num1! - num2!).toString();
        break;
      case '*':
        display = (num1! * num2!).toString();
        break;
      case '/':
        display = (num1! / num2!).toString();
        break;
      default:
        display = 'Error';
    }
    num1 = double.tryParse(display);
    operand = null;
    num2 = null;
    setState(() {});
  }

  // Method to clear the display and reset all values
  void clear() {
    display = '';
    num1 = null;
    operand = null;
    num2 = null;
    setState(() {});
  }

  // Method to get button color based on its value
  Color getButtonColor(String value) {
    return value == '=' || value == '+' || value == '-' || value == '*' || value == '/'
        ? Colors.orange
        : Colors.grey[800]!;
  }
}
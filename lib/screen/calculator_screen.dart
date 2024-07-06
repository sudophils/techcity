import 'package:flutter/material.dart';


class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _result = '0';
  String _operator = '';
  double _num1 = 0;
  double _num2 = 0;

  void _handleButtonClick(String label) {
    setState(() {
      if (label == 'AC') {
        _clear();
      } else if (label == '+/-') {
        _toggleSign();
      } else if (label == '%') {
        _calculatePercentage();
      } else if (['+', '-', 'x', '/'].contains(label)) {
        _setOperator(label);
      } else if (label == '=') {
        _calculate();
      } else if (label == '.') {
        _addDecimal();
      } else {
        _appendNumber(label);
      }
    });
  }

  void _clear() {
    _input = '';
    _result = '0';
    _operator = '';
    _num1 = 0;
    _num2 = 0;
  }

  void _toggleSign() {
    if (_input.isNotEmpty) {
      if (_input.startsWith('-')) {
        _input = _input.substring(1);
      } else {
        _input = '-$_input';
      }
      _result = _input;
    }
  }

  void _calculatePercentage() {
    if (_input.isNotEmpty) {
      double value = double.parse(_input) / 100;
      _input = value.toString();
      _result = _input;
    }
  }

  void _setOperator(String op) {
    if (_input.isNotEmpty) {
      _num1 = double.parse(_input);
      _operator = op;
      _input = '';
    }
  }

  void _calculate() {
    if (_input.isNotEmpty && _operator.isNotEmpty) {
      _num2 = double.parse(_input);
      switch (_operator) {
        case '+':
          _result = (_num1 + _num2).toString();
          break;
        case '-':
          _result = (_num1 - _num2).toString();
          break;
        case 'x':
          _result = (_num1 * _num2).toString();
          break;
        case '/':
          _result = (_num1 / _num2).toString();
          break;
      }
      _input = _result;
      _operator = '';

    }
  }

  void _addDecimal() {
    if (!_input.contains('.')) {
      _input += _input.isEmpty ? '0.' : '.';
      _result = _input;
    }
  }

  void _appendNumber(String number) {
    _input += number;
    _result = _input;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 28.0, bottom: 48),
                child: Text(
                  _result,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ),
            ),
            ...buildButtonRows()
          ],
        ),
      ),
    );
  }


  List<Widget> buildButtonRows() {
    final buttonData = [
      ['AC', '+/-', '%', '/'],
      ['7', '8', '9', 'x'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['0', '.', '='],
    ];

    return buttonData.map((row) => buildButtonRow(row)).toList();
  }

  Widget buildButtonRow(List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items.map((label) => calculatorButton(label)).toList(),
      ),
    );
  }

  /// button
  Widget calculatorButton(String label) {
    final isZeroButton = label == '0';
    final isOperator = ['+', '-', 'x', '/', '='].contains(label);
    final isSpecial = ['AC', '+/-', '%'].contains(label);

    return GestureDetector(
      onTap: () => _handleButtonClick(label),
      child: isZeroButton
          ? Container(
              height: 66,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(50)),
              width: MediaQuery.of(context).size.width * .4,
              child: const Center(
                child: Text(
                  '0',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ))
          : CircleAvatar(
              backgroundColor: isOperator
                  ? Colors.orange
                  : isSpecial
                      ? Colors.grey
                      : Colors.grey.shade800,
              radius: 40,
              child: Text(
                label,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
    );
  }
}

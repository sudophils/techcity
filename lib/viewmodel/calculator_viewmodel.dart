import 'package:scoped_model/scoped_model.dart';

class CalculatorViewModel extends Model {
  String _input = '';
  String _result = '0';
  String _operator = '';
  double _num1 = 0;
  double _num2 = 0;

  String get result => _result;


  void handleButtonClick(String label) {
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
  }

  void _clear() {
    _input = '';
    _result = '0';
    _operator = '';
    _num1 = 0;
    _num2 = 0;
    notifyListeners();
  }

  void _toggleSign() {
    if (_input.isNotEmpty) {
      if (_input.startsWith('-')) {
        _input = _input.substring(1);
      } else {
        _input = '-$_input';
      }
      _result = _input;
      notifyListeners();
    }
  }

  void _calculatePercentage() {
    if (_input.isNotEmpty) {
      double value = double.parse(_input) / 100;
      _input = value.toString();
      _result = _input;
      notifyListeners();
    }
  }

  void _setOperator(String op) {
    if (_input.isNotEmpty) {
      _num1 = double.parse(_input);
      _operator = op;
      _input = '';
      notifyListeners();
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
      notifyListeners();
    }
  }

  void _addDecimal() {
    if (!_input.contains('.')) {
      _input += _input.isEmpty ? '0.' : '.';
      _result = _input;
      notifyListeners();
    }
  }

  void _appendNumber(String number) {
    _input += number;
    _result = _input;
    notifyListeners();
  }
}

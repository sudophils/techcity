import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../viewmodel/calculator_viewmodel.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final calcModel = CalculatorViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: ScopedModel<CalculatorViewModel>(
        model: calcModel,
        child: ScopedModelDescendant<CalculatorViewModel>(
          builder: (context, child, model) {
            return SafeArea(
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
                        model.result,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  ...buildButtonRows()
                ],
              ),
            );
          },
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
      onTap: () => calcModel.handleButtonClick(label),
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

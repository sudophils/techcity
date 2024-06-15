import 'package:flutter/material.dart';

class TechCityAppButton extends StatelessWidget {
  final String label;
  final bool showBg;

  const TechCityAppButton(
      {super.key, required this.showBg, required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
            color: showBg ? Colors.white : Colors.transparent,
            border: showBg ? null : Border.all(width: 2, color: Colors.white),
            borderRadius: BorderRadius.circular(15)),
        width: 200,
        height: 45,
        child: Center(
            child: Text(label,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: showBg ? Colors.blueAccent : Colors.white))),
      ),
    );
  }
}

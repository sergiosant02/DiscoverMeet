import 'package:flutter/material.dart';

class OptionBox extends StatelessWidget {
  OptionBox({super.key, required this.child});
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 0.8,
            spreadRadius: 0.2,
          )
        ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: child);
  }
}

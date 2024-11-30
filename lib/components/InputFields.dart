import "package:flutter/material.dart";

class FarmTextInput extends StatelessWidget {
  const FarmTextInput({
    super.key,
    required this.controller,
    required this.inputLabel,
    required this.keyboardType,
  });
  
  final controller;
  final inputLabel;
  final keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            labelText: inputLabel,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 1.0)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 3.0))),
      ),
    );
  }
}

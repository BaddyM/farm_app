import "package:flutter/material.dart";

class FarmTextInput extends StatelessWidget {
  const FarmTextInput({
    super.key,
    required this.controller,
    required this.inputLabel,
    required this.keyboardType,
    this.readOnly
  });
  
  final controller;
  final inputLabel;
  final keyboardType;
  final readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: TextFormField(
        readOnly: readOnly==null?false:true,
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            labelText: inputLabel,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3.0))),
      ),
    );
  }
}

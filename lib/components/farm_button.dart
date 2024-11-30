import 'package:flutter/material.dart';

class FarmButton extends StatelessWidget {
  const FarmButton({super.key, required this.buttonLabel});
  final buttonLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(2,2),
            spreadRadius: 1,
            blurRadius: 8,
          )
        ],
       color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(50.0))
      ),
      child: Center(
        child: Text(buttonLabel,style:
        const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,),),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FarmButton extends StatelessWidget {
  const FarmButton({super.key, required this.buttonLabel});
  final buttonLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2.0),
       color: Colors.brown,
        borderRadius: BorderRadius.circular(50.0)
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

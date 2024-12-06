import "package:flutter/material.dart";

class FarmCard extends StatelessWidget {
  const FarmCard({super.key, this.cardLabel, this.cardValue});
  final cardLabel;
  final cardValue;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7.0),
      child: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
            color: Colors.lightGreenAccent,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(2, 2),
                  blurRadius: 5,
                  spreadRadius: 7
              )
            ]
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(cardLabel,style: TextStyle(fontWeight: FontWeight.bold),),
            Divider(color: Colors.grey,indent: MediaQuery.of(context).size.width * 0.2,
              endIndent: MediaQuery.of(context).size.width * 0.2,),
            Text(cardValue,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),)
          ],
        ),
      ),
    );
  }
}

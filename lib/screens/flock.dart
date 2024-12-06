import "package:flutter/material.dart";

class FarmFlock extends StatefulWidget {
  const FarmFlock({super.key});

  @override
  State<FarmFlock> createState() => _FarmFlockState();
}

class _FarmFlockState extends State<FarmFlock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[300],
      appBar: AppBar(
        shadowColor: Colors.grey,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5.0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          "Flock",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {
          }),
    );
  }
}

import 'package:flutter/material.dart';

class FarmDrawer extends StatelessWidget {
  const FarmDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.lightGreenAccent,
      ),
    );
  }
}

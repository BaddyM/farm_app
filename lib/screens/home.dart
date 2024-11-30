import "package:farm_app/components/appbar.dart";
import "package:farm_app/components/drawer.dart";
import "package:flutter/material.dart";

class FarmHome extends StatefulWidget {
  const FarmHome({super.key, this.title});
  final title;

  @override
  State<FarmHome> createState() => _FarmHomeState();
}

class _FarmHomeState extends State<FarmHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FarmAppBar(title: widget.title,),
      drawer: FarmDrawer(),
    );
  }
}

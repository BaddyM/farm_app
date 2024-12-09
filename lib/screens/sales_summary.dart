import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';

class FarmSalesSummary extends StatefulWidget {
  const FarmSalesSummary({super.key});

  @override
  State<FarmSalesSummary> createState() => _FarmSalesSummaryState();
}

class _FarmSalesSummaryState extends State<FarmSalesSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.grey,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5.0,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          "Sales Summary",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

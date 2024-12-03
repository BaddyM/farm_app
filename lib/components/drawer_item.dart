import "package:flutter/material.dart";

class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key, required this.image, required this.label, this.route});
  final image;
  final label;
  final route;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(2,0),
            blurRadius: 7,
            spreadRadius: 1
          )
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/icons/${image}",
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
          Text(label,style: const TextStyle(
            fontSize: 18
          ),)
        ],
      ),
    );
  }
}

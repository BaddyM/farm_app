import 'package:flutter/material.dart';

class FarmAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FarmAppBar({super.key, this.title});
  final title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(
            Icons.menu_rounded,
            color: Colors.white,
            size: MediaQuery.of(context).size.width * 0.09,
          )),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(onPressed: (){},
            icon: Icon(Icons.person_rounded,color: Colors.white,))
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60.0);
}

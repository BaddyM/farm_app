import 'package:farm_app/screens/profile.dart';
import 'package:flutter/material.dart';

class FarmAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FarmAppBar({super.key, this.title});
  final title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 5.0,
      shadowColor: Colors.brown,
      leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Image.asset("assets/images/icons/2203529_app_block_menu_setting_tile_icon.png")),
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.white,fontWeight: FontWeight.bold,
        fontFamily: "valentina",
        fontSize: 35),
      ),
      actions: [
        IconButton(onPressed: (){
          Navigator.pushNamed(context,"userProfile");
        },
            icon: const Icon(Icons.person_rounded,color: Colors.white,))
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60.0);
}

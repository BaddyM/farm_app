import 'package:flutter/material.dart';
import "package:go_router/go_router.dart";
import "package:hugeicons/hugeicons.dart";

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
          icon: const HugeIcon(icon: HugeIcons.strokeRoundedDashboardCircle,color: Colors.white,)),
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
          context.push("/userprofile");
        },
            icon: const HugeIcon(icon:HugeIcons.strokeRoundedUserCircle,color: Colors.white,))
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60.0);
}

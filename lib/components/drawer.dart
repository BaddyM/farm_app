import 'package:farm_app/components/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FarmDrawer extends StatelessWidget {
  const FarmDrawer({super.key, this.title, this.version});
  final title;
  final version;

  @override
  Widget build(BuildContext context) {
    var labels = ["Chicks","Flock","Sales Summary","Settings"];
    var images = [
      "10393933_spring_holiday_vacation_chick_icon.png",
      "6330643_accept_check_list_lists_orders_icon.png",
      "3671721_calendar_icon.png",
      "2849830_multimedia_options_setting_settings_gear_icon.png"
    ];
    var routes = [
      "/chicks",
      "/flock",
      "/sales",
      "/settings",
    ];

    return SafeArea(
      child: Drawer(
        backgroundColor: Theme.of(context).primaryColor,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/icons/MarketFair2.png",
                    width: 100,
                      height: 100,
                    ),
                    Text(title,style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "valentina",
                      fontSize:25,
                      fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
              ),            
              for(int i=0; i<labels.length; i++)
              GestureDetector(
                onTap: (){
                  context.pop(context);
                  context.go(routes[i]);
                },
                child: DrawerItem(image: images[i],label: labels[i],),
              ),
              Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                  child: Text("Version: ${version}", style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),))
            ],
          ),
        ),
      ),
    );
  }
}

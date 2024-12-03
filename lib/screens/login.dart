import 'dart:ui';

import 'package:farm_app/components/farm_button.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class UserLogin extends StatelessWidget {
  final title;
  const UserLogin({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      width: double.maxFinite,
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image:
                  AssetImage("assets/images/background/brown_background.jpeg"),
              fit: BoxFit.cover)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                //color: Colors.white.withOpacity(0.3),
                gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: [Colors.white60, Colors.white10]),
                border:
                    Border.all(color: Colors.white.withOpacity(0.9), width: 2)),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    fontFamily: "valentina",
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.black,
                  ),
                ),
                Divider(
                  color: Colors.white,
                  thickness: 2.0,
                  indent: MediaQuery.of(context).size.width * 0.1,
                  endIndent: MediaQuery.of(context).size.width * 0.1,
                ),
                Container(
                    width: double.maxFinite,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 5.0),
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        fontFamily: "roboto-bold",
                      ),
                    )),
                Container(
                  width: double.maxFinite,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                      "Please login to access all the features of ${title}"),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Pinput(
                    obscureText: true,
                    defaultPinTheme: const PinTheme(
                      height: 70,
                      width: 70,
                      textStyle: TextStyle(fontSize: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.brown,
                                offset: Offset.zero,
                                blurRadius: 6,
                                spreadRadius: 1)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    obscuringCharacter: "*",
                    onCompleted: (values) {},
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 10.0),
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Have no account yet?"),
                      const SizedBox(
                        width: 7.0,
                      ),
                      GestureDetector(
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

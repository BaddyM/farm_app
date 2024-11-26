import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class UserLogin extends StatelessWidget {
  final title;
  const UserLogin({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.green,
          Colors.lightGreen,
          Colors.yellowAccent
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Welcome to ${title}",
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Enter your PIN to have full access to ${title} features",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.yellow,
                          offset: Offset(0, -1),
                          blurRadius: 10,
                          spreadRadius: 1)
                    ]),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Pinput(
                        obscureText: true,
                        defaultPinTheme: const PinTheme(
                          height: 70,
                          width: 70,
                          textStyle: TextStyle(fontSize: 20),
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.yellow,
                                    offset: Offset.zero,
                                    blurRadius: 10,
                                    spreadRadius: 1)
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ),
                        obscuringCharacter: "*",
                        onCompleted: (values) {},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.green,
                              decoration: TextDecoration.underline),
                        ),
                        onTap: () {},
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

import 'package:farm_app/components/InputFields.dart';
import 'package:farm_app/components/farm_button.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class UserRegistration extends StatefulWidget {
  final title;
  const UserRegistration({super.key, this.title});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  TextEditingController _farmName = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  var _pin = "";

  @override
  Widget build(BuildContext context) {
    bool processing = false;
    bool buttonVisible = true;

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
                    "Register",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Welcome to ${widget.title}",
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.yellow,
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
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        FarmTextInput(
                          controller: _farmName,
                          inputLabel: "Farm Name",
                          keyboardType: TextInputType.text,
                        ),
                        FarmTextInput(
                            controller: _userName,
                            inputLabel: "UserName",
                            keyboardType: TextInputType.text),
                        FarmTextInput(
                            controller: _phoneNumber,
                            inputLabel: "Phone Number",
                            keyboardType: TextInputType.number),
                        Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            child: const Text("PIN")),
                        Pinput(
                          obscureText: true,
                          defaultPinTheme: const PinTheme(
                            height: 70,
                            width: 70,
                            textStyle: TextStyle(fontSize: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset.zero,
                                      blurRadius: 6,
                                      spreadRadius: 1)
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                          obscuringCharacter: "*",
                          onCompleted: (values) {
                            setState(() {
                              _pin = values;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "If already registered, then",
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.green,
                                    decoration: TextDecoration.underline),
                              ),
                              onTap: () {},
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: (){
                            print("Tapped");
                          },
                          child: Visibility(
                            visible: buttonVisible,
                              child: const FarmButton(buttonLabel: "Register")),
                        ),
                        Visibility(
                          visible: processing,
                            child: const Center(child: CircularProgressIndicator(color: Colors.green,),))
                      ],
                    ),
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

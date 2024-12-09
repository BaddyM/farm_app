import 'package:farm_app/components/InputFields.dart';
import 'package:farm_app/components/farm_button.dart';
import 'package:farm_app/models/database_service.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import "package:go_router/go_router.dart";

class UserRegistration extends StatefulWidget {
  final title;
  const UserRegistration({super.key, this.title});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  DatabaseService _databaseService = DatabaseService.instance;
  TextEditingController _farmName = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  var _pin = "";

  @override
  Widget build(BuildContext context) {
    bool processing = false;
    bool buttonVisible = true;

    return Scaffold(
        body: Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/background/brown_background.jpeg",
              ),
              fit: BoxFit.cover)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [Colors.white60, Colors.white10]),
                  border: Border.all(
                      color: Colors.white.withOpacity(0.9), width: 2)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
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
                        //margin: const EdgeInsets.symmetric(vertical: 1.0),
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            fontFamily: "roboto-bold",
                          ),
                        )),
                    Visibility(
                      visible: false,
                      child: FarmTextInput(
                          controller: _farmName,
                          inputLabel: "Farm Name",
                          keyboardType: TextInputType.text),
                    ),
                    FarmTextInput(
                        controller: _userName,
                        inputLabel: "UserName",
                        keyboardType: TextInputType.text),
                    Visibility(
                      visible: false,
                      child: FarmTextInput(
                          controller: _phoneNumber,
                          inputLabel: "Phone Number",
                          keyboardType: TextInputType.number),
                    ),
                    Container(
                      width: double.maxFinite,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 10.0),
                      child: const Text(
                        "PIN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10.0),
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
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      //padding: const EdgeInsets.only(top: 10.0),
                      margin: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Have an account already?",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 7.0,
                          ),
                          GestureDetector(
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                            onTap: () {
                              context.pop();
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: GestureDetector(
                          onTap: (){
                            try{
                              _databaseService.saveNewUserProfile(_userName.text, _pin);
                              context.go("/login");
                            }catch(e){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.black87,
                                      content: Text("Sorry, something went wrong!",style: TextStyle(color: Colors.white),)
                                  )
                              );
                            }
                          },
                            child: const FarmButton(buttonLabel: "Register")
                        )
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

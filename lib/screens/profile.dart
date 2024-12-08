import "package:farm_app/components/InputFields.dart";
import "package:farm_app/components/farm_button.dart";
import "package:farm_app/models/database_service.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:pinput/pinput.dart';
import 'package:go_router/go_router.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final DatabaseService _databaseService = DatabaseService.instance;
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  String pin = "";
  String userStatus = "";
  String userID = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[300],
      appBar: AppBar(
        shadowColor: Colors.grey,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5.0,
        leading: IconButton(
            onPressed: () {
              context.go("/");
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          "User Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: _databaseService.getUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.length == 1) {
                userStatus = "available";
                _userName.text = snapshot.data?[0]["username"];
                _pinController.text = snapshot.data![0]["pin"].toString();
                userID = snapshot.data![0]["id"].toString();
              } else {
                userStatus = "new";
              }
              return Column(
                children: [
                  FarmTextInput(
                      controller: _userName,
                      inputLabel: "User Name",
                      keyboardType: TextInputType.text),
                  Container(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Pinput(
                      controller: _pinController,
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
                        pin = values;
                      },
                      onChanged: (values) {
                        pin = values;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: GestureDetector(
                        onTap: () {
                          if (pin.length == 4) {
                            if (userStatus == "new") {
                              _databaseService.saveNewUserProfile(_userName.text, pin);
                            } else if (userStatus == "available") {
                              _databaseService.updateUserProfile(_userName.text, pin, userID);
                            }
                            setState(() {});
                            //Update the user profile
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Profile updated successfully")));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                    content: Text("Pin must be 4 numbers"),
                                  );
                                });
                          }
                        },
                        child: const FarmButton(buttonLabel: "Save")),
                  )
                ],
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}

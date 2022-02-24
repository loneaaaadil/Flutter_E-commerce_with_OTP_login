import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopbiz/login.dart';
import 'package:shopbiz/models/user_model.dart';
import 'package:shopbiz/screens/main_screen.dart';
import 'package:shopbiz/utils/constants.dart';
import 'package:shopbiz/utils/decoration.dart';
import 'package:shopbiz/utils/text_Style.dart';

class ProfileInitPage extends StatefulWidget {
  static const id = '/profileinit';

  @override
  State<ProfileInitPage> createState() => _ProfileInitPageState();
}

class _ProfileInitPageState extends State<ProfileInitPage> {
  Future signout(BuildContext context) async {
    await FirebaseAuth.instance.signOut().whenComplete(
        () => Navigator.pushReplacementNamed(context, LoginPage.id));
  }

  TextEditingController nameC = TextEditingController();

  TextEditingController houseC = TextEditingController();

  TextEditingController streetC = TextEditingController();

  TextEditingController cityC = TextEditingController();

  TextEditingController zipcodeC = TextEditingController();

  TextEditingController dobC = TextEditingController();

  DateTime selectedDate;

  final formkey = GlobalKey<FormState>();

  bool isloading = false;

  FirebaseFirestore db = FirebaseFirestore.instance;

  submit(BuildContext context) async {
    if (formkey.currentState.validate()) {
      FirebaseMessaging fbm = FirebaseMessaging.instance;
      String fcm = await fbm.getToken();
      AppUser.update(
        name: nameC.text,
        house: houseC.text,
        street: streetC.text,
        city: cityC.text,
        zipcode: zipcodeC.text,
        dob: dobC.text,
        fcmToken: fcm,
       
        isLoggedIn: true,
         userType: 0,
      );

      db
          .collection("User")
          .doc(AppUser.phone)
          .set(AppUser().getMap)
          .then((value) {
        Navigator.of(context).pushReplacementNamed(MainPage.id);
      }).catchError((e) {
        displayMessage(e.toString());
      });
      setState(() {
        isloading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Text('PROFILE', style: heading2)),
              isloading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 10,
                        child: Form(
                          key: formkey,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    onFieldSubmitted: (v) {
                                      nameC.text = v;
                                    },
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    controller: nameC,
                                    validator: (v) {
                                      if (v.length < 4) {
                                        return 'should be greater than 5';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        icon: person,
                                        hintText: "Enter name",
                                        labelText: 'What people call you ?',
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    onFieldSubmitted: (v) {
                                      houseC.text = v;
                                    },
                                    controller: houseC,
                                    validator: (v) {
                                      if (v.length < 4) {
                                        return 'should be greater than 5';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        icon: address,
                                        hintText: "Enter house no.",
                                        labelText: 'What is your house no. ?',
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    onFieldSubmitted: (v) {
                                      streetC.text = v;
                                    },
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    controller: streetC,
                                    validator: (v) {
                                      if (v.length < 4) {
                                        return 'should be greater than 5';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        icon: address,
                                        hintText: "Enter Street",
                                        labelText: 'Whatis your street?',
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    onFieldSubmitted: (v) {
                                      cityC.text = v;
                                    },
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    controller: cityC,
                                    validator: (v) {
                                      if (v.length < 4) {
                                        return 'should be greater than 5';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        icon: address,
                                        hintText: "Enter city",
                                        labelText: 'What is your city ?',
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    onFieldSubmitted: (v) {
                                      zipcodeC.text = v;
                                    },
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    controller: zipcodeC,
                                    validator: (v) {
                                      if (v.length < 4) {
                                        return 'should be greater than 5';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        icon: address,
                                        // hintText: "Enter province name",
                                        labelText: 'What is your zipcode ?',
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    // keyboardType: KeyboardKey.,
                                    onFieldSubmitted: (v) {
                                      dobC.text = v;
                                    },
                                    textInputAction: TextInputAction.next,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1970),
                                        lastDate: DateTime.now(),
                                      ).then((value) {
                                        if (value == null)
                                          return;
                                        else {
                                          selectedDate = value;
                                          dobC.text = selectedDate
                                              .toString()
                                              .substring(0, 10);
                                        }
                                      });
                                    },
                                    controller: dobC,
                                    validator: (v) {
                                      if (v.length < 4) {
                                        return 'should be greater than 5';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        icon: dob,
                                        // hintText: "Enter ",
                                        labelText: 'What is your birthday ?',
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: isloading
          ? null
          : FloatingActionButton(
              onPressed: () {
                submit(context);
              },
              child: Icon(Icons.navigate_next),
            ),
    );
  }
}
// 
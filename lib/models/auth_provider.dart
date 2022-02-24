import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopbiz/models/user_model.dart';
import 'package:shopbiz/profile_init_page.dart';
import 'package:shopbiz/screens/main_screen.dart';

class AuthProvider {
  Future<bool> loginwithPhone(BuildContext context, String phone) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    TextEditingController optC = TextEditingController();
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (AuthCredential credential) async {
          Navigator.pop(context);
          UserCredential result = await _auth.signInWithCredential(credential);
          User user = result.user;
          if (user != null) {
            AppUser.set(phone);
            Navigator.pushReplacementNamed(context, MainPage.id);
          } else {
            Fluttertoast.showToast(msg: 'user is not signed in');
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          Fluttertoast.showToast(msg: e.toString());
        },
        codeSent: (String verificationCode, int token) {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                    title: Text('enter OTP'),
                    content: Column(
                      children: [
                        TextField(
                          controller: optC,
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () async {
                          final code = optC.text;
                          AuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: verificationCode,
                                  smsCode: code);
                          UserCredential result =
                              await _auth.signInWithCredential(credential);
                          User user = result.user;
                          if (user != null) {
                            AppUser.set(phone);
                            Navigator.pushReplacementNamed(
                                context, MainPage.id);
                            print('sucess');
                          } else {
                            Fluttertoast.showToast(msg: 'error');
                          }
                        },
                        child: Text('verify'),
                      ),
                    ]);
              });
        },
        codeAutoRetrievalTimeout: (id) => {});
  }
}



import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopbiz/models/user_model.dart';
import 'package:shopbiz/profile_init_page.dart';
import 'package:shopbiz/login.dart';
import 'package:shopbiz/screens/main_screen.dart';

class SplashInitPage extends StatelessWidget {
  Future<bool> savephone(String phonenumber) async {
    Future<bool> d;
    SharedPreferences sp = await SharedPreferences.getInstance();
    d = sp.setString('phone', phonenumber);
    print("okk $d");
    return d;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashPage();
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return LoginPage();
          } else if (snapshot.data.phoneNumber != null) {
            print('phone is not null');
            print("okk ${snapshot.data.phoneNumber}");
            savephone(snapshot.data.phoneNumber);

            AppUser.set(snapshot.data.phoneNumber);
          }
          return SplashPage();
        },
      ),
    );
  }
}

class SplashPage extends StatefulWidget {
  static const id = '/SplashPage';
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, MainPage.id);
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Expanded(
            child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Image.asset('images/logo.png'))),
        Text(
          'SHOPBIZ',
          style: TextStyle(fontSize: 30, fontFamily: 'roboto-bold'),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )),
      ]),
    );
  }
}

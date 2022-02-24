import 'package:flutter/material.dart';
import 'package:shopbiz/models/auth_provider.dart';
import 'package:shopbiz/utils/custom_colors.dart';

class LoginPage extends StatelessWidget {
  GlobalKey formkey = GlobalKey<FormState>();
  TextEditingController inputController = TextEditingController();
  static const id = '/LoginPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              height: 200,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'SHOPBIZ',
              style: TextStyle(fontSize: 30, fontFamily: 'roboto-bold'),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: formkey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: inputController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'enter phone number',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      minWidth: double.infinity,
                      color: primarycolor,
                      onPressed: () {
                        if (inputController.text != null) {
                          final phone = "+91" + inputController.text;
                          AuthProvider().loginwithPhone(context, phone);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            color: white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

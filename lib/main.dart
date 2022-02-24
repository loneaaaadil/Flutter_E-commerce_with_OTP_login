import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopbiz/admin_screens/add_products.dart';
import 'package:shopbiz/models/auth_provider.dart';
import 'package:shopbiz/screens/main_screen.dart';
import 'package:shopbiz/screens/products/product_page.dart';
import 'package:shopbiz/screens/products/products_detail.dart';
import 'package:shopbiz/utils/custom_colors.dart';
import 'package:shopbiz/profile_init_page.dart';
import 'package:shopbiz/login.dart';
import 'package:shopbiz/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop-biz',
      theme: ThemeData(
        primarySwatch: primarycolor,
        fontFamily: 'roboto-regular',
      ),
      home:SplashInitPage (),
      routes: {
        SplashPage.id: (context) => SplashPage(),
        LoginPage.id: (context) => LoginPage(),
        ProfileInitPage.id: (context) => ProfileInitPage(),
        MainPage.id: (context) => MainPage(),
        AddProductPage.id: (context) => AddProductPage(),
        ProductPage.id: (context) => ProductPage(),
        ProductDetailPage.id: (context) => ProductDetailPage(),
      },
    );
  }
}

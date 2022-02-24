import 'dart:html';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopbiz/login.dart';
import 'package:shopbiz/models/categorie.dart';
import 'package:shopbiz/models/user_model.dart';
import 'package:shopbiz/profile_init_page.dart';
import 'package:shopbiz/screens/products/product_page.dart';
import 'package:shopbiz/utils/constants.dart';
import 'package:shopbiz/utils/custom_colors.dart';
import 'package:shopbiz/utils/decoration.dart';
import 'package:shopbiz/widgets/app_drawer.dart';
import 'package:shopbiz/widgets/slider.dart';


class MainPage extends StatefulWidget {
  static const id = '/mainpage';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController searchC = TextEditingController();

  List<Category> newList = List.from(categories);

  // @override
  // void initState() {
  //   go();
  //   super.initState();
  // }
  String phone;
  Future getphone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phone = prefs.getString('phone');
    print("okk $phone");
  }

  check() {
    getphone().then((value) {
      if (phone == null) {
        Navigator.pushReplacementNamed(context, ProfileInitPage.id);
      } else {
        print('phone is not null');
      }
    });
  }

   @override
  void initState() {
    check();
    super.initState();
  }




  // @override
  // void didChangeDependencies() {
  //  go();
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    searchC.clear();
    super.dispose();
  }

  AppUser appUser = AppUser();
  bool isInit = true;
  var isLoading = false;

// AppUser appUser=AppUser();
//   go()async {
//     if (await appUser.getInfoFormDb) {
//       if (!AppUser.isLoggedIn) {
//         Navigator.pushReplacementNamed(context, LoginPage.id);
//       } else {
//         Navigator.pushReplacementNamed(context, ProfileInitPage.id);
//       }
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return AppUser.userType==0?
      Scaffold(
      drawer: AppDrawer(),
      appBar: isLoading ?null:
      AppBar(
        title: Text('Home Page'),
        centerTitle: true,
      ),
      body:isLoading?Center(
        child: CircularProgressIndicator(),
      ):
      
       Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                decoration: decoration(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: searchC,
                    onChanged: (value) {
                      setState(() {
                        searchC.text = value;
                        newList = categories
                            .where((e) => e.name
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                        print(searchC.text);
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'search category',
                      suffixIcon: Icon(FontAwesomeIcons.search),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CSlider(),
            SizedBox(
              height: 20,
            ),
            Text(
              'CATEGORIES',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: newList
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              ProductPage.id,
                              arguments: {
                                "category": e.name,
                                "icon": e.icon,
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.purple,
                                    Colors.blue,
                                  ]),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      e.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    transform: Matrix4.rotationZ(0.2),
                                    child: Icon(
                                      e.icon,
                                      size: 35,
                                      color: white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    ):Scaffold(
      body: Center(child: Text("admin page"),),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopbiz/admin_screens/add_products.dart';
import 'package:shopbiz/screens/main_screen.dart';
import 'package:shopbiz/utils/custom_colors.dart';
import 'package:shopbiz/utils/text_Style.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        backgroundColor: Colors.white.withOpacity(0.8),
        child: ListView(
          children: [
            drawerHeader(),
            drawerItems('Home Page', FontAwesomeIcons.home, () {
              Navigator.pushReplacementNamed(context, MainPage.id);
            }),
            drawerItems('Admin Page', FontAwesomeIcons.user, () {
              Navigator.pushReplacementNamed(context, AddProductPage.id);
            }),
            drawerItems('Home Page', FontAwesomeIcons.home, () {
              Navigator.pushReplacementNamed(context, MainPage.id);
            }),
            drawerItems('Home Page', FontAwesomeIcons.home, () {
              Navigator.pushReplacementNamed(context, MainPage.id);
            })
          ],
        ),
      ),
    );
  }

  ListTile drawerItems(String title, IconData icon, GestureTapCallback onTap) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }

  DrawerHeader drawerHeader() {
    return DrawerHeader(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          child: Center(
              child: Text(
            'Welcome to Shopbiz',
            style: heading1,
            textAlign: TextAlign.center,
          )),
          color: primarycolor,
        ),
      ),
    );
  }
}

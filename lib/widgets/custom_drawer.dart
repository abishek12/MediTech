import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Abishek Khanal"),
            accountEmail: Text("abishek@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/doctor1.jpg"),
            ),
          ),
          // home
          drawerItems(
            context,
            () => Navigator.pushNamed(context, "/home"),
            "Home",
            Icon(
              CupertinoIcons.home,
              color: Colors.green,
            ),
          ),
          // appointment
          drawerItems(
            context,
            () {},
            "Appointment",
            Icon(
              CupertinoIcons.calendar,
              color: Colors.green,
            ),
          ),
          // chat
          drawerItems(
            context,
            () => Navigator.pushNamed(context, "/chat"),
            "Chat",
            Icon(
              CupertinoIcons.chat_bubble_2,
              color: Colors.green,
            ),
          ),
          drawerItems(
            context,
            () => Navigator.pushNamed(context, "/dashboard"),
            "Dashboard",
            Icon(
              CupertinoIcons.square_grid_4x3_fill,
              color: Colors.green,
            ),
          ),
          drawerItems(
            context,
            () {
              FirebaseAuth.instance.signOut();
            },
            "Logout",
            Icon(
              CupertinoIcons.arrow_right_square,
              color: Colors.green,
            ),
          ),
          Divider(
            thickness: 1,
            height: 1,
          ),
          drawerItems(
            context,
            () => Navigator.pushNamed(context, "/settings"),
            "Settings",
            Icon(
              CupertinoIcons.settings,
              color: Colors.blueGrey,
            ),
          ),
          drawerItems(
            context,
            () {},
            "About Us",
            Icon(
              CupertinoIcons.question_circle,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}

Widget drawerItems(
    BuildContext context, VoidCallback onTap, String title, Icon icon) {
  return ListTile(
    onTap: onTap,
    title: Text(title),
    leading: icon,
  );
}

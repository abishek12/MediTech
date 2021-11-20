import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _aboutUs(){
      return showDialog(context: context, builder: (context){
        return CupertinoAlertDialog(
          title: Text("About Us"),
          content: Column(
            children: [
              Text("Develop By: Prime College Final Year Student"),
              Text("v1.0.0")
            ],
          ),
          actions: [
            Container(
              margin: EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: ()=> Navigator.pop(context),
                child: Text("Close"),
              ),
            )
          ],
        );
      });
    }
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Abishek Khanal"),
            accountEmail:
            Text(FirebaseAuth.instance.currentUser!.email.toString()),
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
                () => Navigator.pushNamed(context, "/appointment"),
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
          // dashboard
          drawerItems(
            context,
                () => Navigator.pushNamed(context, "/dashboard"),
            "Dashboard",
            Icon(
              CupertinoIcons.square_grid_4x3_fill,
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
                () => _aboutUs(),
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

Widget drawerItems(BuildContext context, VoidCallback onTap, String title,
    Icon icon) {
  return ListTile(
    onTap: onTap,
    title: Text(title),
    leading: icon,
  );
}

import 'package:flutter/material.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Chat"),
      drawer: MyDrawer(),
      body: Container(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, value) {
              return Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  title: Text("Abishek Khanal"),
                  subtitle: Text("Hello Abishek"),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/doctor1.jpg"),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

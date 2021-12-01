import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Chat"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/searchScreen");
        },
        child: Icon(CupertinoIcons.search),
      ),
      drawer: MyDrawer(),
      body: Container(),
    );
  }
}

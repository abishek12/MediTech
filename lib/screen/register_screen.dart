import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';
import 'package:medicalapp/widgets/custom_text.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _email = "";
    String _password = "";
    String _fullName = "";
    String _licensesNumber = "";
    String _contact = "";
    String _address = "";
    String _registerDate = "";

    _registerDoctor() async {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password)
            .then((value) => FirebaseFirestore.instance
                    .collection("user")
                    .doc(value.user!.uid)
                    .set({
                  "fullName": _fullName,
                  "email": _email,
                  "licenses_number": _licensesNumber,
                  "contact": _contact,
                  "address": _address,
                  "role": "doctor",
                  "specification": "",
                  "description": "",
                  "likes": "0",
                  "rating": "0",
                  "images": "",
                  "registeredDate": _registerDate,
                  "joinedDate": DateTime.now()
                }));
        Navigator.pushNamed(context, "/login");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e.toString());
      }
    }

    return Scaffold(
      appBar: myAppBar("Register"),
      drawer: MyDrawer(),
      body: ListView(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 64.0),
              child: Text(
                "Register a Doctor",
                style: MyStyles.heading,
              ),
            ),
          ),
          CustomTextField(
            helperText: "Fullname",
            hintText: "Enter Fullname",
            onChanged: (value) {
              _fullName = value;
            },
            obscureText: false,
          ),
          CustomTextField(
            helperText: "Email",
            hintText: "Enter email address",
            onChanged: (value) {
              _email = value;
            },
            obscureText: false,
          ),
          CustomTextField(
            helperText: "Password",
            hintText: "Enter password",
            onChanged: (value) {
              _password = value;
            },
            obscureText: true,
          ),
          CustomTextField(
            helperText: "Contact",
            hintText: "Enter phone number",
            onChanged: (value) {
              _contact = value;
            },
            obscureText: false,
          ),
          CustomTextField(
            helperText: "Address",
            hintText: "Enter address",
            onChanged: (value) {
              _address = value;
            },
            obscureText: false,
          ),
          CustomTextField(
            helperText: "MBBS Licenses Number",
            hintText: "Enter MBBS Licenses number",
            onChanged: (value) {
              _licensesNumber = value;
            },
            obscureText: false,
          ),
          CustomTextField(
            helperText: "Registered Date",
            hintText: "2020/10/10",
            onChanged: (value) {
              _registerDate = value;
            },
            obscureText: false,
          ),
          ElevatedButton(
            onPressed: () => _registerDoctor(),
            child: Text("Register"),
          )
        ],
      ),
    );
  }
}

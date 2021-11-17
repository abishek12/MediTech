import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_text.dart';

class RegisterPatientScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _email = "";
    String _password = "";
    String _fullName = "";
    String _contact = "";
    String _address = "";
    String _age = "";

    _registerPatient() async {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password)
            .then((value) => FirebaseFirestore.instance
            .collection("user")
            .doc(value.user!.uid)
            .set({
          "fullName": _fullName,
          "email": _email,
          "contact": _contact,
          "address": _address,
          "role": "patient",
          "specification": "",
          "age": _age,
          "joinedDate": DateTime.now()
        }));
        print("$_fullName, $_email");
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
      body: ListView(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 64.0),
              child: Text(
                "Register a Patient",
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
            helperText: "Age",
            hintText: "Enter age",
            onChanged: (value) {
              _age = value;
            },
            obscureText: false,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => _registerPatient(),
              child: Text("Register"),
            ),
          )
        ],
      ),
    );
  }
}

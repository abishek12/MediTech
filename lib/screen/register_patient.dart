import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';

class RegisterPatientScreen extends StatefulWidget {
  @override
  State<RegisterPatientScreen> createState() => _RegisterPatientScreenState();
}

class _RegisterPatientScreenState extends State<RegisterPatientScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    TextEditingController _fullName = TextEditingController();
    TextEditingController _contact = TextEditingController();
    TextEditingController _address = TextEditingController();
    TextEditingController _age = TextEditingController();

    _registerPatient() async {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: "${_email.text}", password: "${_password.text}")
            .then((value) => FirebaseFirestore.instance
                    .collection("user")
                    .doc(value.user!.uid)
                    .set({
                  "fullName": "${_fullName.text}",
                  "email": "${_email.text}",
                  "contact": "${_contact.text}",
                  "address": "${_address.text}",
                  "role": "patient",
                  "specification": "",
                  "age": "${_age.text}",
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
      body: ListView(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 64.0),
              child: Text(
                "Register a new user",
                style: MyStyles.heading,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _fullName,
              decoration: InputDecoration(
                hintText: "Fullname",
                labelText: "Fullname",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _email,
              decoration: InputDecoration(
                hintText: "Email",
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _password,
              decoration: InputDecoration(
                hintText: "Password",
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _contact,
              decoration: InputDecoration(
                hintText: "Contact",
                labelText: "Contact",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _address,
              decoration: InputDecoration(
                hintText: "Address",
                labelText: "Address",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _age,
              decoration: InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(),
                hintText: "Age",
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => _registerPatient(),
              child: Text("Register"),
            ),
          ),
        ],
      ),
    );
  }
}

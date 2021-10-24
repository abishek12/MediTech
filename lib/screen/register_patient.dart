import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/widgets/custom_text.dart';

class RegisterPatientScreen extends StatelessWidget {
  const RegisterPatientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _fullname = "";
    String _email = "";
    String _password = "";

    _registerPatient() async {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password)
            .then((value) => FirebaseFirestore.instance
                    .collection("users")
                    .doc(value.user!.uid)
                    .set({
                  "fullname": _fullname,
                  "email": _email,
                  "role": "patient",
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Register as a Patient"),
            Container(
              margin: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomTextField(
                    helperText: "Email",
                    hintText: 'Enter email address',
                    obscureText: false,
                    onChanged: (value) {
                      _email = value;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  CustomTextField(
                    helperText: "Password",
                    hintText: 'Enter password',
                    obscureText: true,
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        _registerPatient();
                      },
                      child: Text("Register"),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Back To Login"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

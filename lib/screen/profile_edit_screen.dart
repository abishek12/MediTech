import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';

// ignore: must_be_immutable
class ProfileEditScreen extends StatelessWidget {
  String _userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    String _fullName = "";
    String _contact = "";
    String _address = "";
    String _age = "";
    String _password = "";

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(_userId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Something went wrong"),
              ),
            );
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Scaffold(
              body: Center(
                child: Text("Document does not exist"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
                appBar: myAppBar("Update Profile"),
                body: ListView(
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 64.0),
                        child: Text(
                          "Update Your Profile",
                          style: MyStyles.heading,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(16.0),
                      child: TextFormField(
                        initialValue: data['fullName'],
                        onChanged: (value) {
                          _fullName = value;
                        },
                        decoration: InputDecoration(
                          labelText: "Fullname",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(16.0),
                      child: TextFormField(
                        initialValue: data['contact'],
                        onChanged: (value) {
                          _contact = value;
                        },
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
                        initialValue: data['address'],
                        onChanged: (value) {
                          _address = value;
                        },
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
                        initialValue: data['age'],
                        onChanged: (value) {
                          _age = value;
                        },
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
                        onPressed: () => {
                          users.doc(_userId).update({
                            "fullName": _fullName,
                            "contact": _contact,
                            "address": _address,
                            "age": _age,
                          }),
                          Navigator.pushNamed(context, "/dashboard"),
                        },
                        child: Text("Update Profile"),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      margin: EdgeInsets.all(16.0),
                      child: TextFormField(
                        onChanged: (value) {
                          _password = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Password",
                          labelText: "Password",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(16.0),
                      child: MaterialButton(
                        onPressed: () => {
                          if (_password == "")
                            {
                              AlertDialog(
                                title: Text("Error"),
                                content: Text("Password is required"),
                              )
                            }
                          else
                            {
                              users.doc(_userId).update({
                                "password": _password,
                              }),
                              Navigator.pushNamed(context, "/dashboard"),
                            }
                        },
                        child: Text(
                          "Change Password",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ));
          }

          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}

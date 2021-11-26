import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';
import 'package:medicalapp/widgets/patient_beds.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatelessWidget {
  String _userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('user');
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
              appBar: myAppBar("Dashboard"),
              drawer: MyDrawer(),
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.pushNamed(context, "/editProfile"),
                child: Icon(
                  CupertinoIcons.pen,
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 48.0,
                          ),
                          Text(
                            "Fullname: ${data['fullName']}",
                            style: MyStyles.headingFour,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            "Email: ${data['email']}",
                            style: MyStyles.paragraph,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            "Age:  ${data['age']}",
                            style: MyStyles.paragraph,
                          ),
                          Container(
                            margin: EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.pushReplacementNamed(
                                    context, "/landing");
                              },
                              child: Text("Logout"),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Activity",
                        style: MyStyles.headingFour,
                      ),
                    ),
                    Container(
                      width: 200.0,
                      height: 10.0,
                      margin: EdgeInsets.only(left: 16.0, top: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
                      child: Text(
                        "Beds: ",
                        style: MyStyles.paragraph,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}

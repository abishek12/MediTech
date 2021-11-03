import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatelessWidget {
  String _userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('doctor');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(_userId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: myAppBar("Dashboard"),
            drawer: MyDrawer(),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: Colors.red,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 48.0,
                        ),
                        Text(
                          data['fullName'],
                          style: MyStyles.headingFour,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          data['email'],
                          style: MyStyles.paragraph,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text("Like"),
                                Text(data["likes"]),
                              ],
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Column(
                              children: [
                                Text("Rating"),
                                Text(data["rating"]),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Container(
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
                      "Description",
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
                  )
                ],
              ),
            ),
          );
        }

        return Scaffold(
          body: CircularProgressIndicator(),
        );
      },
    );
  }
}

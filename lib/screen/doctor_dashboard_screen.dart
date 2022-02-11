import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/screen/doctor_profile_edit_screen.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';

// ignore: must_be_immutable
class DoctorDashboardScreen extends StatelessWidget {
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
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoctorProfileEditScreen(
                            docID: _userId,
                            docName: data["fullName"],
                            docSpecification: data["specification"],
                            docDescription: data["description"]))),
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
                              Row(
                                children: [
                                  Text("Rating"),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(data["rating"] == 0
                                      ? "0"
                                      : data["rating"].toString()),
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
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Wrap(
                        children: [
                          Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Text(
                                data['description'],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GetUerAppointment(FirebaseAuth.instance.currentUser!.uid)
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

class GetUerAppointment extends StatelessWidget {
  final String documentId;

  GetUerAppointment(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('bookAppointmentDoctor');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Card(
              child: Text("Nothing TO Display"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
            child: ListTile(
              title: Text(
                "User ID: ${data["uId"]}",
                style: MyStyles.paragraph,
              ),
            ),
          );
        }
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Card(
            child: Text("Nothing TO Display"),
          ),
        );
      },
    );
  }
}

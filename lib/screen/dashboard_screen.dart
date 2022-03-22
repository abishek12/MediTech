import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';

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
                      height: 250,
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
                          Text(
                            "Uid: " + FirebaseAuth.instance.currentUser!.uid,
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
                      margin: EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12.0),
                      child: Text(
                        "Vaccine: ",
                        style: MyStyles.paragraph,
                      ),
                    ),
                    GetUerVaccine(
                      FirebaseAuth.instance.currentUser!.uid.toString(),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12.0),
                      child: Text(
                        "Beds: ",
                        style: MyStyles.paragraph,
                      ),
                    ),
                    GetUerBed(
                      FirebaseAuth.instance.currentUser!.uid.toString(),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12.0),
                      child: Text(
                        "Appointment: ",
                        style: MyStyles.paragraph,
                      ),
                    ),
                    GetUerAppointment(
                      FirebaseAuth.instance.currentUser!.uid.toString(),
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

class GetUerBed extends StatelessWidget {
  final String documentId;

  GetUerBed(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('bookBed');

    _deleteBeds(String documentId) async {
      await FirebaseFirestore.instance
          .collection('bookBed')
          .doc(documentId)
          .delete();
      Navigator.pop(context);
    }

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
              child: Text("Nothing to Display"),
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              title: Text(
                "Ward Name: ${data["ward"]}",
                style: MyStyles.paragraph,
              ),
              trailing: IconButton(
                onPressed: () {
                  _deleteBeds(
                      FirebaseAuth.instance.currentUser!.uid.toString());
                },
                icon: Icon(CupertinoIcons.delete),
              ),
            ),
          );
        }
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Card(
            child: Text("Nothing TO Display"),
          ),
        );
      },
    );
  }
}

class GetUerAppointment extends StatelessWidget {
  final String documentId;

  GetUerAppointment(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('bookAppointment');

    _deleteAppointment(String documentId) async {
      await FirebaseFirestore.instance
          .collection('bookAppointment')
          .doc(documentId)
          .delete();
      Navigator.pop(context);
    }

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
                "Doctor Name: ${data["doctor_name"]}",
                style: MyStyles.paragraph,
              ),
              trailing: IconButton(
                onPressed: () {
                  _deleteAppointment(
                      FirebaseAuth.instance.currentUser!.uid.toString());
                },
                icon: Icon(CupertinoIcons.delete),
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

class GetUerVaccine extends StatelessWidget {
  final String documentId;

  GetUerVaccine(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('bookVaccine');

    _deleteVaccine(String documentId) async {
      await FirebaseFirestore.instance
          .collection('bookVaccine')
          .doc(documentId)
          .delete();
      Navigator.pop(context);
    }

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
              child: Text("Nothing to Display"),
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              title: Text(
                "Vaccine Name: ${data["vaccine_name"]}",
                style: MyStyles.paragraph,
              ),
              trailing: IconButton(
                onPressed: () {
                  _deleteVaccine(
                      FirebaseAuth.instance.currentUser!.uid.toString());
                },
                icon: Icon(CupertinoIcons.delete),
              ),
            ),
          );
        }
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Card(
            child: Text("Nothing TO Display"),
          ),
        );
      },
    );
  }
}

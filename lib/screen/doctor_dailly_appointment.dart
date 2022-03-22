import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';

class TodaysAppointment extends StatelessWidget {
  const TodaysAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    String date = "${dateTime.year}/${dateTime.month}/${dateTime.day}";
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('bookAppointment')
          .where("doctor_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('booked_date', isEqualTo: date)
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError)
          return Text(
            'Error = ${snapshot.error}',
          );
        if (snapshot.hasData) {
          final docs = snapshot.data!.docs;
          return Scaffold(
            appBar: myAppBar("Doctor"),
            body: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, i) {
                final data = docs[i].data();
                return Container(
                  margin: EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 2.0,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          data['uId'],
                        ),
                        subtitle: Text(
                          "Time: " + data['booked_time'],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:medicalapp/screen/vaccine_book.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';

// ignore: must_be_immutable
class NearByScreen extends StatefulWidget {
  String latitude = "";
  String longitude = "";

  NearByScreen({required this.latitude, required this.longitude});

  @override
  State<NearByScreen> createState() => _NearByScreenState();
}

class _NearByScreenState extends State<NearByScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('vaccine')
          .where("location",
              isNotEqualTo: "${widget.latitude} ${widget.longitude}")
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');
        if (snapshot.hasData) {
          final docs = snapshot.data!.docs;
          return Scaffold(
            appBar: myAppBar("Vaccine"),
            drawer: MyDrawer(),
            body: Container(
              child: ListView.builder(
                itemCount: docs.length,
                itemBuilder: (_, i) {
                  final data = docs[i].data();
                  return Container(
                    margin: EdgeInsets.all(16.0),
                    child: Card(
                      child: ListTile(
                        leading: Image.asset("assets/icons/vaccine.png"),
                        title: Text(data['name']),
                        subtitle: Text("Dose: ${data['dose']}"),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VaccineBook(
                                          docId: snapshot.data!.docs[i].id,
                                          vName: data['name'],
                                          vContact: data['contact'],
                                          vDose: data['dose'],
                                          patientName: "Abishek Khanal",
                                        )));
                          },
                          icon: Icon(CupertinoIcons.arrow_right_circle),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

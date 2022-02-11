// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';

class DoctorProfileEditScreen extends StatelessWidget {
  final String docID;
  final String docName;
  final String docSpecification;
  final String docDescription;

  DoctorProfileEditScreen(
      {required this.docID,
      required this.docName,
      required this.docSpecification,
      required this.docDescription});

  TextEditingController _name = new TextEditingController();
  TextEditingController _specification = new TextEditingController();
  TextEditingController _description = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    _updateUser() {
      DocumentReference<Map<String, dynamic>> user =
          FirebaseFirestore.instance.collection("user").doc(docID);
      user.update({
        'fullName': _name.text,
        'specification': _specification.text,
        'description': _description.text,
      });
    }

    return Scaffold(
      appBar: myAppBar("Update"),
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _specification,
              decoration: InputDecoration(labelText: "Doctor Specification"),
            ),
            TextFormField(
              controller: _description,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(labelText: "Description"),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  _updateUser();
                },
                child: Text("Update"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

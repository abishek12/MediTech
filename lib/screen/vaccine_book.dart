import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';

class VaccineBook extends StatefulWidget {
  String vName = "";
  String vDose = "";
  String vContact = "";
  String patientName = "";

  VaccineBook({
    required this.vName,
    required this.vDose,
    required this.vContact,
    required this.patientName,
  });

  @override
  State<VaccineBook> createState() => _VaccineBookState();
}

class _VaccineBookState extends State<VaccineBook> {
  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    String _dropDownValue = "";
    _bookVaccine() {
      CollectionReference _bookVaccine =
          FirebaseFirestore.instance.collection('bookVaccine');
      _bookVaccine
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
            'vaccine_name': widget.vName,
            'vaccine_dose': widget.vDose,
            'vaccine_contact': widget.vContact,
            'patient_name': widget.patientName,
            'booked_date': "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
            'booked_time': _dropDownValue,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    List<String> timetable = [
      '10:00 - 11:00 A.M',
      '11:00 - 12:00 P.M',
      '12:00 - 01:00 P.M',
      '01:00 - 02:00 P.M',
      '02:00 - 03:00 P.M',
      '03:00 - 04:00 P.M',
      '04:00 - 05:00 P.M',
    ];
    _selectDate(BuildContext context) async {
      final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2010),
        lastDate: DateTime(2025),
      );
      if (selected != null && selected != selectedDate)
        setState(() {
          selectedDate = selected;
        });
    }

    return Scaffold(
      appBar: myAppBar("Book a Vaccine"),
      drawer: MyDrawer(),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 32.0),
            alignment: Alignment.center,
            child: Text(
              "Vaccine Center",
              style: MyStyles.heading,
            ),
          ),
          //vaccine name
          Container(
            margin: EdgeInsets.all(16.0),
            child: TextFormField(
              initialValue: "${widget.vName}",
              onChanged: (value) {
                widget.vName = value;
              },
              decoration: InputDecoration(
                labelText: "vaccine Name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          //  vaccine dose
          Container(
            margin: EdgeInsets.all(16.0),
            child: TextFormField(
              onChanged: (value) {
                widget.vDose = value;
              },
              initialValue: "${widget.vDose}",
              decoration: InputDecoration(
                labelText: "vaccine Dose",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          //  total vaccine
          Container(
            margin: EdgeInsets.all(16.0),
            child: TextFormField(
              onChanged: (value) {
                widget.vContact = value;
              },
              initialValue: "${widget.vContact}",
              decoration: InputDecoration(
                labelText: "vaccine Contact",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          //  patient name
          Container(
            margin: EdgeInsets.all(16.0),
            child: TextFormField(
              onChanged: (value) {
                widget.patientName = value;
              },
              initialValue: "${widget.patientName}",
              decoration: InputDecoration(
                labelText: "Patient Name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // date and time picked
          Container(
              margin: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text("Choose Date"),
                  ),
                  Text(
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")
                ],
              )),
          Container(
            margin: EdgeInsets.all(16.0),
            child: DropdownButton(
              hint: _dropDownValue == ""
                  ? Text('Dropdown')
                  : Text(
                      _dropDownValue,
                      style: TextStyle(color: Colors.blue),
                    ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.blue),
              items: timetable.map(
                (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                  () {
                    _dropDownValue = val.toString();
                    print("${_dropDownValue.toString()}");
                  },
                );
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _bookVaccine();
              },
              child: Text("Vaccinate"),
            ),
          ),
        ],
      ),
    );
  }
}

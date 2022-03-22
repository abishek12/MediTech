// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:telephony/telephony.dart';

final Telephony telephony = Telephony.instance;

class VaccineBook extends StatefulWidget {
  String docId = "";
  String vName = "";
  String vDose = "";
  String vContact = "";
  String patientName = "";
  String times = "";

  VaccineBook({
    required this.docId,
    required this.vName,
    required this.vDose,
    required this.vContact,
    required this.patientName,
  });

  @override
  State<VaccineBook> createState() => _VaccineBookState();
}

class _VaccineBookState extends State<VaccineBook> {
  DateTime? _dateTime;
  TextEditingController _patientContact = new TextEditingController();
  TextEditingController _patientName = new TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _bookVaccine() {
      FirebaseFirestore.instance
          .collection('bookVaccine')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Error"),
                  content: Text("You have already booked a date"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Close"),
                    ),
                  ],
                );
              });
        } else {
          telephony.sendSms(
              to: _patientContact.text,
              message:
                  "Your Appointment Has Been Booked. Date: ${_dateTime!.year}/${_dateTime!.month}/${_dateTime!.day} Time:  ${widget.times}");
          CollectionReference _bookVaccine =
              FirebaseFirestore.instance.collection('bookVaccine');
          _bookVaccine.doc(FirebaseAuth.instance.currentUser!.uid).set({
            'uId': FirebaseAuth.instance.currentUser!.uid,
            'vaccine_name': widget.vName,
            'vaccine_dose': widget.vDose,
            'vaccine_contact': widget.vContact,
            'contact': _patientContact.text,
            'name': _patientName.text,
            'booked_date':
                "${_dateTime!.year}/${_dateTime!.month}/${_dateTime!.day}",
            'booked_time': widget.times,
          }).then((value) {
            return showDialog(
                barrierDismissible: false,
                context: context,
                builder: (c) {
                  return AlertDialog(
                    title: Text("Success"),
                    content: Text("Your Vaccination has been booked"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Done"),
                      ),
                    ],
                  );
                });
          }).catchError((error) => print("Failed to add user: $error"));
        }
      });
    }

    final List<Map<String, dynamic>> _timetable = [
      {
        'value': '10:00 - 11:00 A.M',
        'label': '10:00 - 11:00 A.M',
        'icon': Icon(CupertinoIcons.clock_solid),
      },
      {
        'value': '11:00 - 12:00 P.M',
        'label': '11:00 - 12:00 P.M',
        'icon': Icon(CupertinoIcons.clock_solid),
      },
      {
        'value': '12:00 - 01:00 P.M',
        'label': '12:00 - 01:00 P.M',
        'icon': Icon(CupertinoIcons.clock_solid),
      },
      {
        'value': '01:00 - 02:00 P.M',
        'label': '01:00 - 02:00 P.M',
        'icon': Icon(CupertinoIcons.clock_solid),
      },
      {
        'value': '02:00 - 03:00 P.M',
        'label': '02:00 - 03:00 P.M',
        'icon': Icon(CupertinoIcons.clock_solid),
      },
    ];

    return Scaffold(
        appBar: myAppBar("Book a Vaccine"),
        drawer: MyDrawer(),
        body: Form(
          key: globalKey,
          child: ListView(
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
                  controller: _patientName,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name is required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Patient Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              // patient contact
              Container(
                margin: EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _patientContact,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Contact is required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Contact",
                    hintText: "Contact",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              // date and time picked
              Container(
                margin: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _dateTime == null
                          ? "Select a date"
                          : "${_dateTime!.year}/${_dateTime!.month}/${_dateTime!.day}",
                    ),
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.clock_fill,
                        color: Colors.blueAccent,
                        size: 30.0,
                      ),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2017, 1),
                          lastDate: DateTime(2022, 7),
                          helpText: 'Select a date',
                        ).then((value) {
                          setState(() {
                            _dateTime = value!;
                          });
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(16.0),
                child: SelectFormField(
                  type: SelectFormFieldType.dropdown,
                  // or can be dialog
                  labelText: 'Time',
                  items: _timetable,
                  onChanged: (val) {
                    widget.times = val.toString();
                  },
                  onSaved: (val) {
                    widget.times = val.toString();
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
        ));
  }
}

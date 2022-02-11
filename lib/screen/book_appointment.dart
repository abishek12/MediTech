import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';
import 'package:select_form_field/select_form_field.dart';

// ignore: must_be_immutable
class BookAppointment extends StatefulWidget {
  String docId = "";
  String doctorName = "";
  String doctorContact = "";
  String doctorAddress = "";
  String times = "";

  BookAppointment(
      {required this.docId,
      required this.doctorName,
      required this.doctorAddress,
      required this.doctorContact});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    _bookAppointment() {
      FirebaseFirestore.instance
          .collection('bookAppointment')
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
          CollectionReference _bookAppointment =
              FirebaseFirestore.instance.collection('bookAppointment');
          CollectionReference _bookAppointmentDoctor =
              FirebaseFirestore.instance.collection('bookAppointmentDoctor');
          _bookAppointmentDoctor
              .doc(widget.docId)
              .set({
                'uId': FirebaseAuth.instance.currentUser!.uid,
                'booked_date':
                    "${_dateTime!.year}/${_dateTime!.month}/${_dateTime!.day}",
                'booked_time': widget.times,
              })
              .then((value) => {
                    _bookAppointment
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .set({
                      'doctor_id': widget.docId,
                      'doctor_name': widget.doctorName,
                      'doctor_contact': widget.doctorContact,
                      'address': widget.doctorAddress,
                      'booked_date':
                          "${_dateTime!.year}/${_dateTime!.month}/${_dateTime!.day}",
                      'booked_time': widget.times,
                    })
                  })
              .then((value) {
                return showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (c) {
                      return AlertDialog(
                        title: Text("Success"),
                        content: Text("Your Appointment has been booked"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Done"),
                          ),
                        ],
                      );
                    });
              })
              .catchError((error) => print("Failed to add user: $error"));
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
      appBar: myAppBar("Book an Appointment"),
      drawer: MyDrawer(),
      body: ListView(
        children: [
          SizedBox(
            height: 32.0,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Book an Appointment",
              style: MyStyles.headingFour,
            ),
          ),
          SizedBox(
            height: 8.0,
          ), //doctor name
          Container(
            margin: EdgeInsets.all(16.0),
            child: TextFormField(
              initialValue: widget.doctorName,
              decoration: InputDecoration(
                labelText: "Doctor Name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          //doctor contact
          Container(
            margin: EdgeInsets.all(16.0),
            child: TextFormField(
              initialValue: widget.doctorContact,
              decoration: InputDecoration(
                labelText: "Doctor Contact",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          //doctor address
          Container(
            margin: EdgeInsets.all(16.0),
            child: TextFormField(
              initialValue: widget.doctorAddress,
              decoration: InputDecoration(
                labelText: "Doctor Address",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          //choose date
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
          //  time picker
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
          //  button
          Container(
            child: ElevatedButton(
              child: Text("Book an Appointment"),
              onPressed: () {
                _bookAppointment();
              },
            ),
          )
        ],
      ),
    );
  }
}

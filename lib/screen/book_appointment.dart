import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';

class BookAppointment extends StatefulWidget {
  String doctorName = "";
  String doctorContact = "";
  String doctorAddress = "";

  BookAppointment(
      {required this.doctorName,
      required this.doctorAddress,
      required this.doctorContact});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate =  DateTime.now();
    Future _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021, 1),
        lastDate: DateTime(2025),
      );
      setState(() {
        selectedDate = picked;
      });
    }

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
          //person name
          Container(
            margin: EdgeInsets.all(16.0),
            child: TextFormField(
              onChanged: (value) {},
              decoration: InputDecoration(
                labelText: "Patient Name",
                hintText: "Jhon Does",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          //book a date
          Container(
              margin: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text("Date"),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Text("$selectedDate"),
                ],
              )),
          Container(
            margin: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                print("$selectedDate");
              },
              child: Text("Book"),
            ),
          ),
        ],
      ),
    );
  }
}

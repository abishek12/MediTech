import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/screen/book_appointment.dart';
import 'package:medicalapp/screen/feedback_screen.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';

class DoctorProfileScreen extends StatefulWidget {
  final String docId;
  final String fullName;
  final String email;
  final int rating;
  final String address;
  final String contact;
  final String licensesNumber;
  final String description;

  DoctorProfileScreen(
      {required this.docId,
      required this.fullName,
      required this.email,
      required this.rating,
      required this.address,
      required this.contact,
      required this.licensesNumber,
      required this.description});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Doctor Profile"),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage("assets/images/doctor1.jpg"),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.fullName),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(widget.email),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          print("Like");
                        },
                        icon: Icon(CupertinoIcons.heart),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // doctor review and total patient
            Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Rating : ",
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Text("${widget.rating}"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // doctor information
            Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  )
                ],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  Icon(CupertinoIcons.home),
                  SizedBox(
                    width: 16.0,
                  ),
                  Text("${widget.licensesNumber}"),
                ],
              ),
            ),
            // contact
            Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  )
                ],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  Icon(CupertinoIcons.phone),
                  SizedBox(
                    width: 16.0,
                  ),
                  Text("${widget.contact}"),
                ],
              ),
            ),
            // address
            Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  )
                ],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  Icon(CupertinoIcons.home),
                  SizedBox(
                    width: 16.0,
                  ),
                  Text("${widget.address}"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  )
                ],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 5.0,
                    margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  Text(
                    "${widget.description}" == ""
                        ? "Nothing to Display"
                        : widget.description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookAppointment(
                        docId: widget.docId,
                        doctorName: widget.fullName,
                        doctorAddress: widget.address,
                        doctorContact: widget.contact,
                      ),
                    ),
                  );
                },
                child: Text("Make an Appointment"),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeedBackScreen(docID: widget.docId),
                    ),
                  );
                },
                child: Text("Feedback"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

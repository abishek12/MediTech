import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';

class DoctorProfileScreen extends StatelessWidget {
  final String fullName;
  final String email;
  final String likes;
  final String rating;
  final String address;
  final String contact;
  final String licensesNumber;
  final String description;
  DoctorProfileScreen(
      {required this.fullName,
      required this.email,
      required this.likes,
      required this.rating,
      required this.address,
      required this.contact,
      required this.licensesNumber,
      required this.description});

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
                      Text(fullName),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(email),
                    ],
                  ),
                  SizedBox(
                    width: 64.0,
                  ),
                  Column(
                    children: [
                      Icon(CupertinoIcons.heart),
                      SizedBox(
                        height: 4.0,
                      ),
                      Icon(CupertinoIcons.heart),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Total Patient",
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text("$rating"),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Like",
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(likes),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Rating",
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "$rating" == "" ? "0" : description,
                      ),
                    ],
                  ),
                ],
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
                  Text("$licensesNumber"),
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
                  Text("$contact"),
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
                  Text("$address"),
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
                    "$description" == "" ? "Nothing to Display" : description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

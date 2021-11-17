import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';

// ignore: must_be_immutable
class BookHospitalScreen extends StatefulWidget {
  String hospitalName = "";
  String hospitalContact = "";
  String hospitalRemainingBeds = "";
  String hospitalTotalBeds = "";
  String id = "";

  BookHospitalScreen(
      {required this.hospitalName,
      required this.hospitalContact,
      required this.hospitalRemainingBeds,
      required this.hospitalTotalBeds,
      required this.id});

  @override
  _BookHospitalScreenState createState() => _BookHospitalScreenState();
}

class _BookHospitalScreenState extends State<BookHospitalScreen> {
  static int _remainingData = 0;

  _bookHospitalButton() {
    String _userId = FirebaseAuth.instance.currentUser!.uid.toString();
    CollectionReference _bookBed =
        FirebaseFirestore.instance.collection("bookBed");
    return _bookBed.doc(_userId).set({
      "userId": _userId,
      "ward": widget.hospitalName,
      "contact": widget.hospitalContact,
      "totalBed": _remainingData,
    }).then((value) =>
        FirebaseFirestore.instance.collection("ward").doc(widget.id).update({
          "availableBeds":
              int.parse(widget.hospitalRemainingBeds) - _remainingData,
        }));
  }

  @override
  Widget build(BuildContext context) {
    _onCheckMinusvalue() {
      if (_remainingData == 0) {
        return null;
      } else {
        _remainingData--;
      }
    }

    return Scaffold(
      appBar: myAppBar("Book Hospital"),
      drawer: MyDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 40.0,
              ),
              Text(
                "Emergency Bed in " + widget.hospitalName,
                style: MyStyles.headingFour,
              ),
              SizedBox(
                height: 24.0,
              ),
              Card(
                elevation: 2.0,
                shadowColor: Colors.grey,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.hospitalName,
                        style: MyStyles.headingFour,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text("Contact: " + widget.hospitalContact),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        "Addrees: " + "MahaBouddha",
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 2.0,
                shadowColor: Colors.grey,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Beds: " + widget.hospitalTotalBeds),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text("Remainig Beds: " + widget.hospitalRemainingBeds),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Wrap(
              children: [
                IconButton(
                  iconSize: 40.0,
                  onPressed: () {
                    setState(() {
                      _remainingData++;
                    });
                  },
                  icon: Icon(CupertinoIcons.add_circled),
                ),
                Container(
                  margin: EdgeInsets.only(left: 8.0, right: 8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Text(
                    "$_remainingData",
                    style: MyStyles.headingFour,
                  ),
                ),
                IconButton(
                  iconSize: 40.0,
                  onPressed: () {
                    setState(() {
                      _onCheckMinusvalue();
                    });
                  },
                  icon: Icon(CupertinoIcons.minus_circle),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _bookHospitalButton();
              },
              child: Text(
                "Book",
                style: MyStyles.headingFour,
              ),
            ),
          )
        ],
      ),
    );
  }
}

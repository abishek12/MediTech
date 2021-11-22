import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medicalapp/screen/nearby.dart';
import 'package:medicalapp/screen/seeall.dart';
import 'package:medicalapp/screen/vaccine_book.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';

class VaccineScreen extends StatefulWidget {
  @override
  _VaccineScreenState createState() => _VaccineScreenState();
}

class _VaccineScreenState extends State<VaccineScreen> {
  @override
  Widget build(BuildContext context) {
    String lat = "";
    String long = "";

    getCurrentUserLocation() async {
      final geoPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        lat = "${geoPosition.latitude}";
        long = "${geoPosition.longitude}";
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  NearByScreen(latitude: lat, longitude: long)));
    }

    return Scaffold(
      appBar: myAppBar("Vaccine"),
      drawer: MyDrawer(),
      body: Container(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  getCurrentUserLocation();
                },
                child: Text("Near By"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SeeAll()));
                },
                child: Text("See All"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

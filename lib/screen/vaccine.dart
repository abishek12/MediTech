import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medicalapp/screen/nearby.dart';
import 'package:medicalapp/screen/seeall.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  getCurrentUserLocation();
                },
                child: Text("Near By"),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SeeAll()));
                },
                child: Text("See All"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

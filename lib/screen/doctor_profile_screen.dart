import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({Key? key}) : super(key: key);

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
                      Text("Abishek Khanal"),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text("abishek@gmail.com"),
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
                      Text("300+"),
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
                      Text("300+"),
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
                      Text("300+"),
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
                  Text("Register Number"),
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
                  Text("9860162323"),
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
                  Text("Dhungedhara-4, Kathmandu, Nepal"),
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
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec gravida vitae ex sit amet commodo. Curabitur quam risus, porttitor eget pulvinar a, porta sed sem. Nam quis porttitor est. Mauris non dui quis purus pharetra congue. Suspendisse elementum magna nisl, ut euismod erat lobortis eu. Pellentesque id felis rhoncus, egestas ex a, semper tellus. Donec tempus fringilla mi, id molestie mauris aliquet eu. Praesent at tempus est, eu volutpat dui. Etiam vitae leo a mauris tincidunt lacinia vitae nec sapien. Aenean id eros a enim gravida feugiat at ac eros. Nullam hendrerit arcu vel finibus aliquet. Donec sollicitudin nisi vitae.",
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

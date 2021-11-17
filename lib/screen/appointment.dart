import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/screen/appointment_based_category.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Appointment"),
      drawer: MyDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.white30)),
              child: Text("Hey, Abishek Khanal"),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      "Category",
                      style: MyStyles.headingFour,
                    ),
                  ),
                  //ancology
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentBasedCategory(category: "Cardiology",),
                        )),
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/icons/heart.png"),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Cardiology",
                                    style: MyStyles.paragraph,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  //brain
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentBasedCategory(category: "Brain",),
                        )),
                    child: Container(
                      margin: EdgeInsets.only(top: 16.0),
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/icons/brain.png"),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Brain",
                                    style: MyStyles.paragraph,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  //ancology
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentBasedCategory(category: "Neuro",),
                        )),
                    child: Container(
                      margin: EdgeInsets.only(top: 16.0),
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/icons/nervous.png"),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Neuro",
                                    style: MyStyles.paragraph,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //top rated doctor
            Container(
              margin: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Top Rated Doctor",
                          style: MyStyles.headingFour,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, "/doctor"),
                          child: Text(
                            "View all",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white54),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Image.asset("assets/icons/heart.png"),
                      ),
                      title: Text("Doctor Name"),
                      subtitle: Text("Some this"),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white54),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Image.asset("assets/icons/heart.png"),
                      ),
                      title: Text("Doctor Name"),
                      subtitle: Text("Some this"),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white54),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Image.asset("assets/icons/heart.png"),
                      ),
                      title: Text("Doctor Name"),
                      subtitle: Text("Some this"),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white54),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Image.asset("assets/icons/heart.png"),
                      ),
                      title: Text("Doctor Name"),
                      subtitle: Text("Some this"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

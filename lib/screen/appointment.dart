import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/screen/appointment_based_category.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';

import 'doctor_profile_screen.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dt = DateTime.now();

    return Scaffold(
      appBar: myAppBar("Appointment"),
      drawer: MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.white30)),
            child: Text("Time: ${dt.hour}-${dt.minute}-${dt.second} | Date: ${dt.day}/${dt.month}/${dt.year}"),
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
                        builder: (context) => AppointmentBasedCategory(
                          category: "Cardiology",
                        ),
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
                        builder: (context) => AppointmentBasedCategory(
                          category: "Brain",
                        ),
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
                        builder: (context) => AppointmentBasedCategory(
                          category: "Neuro",
                        ),
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
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                    "View All",
                    style: MyStyles.headingFour,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: DoctorRatingScreen())
        ],
      ),
    );
  }
}

class DoctorRatingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('user')
          .limit(3)
          .where("role", isEqualTo: "doctor")
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');
        if (snapshot.hasData) {
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (_, i) {
              final data = docs[i].data();
              return Container(
                margin: EdgeInsets.all(16.0),
                child: Container(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage("assets/images/doctor1.jpg"),
                    ),
                    title: Text(
                      data['fullName'],
                    ),
                    subtitle: Text(
                      data['email'],
                    ),
                    trailing: IconButton(
                      icon: Icon(CupertinoIcons.arrow_right_circle),
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DoctorProfileScreen(
                                    docId: snapshot.data!.docs[i].id,
                                    fullName: data['fullName'],
                                    email: data['email'],
                                    rating: data['rating'],
                                    address: data['address'],
                                    contact: data['contact'],
                                    licensesNumber: data['licenses_number'],
                                    description: data['description'],
                                  ))),
                    ),
                  ),
                ),
              );
            },
          );
        }

        return Center(child: Text("Nothing to display"));
      },
    );
  }
}

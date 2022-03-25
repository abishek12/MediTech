import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/screen/chatrooms.dart';
import 'package:medicalapp/screen/doctor_dailly_appointment.dart';
import 'package:medicalapp/screen/login_screen.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_carousel.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'doctor_profile_screen.dart';

class CheckUserRole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("something went wrong"),
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          default:
            if (snapshot.data!['role'] == "patient") {
              return PatientHomeScreen();
            }
            if (snapshot.data!['role'] == "doctor") {
              return DoctorHomeScreen();
            } else {
              return LoginScreen();
            }
        }
      },
    );
  }
}

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Doctor (Home)"),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text('Tap back again to logout'),
          action: SnackBarAction(
              label: "Logout",
              onPressed: () {
                FirebaseAuth.instance.signOut();
              }),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 200,
                    child: CarouselHomePage(),
                  ),
                ),
                //profile
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/doctorDashboard"),
                  child: Container(
                    margin: EdgeInsets.all(16.0),
                    child: Card(
                      child: ListTile(
                        leading: Icon(CupertinoIcons.square_grid_4x3_fill),
                        title: Text("Profile"),
                      ),
                    ),
                  ),
                ),
                //chat
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatRoom())),
                  child: Container(
                    margin: EdgeInsets.all(16.0),
                    child: Card(
                      child: ListTile(
                        leading: Icon(CupertinoIcons.chat_bubble_2),
                        title: Text("Chat"),
                      ),
                    ),
                  ),
                ),
                //chat
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TodaysAppointment())),
                  child: Container(
                    margin: EdgeInsets.all(16.0),
                    child: Card(
                      child: ListTile(
                        leading: Icon(CupertinoIcons.chat_bubble_2),
                        title: Text("Today's Appointment"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PatientHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    return Scaffold(
      appBar: myAppBar("Home"),
      drawer: MyDrawer(),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text('Tap back again to logout'),
          action: SnackBarAction(
              label: "Logout",
              onPressed: () {
                FirebaseAuth.instance.signOut();
              }),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(16.0),
                child: SizedBox(height: 200, child: CarouselHomePage()),
              ),
              Container(
                margin: EdgeInsets.only(top: 16.0, left: 16.0),
                child: Text(
                  "Choose the type of events",
                  style: MyStyles.headingFour,
                ),
              ),
              // divider
              Container(
                margin: EdgeInsets.all(18.0),
                width: MediaQuery.of(context).size.width,
                height: 5.0,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              // choose items first items
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // first item
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, "/vaccine"),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            child: Image.asset("assets/icons/vaccine.png"),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          "Vaccine",
                          style: MyStyles.paragraph,
                        ),
                      ],
                    ),
                    // second item
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, "/doctor"),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            child: Image.asset("assets/icons/doctor.png"),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          "Doctor",
                          style: MyStyles.paragraph,
                        ),
                      ],
                    ),
                    // third item
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, "/lab"),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            child: Image.asset("assets/icons/labtest.png"),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          "Lab Test",
                          style: MyStyles.paragraph,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              // second row for items
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // fourth item
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, "/hospital"),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            child: Image.asset("assets/icons/hospitalbed.png"),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          "Hospital",
                          style: MyStyles.paragraph,
                        ),
                      ],
                    ),
                    // fifth item
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Text("Contact Us"),
                                    content: Column(
                                      children: [
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        // contact number
                                        Container(
                                          padding: EdgeInsets.all(8.0),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("+977 9860162323"),
                                              GestureDetector(
                                                onTap: () {
                                                  launch(Uri(
                                                    scheme: 'tel',
                                                    path: "9860162323",
                                                  ).toString());
                                                },
                                                child: Container(
                                                  child: Icon(
                                                      CupertinoIcons.phone),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        // contact email
                                        Container(
                                          padding: EdgeInsets.all(8.0),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "abishekkhanal2056@gmail.com"),
                                              GestureDetector(
                                                onTap: () {
                                                  launch(Uri(
                                                    scheme: 'mailto',
                                                    path:
                                                        'abishekkhanal2056@gmail.com',
                                                    query:
                                                        encodeQueryParameters(<
                                                            String, String>{
                                                      'subject':
                                                          'Contact Us Section'
                                                    }),
                                                  ).toString());
                                                },
                                                child: Container(
                                                  child: Icon(
                                                    CupertinoIcons.mail,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      Container(
                                        margin: EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("Close"),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            child: Image.asset("assets/icons/mobile.png"),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          "Contact Us",
                          style: MyStyles.paragraph,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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

class CarouselHomePage extends StatelessWidget {
  const CarouselHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('carousel').snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');
        if (snapshot.hasData) {
          final docs = snapshot.data!.docs;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (_, i) {
              final data = docs[i].data();
              return Container(
                margin: EdgeInsets.all(16.0),
                child: Card(
                  elevation: 2.0,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: CustomCarousel(
                      imageName: data['imageURL'],
                    ),
                  ),
                ),
              );
            },
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

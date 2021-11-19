import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/screen/login_screen.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_carousel.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';
import 'package:medicalapp/widgets/doctor_carousel.dart';

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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        CustomCarousel(
                          imageName: "doctor1.jpg",
                          imageDescription: "First Image",
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        CustomCarousel(
                          imageName: "doctor2.jpg",
                          imageDescription: "First Image",
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        CustomCarousel(
                          imageName: "doctor3.jpg",
                          imageDescription: "First Image",
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        CustomCarousel(
                          imageName: "doctor1.jpg",
                          imageDescription: "First Image",
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        CustomCarousel(
                          imageName: "doctor2.jpg",
                          imageDescription: "First Image",
                        ),
                      ],
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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        CustomCarousel(
                          imageName: "doctor1.jpg",
                          imageDescription: "First Image",
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        CustomCarousel(
                          imageName: "doctor2.jpg",
                          imageDescription: "First Image",
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        CustomCarousel(
                          imageName: "doctor3.jpg",
                          imageDescription: "First Image",
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        CustomCarousel(
                          imageName: "doctor1.jpg",
                          imageDescription: "First Image",
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        CustomCarousel(
                          imageName: "doctor2.jpg",
                          imageDescription: "First Image",
                        ),
                      ],
                    ),
                  ),
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
                            onTap: () =>
                                Navigator.pushNamed(context, "/vaccine"),
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
                            onTap: () =>
                                Navigator.pushNamed(context, "/doctor"),
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
                              child:
                                  Image.asset("assets/icons/hospitalbed.png"),
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("+977 9860162323"),
                                                GestureDetector(
                                                  onTap: () {
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text:
                                                                "9860162323"));
                                                  },
                                                  child: Container(
                                                    child: Icon(CupertinoIcons
                                                        .square_on_square),
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("support@abishek.com"),
                                                GestureDetector(
                                                  onTap: () {
                                                    Clipboard.setData(ClipboardData(
                                                        text:
                                                            "support@abishek.com"));
                                                  },
                                                  child: Container(
                                                    child: Icon(
                                                      CupertinoIcons
                                                          .square_on_square,
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
                Container(
                  margin: EdgeInsets.only(top: 16.0, left: 16.0),
                  child: Text(
                    "Top Rated Doctor",
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
                // top rated doctor
                SizedBox(
                  height: 120,
                  child: Container(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        TopRatedDoctor(
                            imageName: "doctor1.jpg",
                            doctorName: "Abishek Khanal",
                            doctorEmail: "abishek@gmail.com",
                            likes: 30),
                        TopRatedDoctor(
                            imageName: "doctor2.jpg",
                            doctorName: "Abishek Khanal",
                            doctorEmail: "abishek@gmail.com",
                            likes: 30),
                        TopRatedDoctor(
                            imageName: "doctor3.jpg",
                            doctorName: "Abishek Khanal",
                            doctorEmail: "abishek@gmail.com",
                            likes: 30),
                        TopRatedDoctor(
                            imageName: "doctor1.jpg",
                            doctorName: "Abishek Khanal",
                            doctorEmail: "abishek@gmail.com",
                            likes: 30),
                        TopRatedDoctor(
                            imageName: "doctor2.jpg",
                            doctorName: "Abishek Khanal",
                            doctorEmail: "abishek@gmail.com",
                            likes: 30),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

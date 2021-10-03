import 'package:flutter/material.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';
import 'package:medicalapp/widgets/doctor_carousel.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Doctor"),
      drawer: MyDrawer(),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, "/doctorProfile"),
            child: TopRatedDoctor(
              imageName: "doctor1.jpg",
              doctorName: "Ram Subedi",
              doctorEmail: "ram@gmail.com",
              likes: 500,
            ),
          ),
          TopRatedDoctor(
            imageName: "doctor1.jpg",
            doctorName: "Ram Subedi",
            doctorEmail: "ram@gmail.com",
            likes: 500,
          ),
          TopRatedDoctor(
            imageName: "doctor1.jpg",
            doctorName: "Ram Subedi",
            doctorEmail: "ram@gmail.com",
            likes: 500,
          ),
          TopRatedDoctor(
            imageName: "doctor1.jpg",
            doctorName: "Ram Subedi",
            doctorEmail: "ram@gmail.com",
            likes: 500,
          ),
          TopRatedDoctor(
            imageName: "doctor1.jpg",
            doctorName: "Ram Subedi",
            doctorEmail: "ram@gmail.com",
            likes: 500,
          ),
          TopRatedDoctor(
            imageName: "doctor1.jpg",
            doctorName: "Ram Subedi",
            doctorEmail: "ram@gmail.com",
            likes: 500,
          ),
          TopRatedDoctor(
            imageName: "doctor1.jpg",
            doctorName: "Ram Subedi",
            doctorEmail: "ram@gmail.com",
            likes: 500,
          ),
          TopRatedDoctor(
            imageName: "doctor1.jpg",
            doctorName: "Ram Subedi",
            doctorEmail: "ram@gmail.com",
            likes: 500,
          ),
        ],
      ),
    );
  }
}

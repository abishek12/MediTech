import 'package:flutter/material.dart';
import 'package:medicalapp/constants/colors.dart';
import 'package:medicalapp/constants/routes.dart';
import 'package:medicalapp/screen/beds.dart';
import 'package:medicalapp/screen/chat_screen.dart';
import 'package:medicalapp/screen/dashboard_screen.dart';
import 'package:medicalapp/screen/doctor_profile_screen.dart';
import 'package:medicalapp/screen/doctors_screen.dart';
import 'package:medicalapp/screen/home_screen.dart';
import 'package:medicalapp/screen/hospital_screen.dart';
import 'package:medicalapp/screen/lab_payment_screen.dart';
import 'package:medicalapp/screen/lab_screen.dart';
import 'package:medicalapp/screen/landing_screen.dart';
import 'package:medicalapp/screen/login_screen.dart';
import 'package:medicalapp/screen/register_patient.dart';
import 'package:medicalapp/screen/register_screen.dart';
import 'package:medicalapp/screen/settings.dart';
import 'package:medicalapp/screen/vaccine.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: MyRoutes.landingScreen,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(MyColor.backgroundColor),
        ),
        routes: {
          MyRoutes.landingScreen: (context) => LandingScreen(),
          MyRoutes.loginScreen: (context) => LoginScreen(),
          MyRoutes.registerScreen: (context) => RegisterScreen(),
          MyRoutes.registerPatientScreen: (context) => RegisterPatientScreen(),
          MyRoutes.homeScreen: (context) => HomeScreen(),
          MyRoutes.chatScreen: (context) => ChatScreen(),
          MyRoutes.doctorScreen: (context) => DoctorScreen(),
          MyRoutes.bedScreen: (context) => BedScreen(),
          MyRoutes.dashboardScreen: (context) => DashboardScreen(),
          MyRoutes.labScreen: (context) => LabScreen(),
          MyRoutes.settingsScreen: (context) => SettingsScreen(),
          MyRoutes.labPaymentScreen: (context) => LabPaymentScreen(),
          MyRoutes.vaccineScreen: (context) => VaccineScreen(),
          MyRoutes.hospitalScreen: (context) => HospitalScreen(),
        });
  }
}

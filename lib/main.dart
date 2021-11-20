import 'package:flutter/material.dart';
import 'package:medicalapp/constants/colors.dart';
import 'package:medicalapp/constants/routes.dart';
import 'package:medicalapp/screen/appointment.dart';
import 'package:medicalapp/screen/beds.dart';
import 'package:medicalapp/screen/chat_screen.dart';
import 'package:medicalapp/screen/dashboard_screen.dart';
import 'package:medicalapp/screen/doctor_dashboard_screen.dart';
import 'package:medicalapp/screen/doctor_profile_edit_screen.dart';
import 'package:medicalapp/screen/doctors_screen.dart';
import 'package:medicalapp/screen/home_screen.dart';
import 'package:medicalapp/screen/hospital_screen.dart';
import 'package:medicalapp/screen/lab_payment_screen.dart';
import 'package:medicalapp/screen/lab_screen.dart';
import 'package:medicalapp/screen/landing_screen.dart';
import 'package:medicalapp/screen/login_screen.dart';
import 'package:medicalapp/screen/profile_edit_screen.dart';
import 'package:medicalapp/screen/register_patient.dart';
import 'package:medicalapp/screen/register_screen.dart';
import 'package:medicalapp/screen/vaccine.dart';
import 'package:medicalapp/screen/settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
          MyRoutes.homeScreen: (context) => CheckUserRole(),
          MyRoutes.chatScreen: (context) => ChatScreen(),
          MyRoutes.doctorScreen: (context) => DoctorScreen(),
          MyRoutes.bedScreen: (context) => BedScreen(),
          MyRoutes.dashboardScreen: (context) => DashboardScreen(),
          MyRoutes.doctorDashboardScreen: (context) => DoctorDashboardScreen(),
          MyRoutes.editProfileScreen: (context) => ProfileEditScreen(),
          MyRoutes.editDoctorProfileScreen: (context) => DoctorProfileEditScreen(),
          MyRoutes.labScreen: (context) => LabScreen(),
          MyRoutes.settingsScreen: (context) => SettingsScreen(),
          MyRoutes.labPaymentScreen: (context) => LabPaymentScreen(),
          MyRoutes.vaccineScreen: (context) => VaccineScreen(),
          MyRoutes.hospitalScreen: (context) => HospitalScreen(),
          MyRoutes.appointmentScreen: (context) => AppointmentScreen(),
        });
  }
}

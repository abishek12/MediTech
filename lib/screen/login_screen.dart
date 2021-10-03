import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/widgets/custom_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _email = "";
    String _password = "";

    void _dialogBox(String content) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text("Error"),
              content: Text(content),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Close"))
              ],
            );
          });
    }

    Future<void> _loginUser() async {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        await Navigator.pushNamed(context, "/landing");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          return _dialogBox('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          return _dialogBox('Wrong password provided for that user.');
        }
      }
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcom To Medical Application"),
            Container(
              margin: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomTextField(
                    helperText: "Email",
                    hintText: 'Enter email address',
                    obscureText: false,
                    onChanged: (value) {
                      _email = value;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  CustomTextField(
                    helperText: "Password",
                    hintText: 'Enter password',
                    obscureText: true,
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        _loginUser();
                      },
                      child: Text("Login"),
                    ),
                  ),
                ],
              ),
            ),
            Text("Create account as"),
            SizedBox(
              height: 16.0,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, "/registerDoctor"),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Image.asset("assets/icons/doctor.png"),
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, "/registerPatient"),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Image.asset("assets/icons/patient.png"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

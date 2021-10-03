import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/widgets/custom_text.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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

    Future<void> _registerDoctor() async {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushNamed(context, "/login");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          _dialogBox('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          _dialogBox('The account already exists for that email.');
        }
      } catch (e) {
        _dialogBox(e.toString());
      }
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Register as a Doctor"),
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
                      onPressed: () => _registerDoctor(),
                      child: Text("Login"),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Back To Login"),
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

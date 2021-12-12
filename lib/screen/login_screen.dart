import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

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
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: "${_emailController.text}",
            password: "${_passwordController.text}");
        await Navigator.pushNamed(context, "/landing");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          return _dialogBox('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          return _dialogBox('Wrong password provided for that user.');
        }
      }
      print("Working");
      print("${_emailController.text}+${_passwordController.text}");
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
                  Container(
                    margin: EdgeInsets.all(16.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                    ),
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
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, "/registerPatient"),
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
      ),
    );
  }
}

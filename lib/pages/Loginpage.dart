import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';
import '../helper/helperfunction.dart';
import '../services/databaseservice.dart';
import '../widgets/widgets.dart';
import 'Homepage.dart';
import 'registerpage.dart';
import 'admin_home.dart'; // Import the AdminHomePage

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _isLoading = false;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/emergify_logo.png",
                width: 40,
                height: 40,
              ),
              SizedBox(width: 8),
              Text(
                "EMERGIFY",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
      )
          : SingleChildScrollView(
        child: Container(
          color: Colors.lightBlue.shade50, // Light blue background
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Login Now",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: "Email or Username",
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.blueAccent,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 2.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 2.0,
                            ),
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        validator: (val) {
                          return RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(val!)
                              ? null
                              : "Please enter a valid email";
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                          labelText: "Password",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.blueAccent,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 2.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator: (val) {
                          if (val!.length < 6) {
                            return "Password must be at least 6 characters";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      login();
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Register here",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            nextScreen(context, RegisterPage());
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    if (formKey.currentState!.validate()) {
      // Check for admin credentials
      if (email == "ok@gmail.com" && password == "1234567") {
        nextScreenReplace(context, AdminHomePage()); // Navigate to AdminHomePage
        return;
      }

      setState(() {
        _isLoading = true;
      });

      await authService.loginWithUserNameandPassword(email, password).then((value) async {
        if (value == true) {
          // Saving the shared preference state
          QuerySnapshot snapshot = await DatabaseService(
              uid: FirebaseAuth.instance.currentUser!.uid)
              .gettingUserData(email);
          // Saving the values to our shared preferences
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(snapshot.docs[0]['fullName']);
          nextScreenReplace(context, HomePage());
        } else {
          showSnackbar(context, Colors.blueAccent, value); // Use Colors.blueAccent for the Snackbar
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  void showSnackbar(BuildContext context, Color color, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

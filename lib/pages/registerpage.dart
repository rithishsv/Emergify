import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:emergify/services/auth_service.dart';
import '../helper/helperfunction.dart';
import '../widgets/widgets.dart';
import 'Homepage.dart';
import 'LoginPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  String phoneNumber = "";
  bool _isloading = false;
  String confirmPassword = "";
  String address = "";
  String bloodType = "";
  String medications = "";
  String allergies = "";
  String emergencyContact = "";
  AuthService authService = AuthService();

  String? medicationsText;
  String? allergiesText;

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
                  "Create your account now",
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
                          labelText: "Full Name",
                          prefixIcon: Icon(
                            Icons.person,
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
                            fullName = val;
                          });
                        },
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return "Name cannot be empty";
                          }
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: "Email",
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
                      SizedBox(height: 15),
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
                      SizedBox(height: 15),
                      TextFormField(
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                          labelText: "Confirm Password",
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
                        onChanged: (val) {
                          setState(() {
                            confirmPassword = val;
                          });
                        },
                        validator: (val) {
                          return val != password ? 'Passwords do not match' : null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Phone Number',
                          prefixIcon: Icon(
                            Icons.phone,
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
                            phoneNumber = val;
                          });
                        },
                        validator: (val) {
                          return val!.isEmpty ? 'Phone number cannot be empty' : null;
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Medical Information',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Address',
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
                            address = val;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Blood Type',
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
                            bloodType = val;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Under any medications? '),
                          Radio(
                            value: 'yes',
                            groupValue: medications,
                            activeColor: Colors.blueAccent,
                            onChanged: (val) {
                              setState(() {
                                medications = val.toString();
                              });
                            },
                          ),
                          Text('Yes'),
                          Radio(
                            value: 'no',
                            groupValue: medications,
                            activeColor: Colors.blueAccent,
                            onChanged: (val) {
                              setState(() {
                                medications = val.toString();
                              });
                            },
                          ),
                          Text('No'),
                        ],
                      ),
                      medications == 'yes'
                          ? TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Specify if yes',
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
                            medicationsText = val;
                          });
                        },
                      )
                          : SizedBox(),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Any allergies? '),
                          Radio(
                            value: 'yes',
                            groupValue: allergies,
                            activeColor: Colors.blueAccent,
                            onChanged: (val) {
                              setState(() {
                                allergies = val.toString();
                              });
                            },
                          ),
                          Text('Yes'),
                          Radio(
                            value: 'no',
                            groupValue: allergies,
                            activeColor: Colors.blueAccent,
                            onChanged: (val) {
                              setState(() {
                                allergies = val.toString();
                              });
                            },
                          ),
                          Text('No'),
                        ],
                      ),
                      allergies == 'yes'
                          ? TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Specify if yes',
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
                            allergiesText = val;
                          });
                        },
                      )
                          : SizedBox(),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Emergency Contact Number',
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
                            emergencyContact = val;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () {
                            register();
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text.rich(
                        TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Login now",
                              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  nextScreen(context, LoginPage());
                                },
                            ),
                          ],
                        ),
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

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(fullName, email, password, phoneNumber, address, bloodType, medications, medicationsText ?? "", allergies, allergiesText ?? "", emergencyContact)
          .then((value) async {
        if (value == true) {
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);
          nextScreenReplace(context, HomePage());
        } else {
          showSnackbar(context, Colors.blue, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}

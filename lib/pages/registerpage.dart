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
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
      )
          : Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Emergify",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Create your account now",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: "Full Name",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).primaryColor,
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
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: "Email",
                      prefixIcon: Icon(
                        Icons.email,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                    validator: (val) {
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ? null : "Please enter a valid email";
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(
                      labelText: "Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).primaryColor,
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
                  const SizedBox(height: 15),
                  TextFormField(
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(
                      labelText: "Confirm Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).primaryColor,
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
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Theme.of(context).primaryColor,
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
                  const SizedBox(height: 15),
                  // Medical Information Section
                  Text(
                    'Medical Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'Address'),
                    onChanged: (val) {
                      setState(() {
                        address = val;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'Blood Type'),
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
                    decoration: textInputDecoration.copyWith(labelText: 'Specify if yes'),
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
                    decoration: textInputDecoration.copyWith(labelText: 'Specify if yes'),
                    onChanged: (val) {
                      setState(() {
                        allergiesText = val;
                      });
                    },
                  )
                      : SizedBox(),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'Emergency Contact Number'),
                    onChanged: (val) {
                      setState(() {
                        emergencyContact = val;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {
                        register();
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Login now",
                          style: const TextStyle(color: Colors.black, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              nextScreen(context, const LoginPage());
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
      ),
    );
  }

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(fullName, email, password, phoneNumber, address, bloodType,medications,medicationsText ?? "",allergies,allergiesText ?? "",emergencyContact)
          .then((value) async {
        if (value == true) {
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);
          nextScreenReplace(context, const Homepage());
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}

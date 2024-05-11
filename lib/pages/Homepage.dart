import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_screeen.dart'; // Import the ProfileScreen
import 'user_manual.dart'; // Import the UserManualPage
import 'logout_page.dart'; // Import the LogoutPage
import 'report_emergency.dart'; // Import the ReportEmergencyPage
import 'success_screen.dart'; // Import the SuccessScreen

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedNature = 'Medical'; // Default value for nature of emergency
  String _fullName = ''; // Full name of the user
  String _email = '';
  String _phoneNumber = ''; // Phone number of the user
  String _address = ''; // Address of the user
  String _bloodType = ''; // Blood type of the user
  String _medications = ''; // Medications of the user
  String _medicationsText = ''; // Additional information about medications
  // Add other variables as needed// Email of the user

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        _fullName = snapshot['fullName'];
        _email = snapshot['email'];
        _phoneNumber = snapshot['phoneNumber'];
        _address = snapshot['address'];
        _bloodType = snapshot['bloodType'];
        _medications = snapshot['medications'];
        _medicationsText = snapshot['medicationsText'];
        // Assign other fields similarly
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Set the background color to blue
        title: Center(
          child: Text(
            'Emerfigy', // Title of the AppBar
            style: TextStyle(color: Colors.white), // White color for the title text
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Help Me',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showEmergencyDialog(context); // Show emergency dialog
                },
                child: Text('Need Help'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReportEmergencyPage()), // Navigate to ReportEmergencyPage
                  );
                },
                child: Text('Report Emergency'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen(userData: {},)), // Navigate to ProfileScreen
                  );
                },
                child: Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blue, // Set drawer background color
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(_fullName, style: TextStyle(fontSize: 20.0)),
                accountEmail: Text(_email, style: TextStyle(fontSize: 16.0)),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white, // Placeholder for user's profile picture
                  child: Icon(Icons.person),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text(
                  'View Profile',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen(userData: {
                      'fullName': _fullName,
                      'email': _email,
                      'phoneNumber': _phoneNumber,
                      'address': _address,
                      'bloodType': _bloodType,
                      'medications': _medications,
                      'medicationsText': _medicationsText,
                    },)), // Navigate to ProfileScreen
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.library_books),
                title: Text(
                  'User Manual',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserManualPage()), // Navigate to UserManualPage
                  );
                },
              ),
              Expanded(
                // Wrap the ListTile in an Expanded widget
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(
                      'Logout',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogoutPage()), // Navigate to LogoutPage
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEmergencyDialog(BuildContext context) {
    // Emergency dialog code
  }

// Other methods
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

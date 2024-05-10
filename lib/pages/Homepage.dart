import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
                    MaterialPageRoute(builder: (context) => ProfileScreen()), // Navigate to ProfileScreen
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
                accountName: Text('John Doe', style: TextStyle(fontSize: 20.0)), // Placeholder for user's name
                accountEmail: Text(
                  'johndoe@example.com',
                  style: TextStyle(fontSize: 16.0),
                ), // Placeholder for user's email
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
                    MaterialPageRoute(builder: (context) => ProfileScreen()), // Navigate to ProfileScreen
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Emergency Situation'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Select Nature of Emergency:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 10),
                  _buildRadioListTile(setState, 'Medical Emergency', 'medical'),
                  _buildRadioListTile(setState, 'Fire Emergency', 'fire'),
                  _buildRadioListTile(setState, 'Crime and Safety Emergency', 'crime_and_safety'),
                  _buildRadioListTile(setState, 'Traffic Emergency', 'traffic'),
                ],
              );
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                _handleSubmit(context); // Submit the emergency
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRadioListTile(StateSetter setState, String title, String value) {
    return RadioListTile(
      title: Text(title),
      value: value,
      groupValue: _selectedNature,
      onChanged: (String? newValue) {
        setState(() {
          _selectedNature = newValue!;
        });
      },
    );
  }

  void _handleSubmit(BuildContext context) {
    // Perform form submission logic
    // For demonstration purposes, let's just navigate to SuccessScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuccessScreen()),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

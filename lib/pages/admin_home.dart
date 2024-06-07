import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_screeen.dart'; // Import the ProfileScreen
import 'user_manual.dart'; // Import the UserManualPage
import 'logout_page.dart'; // Import the LogoutPage
import 'report_emergency.dart'; // Import the ReportEmergencyPage
import 'update_profile_page.dart'; // Import the UpdateProfilePage
import 'userpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AdminHomePage(),
    );
  }
}

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Set the background color to blue
        title: Center(
          child: Text(
            'Admin Home', // Title of the AppBar
            style: TextStyle(color: Colors.white, fontSize: 24), // White color for the title text
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/emergify_logo.png', // Use the logo image
                height: 100.0,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  foregroundColor: Colors.white, // Text color
                  minimumSize: Size(double.infinity, 50), // Full-width button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmergencyReportsPage()),
                  );
                },
                child: Text('View Emergency Reports', style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  foregroundColor: Colors.white, // Text color
                  minimumSize: Size(double.infinity, 50), // Full-width button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UsersPage()),
                  );
                },
                child: Text('View Users', style: TextStyle(fontSize: 18)),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  foregroundColor: Colors.white, // Text color
                  minimumSize: Size(double.infinity, 50), // Full-width button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LocateHelperPage()),
                  );
                },
                child: Text('Locate Available Helper', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Admin Name', style: TextStyle(fontSize: 20.0)),
              accountEmail: Text('admin@example.com', style: TextStyle(fontSize: 16.0)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white, // Placeholder for user's profile picture
                child: Icon(Icons.person, size: 40, color: Colors.blue),
              ),
              decoration: BoxDecoration(color: Colors.blue), // Set background color of the header
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color: Colors.blue),
              title: Text(
                'View Profile',
                style: TextStyle(fontSize: 18.0, color: Colors.blue),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(userData: {
                        'fullName': 'Admin Name',
                        'email': 'admin@example.com',
                        'phoneNumber': '1234567890',
                        'address': '123 Admin St',
                        'bloodType': 'O+',
                        'medications': 'None',
                        'medicationsText': '',
                        'allergies': 'None',
                        'allergiesText': '',
                        'emergencyContact': '9876543210',
                      })), // Navigate to ProfileScreen
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.library_books, color: Colors.blue),
              title: Text(
                'User Manual',
                style: TextStyle(fontSize: 18.0, color: Colors.blue),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserManualPage()), // Navigate to UserManualPage
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.blue),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18.0, color: Colors.blue),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LogoutPage()), // Navigate to LogoutPage
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}



class EmergencyReportsPage extends StatelessWidget {
  final List<String> reports = ['Report1', 'Report2', 'Report3']; // Sample report data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Set the background color to blue
        title: Center(
          child: Text(
            'Emergency Reports', // Title of the AppBar
            style: TextStyle(color: Colors.white, fontSize: 24), // White color for the title text
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: reports.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(reports[index]),
            );
          },
        ),
      ),
    );
  }
}

class LocateHelperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement the UI for locating available helpers
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Set the background color to blue
        title: Center(
          child: Text(
            'Locate Available Helper', // Title of the AppBar
            style: TextStyle(color: Colors.white, fontSize: 24), // White color for the title text
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Functionality to locate available helpers will be implemented here.',
          style: TextStyle(fontSize: 18.0, color: Colors.black54),
        ),
      ),
    );
  }
}

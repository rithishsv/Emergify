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
              accountName: Text('Sanjeevani', style: TextStyle(fontSize: 20.0)),
              accountEmail: Text('sanjeevani@gmail.com', style: TextStyle(fontSize: 16.0)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white, // Placeholder for user's profile picture
                child: Icon(Icons.person, size: 40, color: Colors.blue),
              ),
              decoration: BoxDecoration(color: Colors.blue), // Set background color of the header
            ),





            ListTile(
              leading: Icon(Icons.info, color: Colors.blue),
              title: Text('License and Address', style: TextStyle(fontSize: 18.0, color: Colors.blue)),
              onTap: () {
                // Add functionality here if needed, e.g., navigate to a detailed page
              },
              subtitle: Text(
                'License No: 123-456-789\nAddress: 456 NGO Lane, Charity City, 12345',
                style: TextStyle(fontSize: 14.0),
              ),
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

class Helper {
  final String name;
  final String email;
  final String phoneNumber;
  final String location;  // Added location field

  Helper({required this.name, required this.email, required this.phoneNumber, required this.location});
}


class LocateHelperPage extends StatelessWidget {
  final List<Helper> helpers = [
    Helper(name: 'Alice Johnson',
        email: 'alice.johnson@example.com',
        phoneNumber: '123-456-7890',
        location: 'New York, NY'),
    Helper(name: 'Bob Smith',
        email: 'bob.smith@example.com',
        phoneNumber: '234-567-8901',
        location: 'San Francisco, CA'),
    Helper(name: 'Charlie Brown',
        email: 'charlie.brown@example.com',
        phoneNumber: '345-678-9012',
        location: 'Chicago, IL'),
    Helper(name: 'David Wilson',
        email: 'david.wilson@example.com',
        phoneNumber: '456-789-0123',
        location: 'Miami, FL'),
    Helper(name: 'Eva Green',
        email: 'eva.green@example.com',
        phoneNumber: '567-890-1234',
        location: 'Dallas, TX'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Locate Available Helper',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: ListView.builder(
        itemCount: helpers.length,
        itemBuilder: (context, index) {
          final helper = helpers[index];
          return ListTile(
            title: Text(helper.name),
            subtitle: Text(
                '${helper.email}\n${helper.phoneNumber}\nLocation: ${helper
                    .location}'), // Include location in subtitle
            trailing: IconButton(
              icon: Icon(Icons.notification_important, color: Colors.blue),
              onPressed: () {
                // Here we invoke the notification logic (placeholder)
                print('Notify ${helper.name}');
                // Show a SnackBar after the notification action
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Successfully notified ${helper.name}'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
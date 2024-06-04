import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_screeen.dart'; // Import the ProfileScreen
import 'user_manual.dart'; // Import the UserManualPage
import 'logout_page.dart'; // Import the LogoutPage
import 'report_emergency.dart'; // Import the ReportEmergencyPage
import 'update_profile_page.dart'; // Import the UpdateProfilePage

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
        title: Text('Admin Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmergencyReportsPage()),
                );
              },
              child: Text('View Emergency Reports'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsersPage()),
                );
              },
              child: Text('View Users'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement delete users functionality
                print('Delete Users');
              },
              child: Text('Delete Users'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Red color for delete action
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UsersPage extends StatelessWidget {
  final List<String> users = ['User1', 'User2', 'User3']; // Sample user data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // TODO: Implement edit user functionality
                    print('Edit ${users[index]}');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // TODO: Implement delete user functionality
                    print('Delete ${users[index]}');
                  },
                ),
              ],
            ),
          );
        },
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
        title: Text('Emergency Reports'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(reports[index]),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement locate available helper functionality
                print('Locate Available Helper');
              },
              child: Text('Locate Available Helper'),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_screeen.dart'; // Import the ProfileScreen
import 'user_manual.dart'; // Import the UserManualPage
import 'logout_page.dart'; // Import the LogoutPage
import 'report_emergency.dart'; // Import the ReportEmergencyPage
import 'update_profile_page.dart'; // Import the UpdateProfilePage

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
  String _medicationsText = '';
  String _allergies = '';
  String _allergiesText = '';
  String _emergencyContact = ''; // Additional information about medications

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
        _allergies = snapshot['allergies'];
        _allergiesText = snapshot['allergiesText'];
        _emergencyContact = snapshot['emergencyContact'];
      });
    }
  }

  Future<void> _sendHelpNotification() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      String fullName = snapshot['fullName'];

      await FirebaseFirestore.instance.collection('notifications').add({
        'fullName': fullName,
        'message': 'Need help from $fullName',
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  Stream<List<Map<String, dynamic>>> _getNotifications() {
    return FirebaseFirestore.instance
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      Timestamp timestamp = doc['timestamp'] as Timestamp;
      DateTime dateTime = timestamp.toDate();
      String formattedDate = '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
      return {
        'fullName': doc['fullName'],
        'message': doc['message'],
        'timestamp': formattedDate,
      };
    }).toList());
  }

  void _showNotificationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder<List<Map<String, dynamic>>>(
          stream: _getNotifications(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return AlertDialog(
                title: Text('Notifications'),
                content: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return AlertDialog(
                title: Text('Notifications'),
                content: Text('No notifications'),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue, // Background color
                      foregroundColor: Colors.white, // Text color
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            }
            return AlertDialog(
              title: Text('Notifications'),
              content: Container(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: snapshot.data!.map((notification) {
                    return ListTile(
                      title: Text(notification['message']),
                      subtitle: Text(notification['timestamp']),
                    );
                  }).toList(),
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue, // Background color
                    foregroundColor: Colors.white, // Text color
                  ),
                  onPressed: () async {
                    // Clear all notifications
                    QuerySnapshot notificationsSnapshot = await FirebaseFirestore.instance
                        .collection('notifications')
                        .get();

                    for (DocumentSnapshot doc in notificationsSnapshot.docs) {
                      await doc.reference.delete();
                    }

                    Navigator.of(context).pop();
                  },
                  child: Text('Clear'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue, // Background color
                    foregroundColor: Colors.white, // Text color
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Set the background color to blue
        title: Center(
          child: Text(
            'Emergify', // Title of the AppBar
            style: TextStyle(color: Colors.white, fontSize: 24), // White color for the title text
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: _showNotificationDialog,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/emergify_logo.png',
                height: 100.0,
              ),
              SizedBox(height: 20),
              Text(
                'Your instant lifeline in critical moments',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 40),
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
                  _sendHelpNotification(); // Send help notification
                  _showEmergencyDialog(context); // Show emergency dialog
                },
                child: Text('Need Help', style: TextStyle(fontSize: 18)),
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
                    MaterialPageRoute(
                      builder: (context) => ReportEmergencyPage(), // Navigate to ReportEmergencyPage
                    ),
                  );
                },
                child: Text('Report Emergency', style: TextStyle(fontSize: 18)),
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
                    MaterialPageRoute(
                      builder: (context) => UpdateProfilePage(
                        fullName: _fullName,
                        email: _email,
                        phoneNumber: _phoneNumber,
                        address: _address,
                        bloodType: _bloodType,
                        medications: _medications,
                        medicationsText: _medicationsText,
                        allergies: _allergies,
                        allergiesText: _allergiesText,
                        emergencyContact: _emergencyContact,
                      ),
                    ),
                  );
                },
                child: Text('Update Profile', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_fullName, style: TextStyle(fontSize: 20.0)),
              accountEmail: Text(_email, style: TextStyle(fontSize: 16.0)),
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
                        'fullName': _fullName,
                        'email': _email,
                        'phoneNumber': _phoneNumber,
                        'address': _address,
                        'bloodType': _bloodType,
                        'medications': _medications,
                        'medicationsText': _medicationsText,
                        'allergies': _allergies,
                        'allergiesText': _allergiesText,
                        'emergencyContact': _emergencyContact,
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
                      builder: (context) =>
                          UserManualPage()), // Navigate to UserManualPage
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
                      builder: (context) =>
                          LogoutPage()), // Navigate to LogoutPage
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEmergencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Set the background color to white
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
                  RadioListTile<String>(
                    activeColor: Colors.blue, // Change the radio button color to blue
                    title: const Text('Medical'),
                    value: 'Medical',
                    groupValue: _selectedNature,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedNature = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    activeColor: Colors.blue, // Change the radio button color to blue
                    title: const Text('Fire'),
                    value: 'Fire',
                    groupValue: _selectedNature,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedNature = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    activeColor: Colors.blue, // Change the radio button color to blue
                    title: const Text('Police'),
                    value: 'Police',
                    groupValue: _selectedNature,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedNature = value!;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue, // Background color
                foregroundColor: Colors.white, // Text color
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Handle emergency submission here
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    ); // Emergency dialog code
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  ));
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'profile_screeen.dart';
import 'user_manual.dart';
import 'logout_page.dart';
import 'report_emergency.dart';
import 'update_profile_page.dart';
import 'authenticate/notification_services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _currentAddress;
  Position? _currentPosition;
  String _fullName = '';
  String _email = '';
  String _phoneNumber = '';
  String _address = '';
  String _bloodType = '';
  String _medications = '';
  String _medicationsText = '';
  String _allergies = '';
  String _allergiesText = '';
  String _emergencyContact = '';

  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    notificationServices.requestNotificationPermission();

    notificationServices.getDeviceToken().then((value) {
      if (value != null) {
        print('device token: $value');
      } else {
        print('Error: Device token is null');
      }
    }).catchError((error) {
      print('Error getting device token: $error');
    });
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
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }


    // Determine the position only if the address is successfully fetched


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            'Emerfigy',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('LAT: ${_currentPosition?.latitude ?? ""}'),
              Text('LNG: ${_currentPosition?.longitude ?? ""}'),
              Text('ADDRESS: ${_currentAddress ?? ""}'),
              Text('ADDRESS: ${_currentAddress ?? ""}'),
              const SizedBox(height: 32),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getCurrentPosition,
                child: const Text("Get Current Location"),
              ),
              SizedBox(height: 20),
              if (_address != null)
                Text(
                  'Current Address: $_address',
                  style: TextStyle(fontSize: 18),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReportEmergencyPage()),
                  );
                },
                child: Text('Report Emergency'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
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
                child: Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blue,
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(_fullName, style: TextStyle(fontSize: 20.0)),
                accountEmail: Text(_email, style: TextStyle(fontSize: 16.0)),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
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
                      'allergies': _allergies,
                      'allergiesText': _allergiesText,
                      'emergencyContact': _emergencyContact,
                    },)),
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
                    MaterialPageRoute(builder: (context) => UserManualPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogoutPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  String currentAddress = 'My Address';
  Position? currentposition;

  Future<void> _determinePosition() async {
    print('Determining position...');

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
      return; // Stop execution if location service is not enabled
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
        return; // Stop execution if location permissions are denied
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
          'Location permissions are permanently denied, we cannot request permissions.');
      return; // Stop execution if location permissions are permanently denied
    }

    Position? position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      print(e);
    }

    if (position != null) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);

        Placemark place = placemarks[0];

        setState(() {
          currentposition = position;
          currentAddress =
          "${place.locality}, ${place.postalCode}, ${place.country}";
        });
      } catch (e) {
        print(e);
      }
    } else {
      // Handle the case where position is null (e.g., user denied permissions)
      Fluttertoast.showToast(msg: 'Failed to get current location');
    }
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
                  // Add radio buttons or other input widgets for selecting nature of emergency
                ],
              );
            },
          ),
          actions: <Widget>[
            Text(currentAddress),
            if (currentposition != null)
              Text('Latitude = ${currentposition!.latitude.toString()}'),
            if (currentposition != null)
              Text('Longitude = ${currentposition!.longitude.toString()}'),
            TextButton(
              onPressed: () {
                _determinePosition();
              },
              child: Text('Locate me'),
            ),
          ],
        );
      },
    );
  }

}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

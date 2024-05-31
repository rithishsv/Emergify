import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateProfilePage extends StatefulWidget {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String address;
  final String bloodType;
  final String medications;
  final String medicationsText;
  final String allergies;
  final String allergiesText;
  final String emergencyContact;

  UpdateProfilePage({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.bloodType,
    required this.medications,
    required this.medicationsText,
    required this.allergies,
    required this.allergiesText,
    required this.emergencyContact,
  });

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _bloodTypeController = TextEditingController();
  TextEditingController _medicationsController = TextEditingController();
  TextEditingController _medicationsTextController = TextEditingController();
  TextEditingController _allergiesController = TextEditingController();
  TextEditingController _allergiesTextController = TextEditingController();
  TextEditingController _emergencyContactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fullNameController.text = widget.fullName;
    _emailController.text = widget.email;
    _phoneNumberController.text = widget.phoneNumber;
    _addressController.text = widget.address;
    _bloodTypeController.text = widget.bloodType;
    _medicationsController.text = widget.medications;
    _medicationsTextController.text = widget.medicationsText;
    _allergiesController.text = widget.allergies;
    _allergiesTextController.text = widget.allergiesText;
    _emergencyContactController.text = widget.emergencyContact;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Update Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField('Full Name', _fullNameController),
              _buildTextField('Email', _emailController),
              _buildTextField('Phone Number', _phoneNumberController),
              _buildTextField('Address', _addressController),
              _buildTextField('Blood Type', _bloodTypeController),
              _buildTextField('Medications', _medicationsController),
              _buildTextField('Medications Text', _medicationsTextController),
              _buildTextField('Allergies', _allergiesController),
              _buildTextField('Allergies Text', _allergiesTextController),
              _buildTextField('Emergency Contact', _emergencyContactController),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  foregroundColor: Colors.white, // Text color
                ),
                onPressed: _updateProfile,
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  void _updateProfile() async {
    // Access the entered values using the TextEditingController's text property
    String fullName = _fullNameController.text;
    String email = _emailController.text;
    String phoneNumber = _phoneNumberController.text;
    String address = _addressController.text;
    String bloodType = _bloodTypeController.text;
    String medications = _medicationsController.text;
    String medicationsText = _medicationsTextController.text;
    String allergies = _allergiesController.text;
    String allergiesText = _allergiesTextController.text;
    String emergencyContact = _emergencyContactController.text;

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({
          'fullName': fullName,
          'email': email,
          'phoneNumber': phoneNumber,
          'address': address,
          'bloodType': bloodType,
          'medications': medications,
          'medicationsText': medicationsText,
          'allergies': allergies,
          'allergiesText': allergiesText,
          'emergencyContact': emergencyContact,
          // Update other fields similarly
        }, SetOptions(merge: true));
        // Show a success message or navigate to another page
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile updated successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the update process
      print('Error updating profile: $e');
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again later.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _bloodTypeController.dispose();
    _medicationsController.dispose();
    _medicationsTextController.dispose();
    _allergiesController.dispose();
    _allergiesTextController.dispose();
    _emergencyContactController.dispose();
    super.dispose();
  }
}

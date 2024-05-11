import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, String> userData;

  ProfileScreen({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          ListTile(
            title: Text('Personal Information', style: TextStyle(fontSize: 20.0)),
          ),
          _buildInfoItem('Full Name', userData['fullName'] ?? ''),
          _buildInfoItem('Email', userData['email'] ?? ''),
          _buildInfoItem('Phone Number', userData['phoneNumber'] ?? ''),
          _buildInfoItem('Address', userData['address'] ?? ''),
          _buildInfoItem('Blood Type', userData['bloodType'] ?? ''),
          Divider(),
          ListTile(
            title: Text('Medical Information', style: TextStyle(fontSize: 20.0)),
          ),
          _buildInfoItem('Medications', userData['medications'] ?? ''),
          _buildInfoItem('Medications Text', userData['medicationsText'] ?? ''),
          _buildInfoItem('Allergies', userData['allergies'] ?? ''),
          _buildInfoItem('Allergies Text', userData['allergiesText'] ?? ''),
          Divider(),
          ListTile(
            title: Text('Emergency Contact', style: TextStyle(fontSize: 20.0)),
          ),
          _buildInfoItem('Contact Name', userData['emergencyContact'] ?? ''),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return ListTile(
      title: Text(label),
      subtitle: Text(value),
    );
  }
}

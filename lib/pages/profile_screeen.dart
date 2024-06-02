import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, String> userData;

  ProfileScreen({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Profile'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          _buildSection(
            'Personal Information',
            [
              _buildInfoItem('Full Name', userData['fullName'] ?? ''),
              _buildInfoItem('Email', userData['email'] ?? ''),
              _buildInfoItem('Phone Number', userData['phoneNumber'] ?? ''),
              _buildInfoItem('Address', userData['address'] ?? ''),
              _buildInfoItem('Blood Type', userData['bloodType'] ?? ''),
            ],
          ),
          Divider(),
          _buildSection(
            'Medical Information',
            [
              _buildInfoItem('Medications', userData['medications'] ?? ''),
              _buildInfoItem('Medications Text', userData['medicationsText'] ?? ''),
              _buildInfoItem('Allergies', userData['allergies'] ?? ''),
              _buildInfoItem('Allergies Text', userData['allergiesText'] ?? ''),
            ],
          ),
          Divider(),
          _buildSection(
            'Emergency Contact',
            [
              _buildInfoItem('Contact Name', userData['emergencyContact'] ?? ''),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade50,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

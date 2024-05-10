// report_emergency.dart
import 'package:flutter/material.dart';
import 'success_screen.dart'; // Import the SuccessScreen

class ReportEmergencyPage extends StatefulWidget {
  @override
  _ReportEmergencyPageState createState() => _ReportEmergencyPageState();
}

class _ReportEmergencyPageState extends State<ReportEmergencyPage> {
  String _selectedNature = 'Medical'; // Default value for nature of emergency

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Emergency'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Nature of Emergency:',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10),
              _buildRadioListTile('Medical Emergency', 'medical'),
              _buildRadioListTile('Fire Emergency', 'fire'),
              _buildRadioListTile('Crime and Safety Emergency', 'crime_and_safety'),
              _buildRadioListTile('Traffic Emergency', 'traffic'),
              SizedBox(height: 20),
              Text(
                'Location:',
                style: TextStyle(fontSize: 18.0),
              ),
              // Replace with your implementation for location selection
              Text('Phone Location'), // Placeholder for phone location
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Number of People Involved'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Information'),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Additional Information'),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleSubmit, // Call _handleSubmit function when button is pressed
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioListTile(String title, String value) {
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

  void _handleSubmit() {
    // Form submission logic
    // For demonstration purposes, let's just print the form data
    print('Nature of Emergency: $_selectedNature');
    // You can add more print statements to print other form fields

    // Navigate to SuccessScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuccessScreen()),
    );
  }
}

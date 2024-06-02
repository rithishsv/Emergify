import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'success_screen.dart'; // Import the SuccessScreen

class ReportEmergencyPage extends StatefulWidget {
  @override
  _ReportEmergencyPageState createState() => _ReportEmergencyPageState();
}

class _ReportEmergencyPageState extends State<ReportEmergencyPage> {
  String _selectedNature = 'Medical'; // Default value for nature of emergency
  TextEditingController _locationController = TextEditingController();
  TextEditingController _peopleInvolvedController = TextEditingController();
  TextEditingController _contactInfoController = TextEditingController();
  TextEditingController _additionalInfoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
              _buildRadioListTile('Medical Emergency', 'Medical'),
              _buildRadioListTile('Fire Emergency', 'Fire'),
              _buildRadioListTile('Crime and Safety Emergency', 'Crime and Safety'),
              _buildRadioListTile('Traffic Emergency', 'Traffic'),

              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
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
              SizedBox(height: 20),
              TextField(
                controller: _peopleInvolvedController,
                decoration: InputDecoration(
                  labelText: 'Number of People Involved',
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
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _contactInfoController,
                decoration: InputDecoration(
                  labelText: 'Contact Information',
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
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _additionalInfoController,
                decoration: InputDecoration(
                  labelText: 'Additional Information',
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
                maxLines: 3,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  foregroundColor: Colors.white, // Text color
                ),
                onPressed: _handleSubmit,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioListTile(String title, String value) {
    return RadioListTile<String>(
      activeColor: Colors.blue, // Change the radio button color to blue
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

  void _handleSubmit() async {
    String location = _locationController.text;
    String peopleInvolved = _peopleInvolvedController.text;
    String contactInfo = _contactInfoController.text;
    String additionalInfo = _additionalInfoController.text;

    try {
      // Save the form data to Firestore
      await FirebaseFirestore.instance.collection('emergencies').add({
        'nature': _selectedNature,
        'location': location,
        'peopleInvolved': peopleInvolved,
        'contactInfo': contactInfo,
        'additionalInfo': additionalInfo,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Navigate to success screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SuccessScreen()),
      );
    } catch (e) {
      // Handle any errors that occur during the submission process
      print('Error submitting emergency report: $e');
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again later.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}

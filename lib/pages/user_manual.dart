import 'package:flutter/material.dart';

class UserManualPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            'User Manual',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Getting Started'),
            _buildStep(
              number: '1.',
              title: 'Creating a Profile:',
              content: [
                'Open the Emergify app on your device.',
                'Click on the "Create Profile" option.',
                'Fill in the required details such as name, contact information, and emergency contact.',
                'Once you\'ve filled in the details, click on the "Submit" button to create your profile.',
              ],
            ),
            _buildStep(
              number: '2.',
              title: 'Updating Profile Details:',
              content: [
                'Navigate to the profile page located at the top left corner of the app.',
                'Click on the "Edit Profile" option.',
                'Update the necessary details.',
                'Click on the "Save" button to confirm the changes.',
              ],
            ),
            _buildSectionTitle('Emergency Actions'),
            _buildStep(
              number: '3.1',
              title: 'Need Help:',
              content: [
                'If you require immediate assistance, you can use the "Need Help" button.',
                'Press the "Need Help" button on the home screen. Emergify will automatically send your location and contact details to the designated emergency services.',
              ],
            ),
            _buildStep(
              number: '3.2',
              title: 'Report Emergency:',
              content: [
                'To report a specific emergency situation, follow these steps:',
                'Click on the "Report Emergency" button on the home screen.',
                'Choose the type of emergency from the available options (Medical emergency, Fire emergency, Crime and Safety emergency, Traffic emergency).',
                'Provide additional details about the situation.',
                'Submit the report.',
              ],
            ),
            _buildStep(
              number: '3.3',
              title: 'Call for Help:',
              content: [
                'In critical situations where immediate assistance is required, you can use the "In-Call for Help" feature.',
                'Press the "Call for Help" button on the home screen.',
                'Select the type of emergency (Medical emergency, Fire emergency, Crime and Safety emergency, Traffic emergency).',
                'Emergify will connect you directly to the respective emergency services for assistance.',
              ],
            ),
            _buildSectionTitle('Support and Feedback'),
            _buildParagraph(
              'For any assistance or feedback regarding Emergify, please contact our support team. We are committed to ensuring your safety and providing the best possible user experience.',
            ),
            SizedBox(height: 20),
            _buildParagraph(
              'Thank you for choosing Emergify for your emergency rescue needs. Stay safe!!',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue[900],
        ),
      ),
    );
  }

  Widget _buildStep({
    required String number,
    required String title,
    required List<String> content,
  }) {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                number,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              SizedBox(width: 5.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content.map((item) => _buildParagraph(item)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0, color: Colors.blue[700]),
      ),
    );
  }
}

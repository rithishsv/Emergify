import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/databaseservice.dart';
 // Import the DatabaseService

class UsersPage extends StatelessWidget {
  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Set the background color to blue
        title: Center(
          child: Text(
            'Users', // Title of the AppBar
            style: TextStyle(color: Colors.white, fontSize: 24), // White color for the title text
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: databaseService.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No users found'));
          } else {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final data = documents[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['fullName']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // TODO: Implement edit user functionality
                          print('Edit ${data['fullName']}');
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // TODO: Implement delete user functionality
                          print('Delete ${data['fullName']}');
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

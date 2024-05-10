// user_manual.dart
import 'package:flutter/material.dart';

class UserManualPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Manual'),
      ),
      body: Center(
        child: Text(
          'This is the User Manual Page!',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}

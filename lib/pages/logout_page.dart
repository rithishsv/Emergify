// logout_page.dart
import 'package:flutter/material.dart';

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
      ),
      body: Center(
        child: Text(
          'Are you sure you want to logout?',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}

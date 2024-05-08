import 'package:emergify/services/auth_service.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget{
  const Homepage({Key? key}) : super(key:  key);
  @override
  State<Homepage> createState() => _HomepageState();

}

class _HomepageState extends State<Homepage>{
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(child: ElevatedButton(child: Text("lOGOUT"), onPressed: (){
        authService.signOut();
      },)),
    );
  }
}
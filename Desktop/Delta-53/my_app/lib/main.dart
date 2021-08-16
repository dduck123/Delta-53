import 'package:flutter/material.dart';
import 'package:my_app/pages/login_page.dart';


void main() {
  runApp(MyApp());
}

//This is the main application widget
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: LoginScreen(),
    );
  }
}


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/drawer_navigation.dart';
import 'package:my_app/login_page.dart';
import 'package:my_app/main.dart';
import 'package:my_app/stats.dart';


class MainPage extends StatelessWidget {
  var homepage = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.purple[100],
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Main page'),
          ),
          drawer: MyDrawer()
      ),
    );
  }
}


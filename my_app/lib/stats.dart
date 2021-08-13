import 'package:flutter/material.dart';
import 'package:my_app/drawer_navigation.dart';

class Stats extends StatelessWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.purple[100],
        ),

        home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.monetization_on_outlined),
                  text: "Payslip",
                ),
                Tab(
                  icon: Icon(Icons.list_alt_outlined),
                  text: "Attendance and Leaves",
                ),
                Tab(
                    icon: Icon(Icons.person),
                  text: "Personal data",
                ),
              ],
            ),
            title: const Text('User Statistics'),
          ),
          drawer: MyDrawer(),
        ),
      ),
    );
  }
}
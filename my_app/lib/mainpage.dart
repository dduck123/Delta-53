import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/login_page.dart';
import 'package:my_app/main.dart';


class TodosScreen extends StatelessWidget {
  // const TodosScreen({Key? key, required this.todos}) : super(key: key);
  //
  // final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.orange
              ),
            child: Text("View"),
            ),
            ListTile(
              leading: Icon(
                  Icons.home,
                  color: Colors.pinkAccent,
                  size: 24.0),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                  Icons.notifications,
                  color: Colors.pinkAccent,
                  size: 24.0),
              title: const Text('Notification'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);

              },
            ),
            ListTile(
              leading: Icon(
                  Icons.email,
                  color: Colors.pinkAccent,
                  size: 22.0),
              title: const Text('Request'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.pinkAccent,
                  size: 22.0),
              title: const Text('Leaves'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                  Icons.assessment_outlined,
                  color: Colors.pinkAccent,
                  size: 24.0),
              title: const Text('Payslip'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                  Icons.announcement_outlined,
                  color: Colors.pinkAccent,
                  size: 24.0),
              title: const Text('Announcement'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                  Icons.logout,
                  color: Colors.pinkAccent,
                  size: 24.0),
              title: const Text('Log Out'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()));
                
              },
            ),
          ],
        ),
      ),
    );
  }
}


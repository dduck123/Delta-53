import 'package:flutter/material.dart';
import 'package:my_app/mainpage.dart';
import 'package:my_app/login_page.dart';
import "package:my_app/stats.dart";

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.orange),
            child: Text("View"),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.pinkAccent, size: 24.0),
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MainPage()));
            },
          ),
          ListTile(
            leading:
                Icon(Icons.notifications, color: Colors.pinkAccent, size: 24.0),
            title: const Text('Notification'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.email, color: Colors.pinkAccent, size: 22.0),
            title: const Text('Request'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today_outlined,
                color: Colors.pinkAccent, size: 22.0),
            title: const Text('Leaves'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.assessment_outlined,
                color: Colors.pinkAccent, size: 24.0),
            title: const Text('Work statistics'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Stats()));
            },
          ),
          ListTile(
            leading: Icon(Icons.announcement_outlined,
                color: Colors.pinkAccent, size: 24.0),
            title: const Text('Announcement'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
              leading: Icon(Icons.help, color: Colors.white, size: 24.0),
              title: const Text('FAQ'),
              onTap: () {
                //TODO add functionality to bring up a faq popup
                Navigator.pop(context);
              }),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.pinkAccent, size: 24.0),
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
    );
  }
}

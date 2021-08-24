import 'package:flutter/material.dart';
import 'package:my_app/pages/calendar_widget.dart';
import 'package:my_app/pages/event_editing_page.dart';
import 'package:provider/provider.dart';
import 'event_provider.dart';

class CalendarMainPage extends StatelessWidget {
  static final String title = "Calendar event";

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => EventProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.indigo[300],
          ),
          home: MainPage(),
        ),
      );
}

class MainPage extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(CalendarMainPage.title),
          centerTitle: true,
        ),
        body: CalendarWidget(),
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.indigo,
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EventEditingPage()))),
      );
}

//To create a meeting inside the app
class Meeting {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;

  const Meeting({
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    this.backgroundColor = Colors.lightGreen,
    this.isAllDay = false,
  });
}

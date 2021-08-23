import 'package:flutter/material.dart';
import 'package:my_app/helper/drawer_navigation.dart';
import 'package:my_app/pages/calendar_widget.dart';
import 'package:my_app/pages/event_editing_page.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:provider/provider.dart';
import 'event_provider.dart';



// class MyHomePage extends StatelessWidget {
//
//   static final String title = 'Calendar Events App';
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: title,
//     themeMode: ThemeMode.dark,
//     darkTheme: ThemeData.dark(),
//     home: CalendarWidget(),
//   );
//
//
// }


// class MainPage extends StatelessWidget{
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       title:Text(MyHomePage.title),
//       centerTitle: true,
//     ),
//     body: CalendarWidget(),
//     floatingActionButton: FloatingActionButton(
//       child: Icon(Icons.add, color: Colors.white),
//       backgroundColor:Colors.red,
//       onPressed:() => Navigator.of(context).push(
//         MaterialPageRoute(builder: (context) => EventEditingPage()),
//       ),
//     ),
//   );
// }

//dont touch
  class MyHomePage extends StatefulWidget {
    @override
    _MyHomePageState createState() => _MyHomePageState();
  }

  //dont touch
  class _MyHomePageState extends State<MyHomePage> {
    @override
    void initState() {
      super.initState();
    }

    //main calendar widget
    @override
    Widget build(BuildContext context) {
      // create: (context) => EventProvider(),
      child:
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => EventProvider()),
        ],
        child: MaterialApp(
            home:
            Scaffold(
              appBar: AppBar(
                title: Text("Main page"),
              ),
              body: CalendarWidget(),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add, color: Colors.white),
                backgroundColor: Colors.red,
                onPressed: () =>
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => EventEditingPage()),
                    ),
              ),
              drawer: MyDrawer(),
            ) //Scaffold
        ),
      );
    }
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




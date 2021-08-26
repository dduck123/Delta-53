import 'package:flutter/material.dart';
import 'package:my_app/helper/drawer_navigation.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Stats extends StatelessWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.indigo[300],
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              unselectedLabelColor: Colors.indigo,
              indicatorColor: Colors.indigo,
              tabs: [
                Tab(
                  icon: Icon(Icons.monetization_on_outlined),
                  text: "Payslips",
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
          body: const TabBarView(
            children: [
              Payslip(),
              Leaves(),
              Text("Personal information"),
            ],
          ),
          drawer: MyDrawer(),
        ),
      ),
    );
  }
}

class Payslip extends StatefulWidget {
  const Payslip({Key? key}) : super(key: key);

  @override
  _PayslipState createState() => _PayslipState();
}

class _PayslipState extends State<Payslip> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
          Container(
              color: Colors.grey[350],
              child: const ListTile(
                title: Text('Payslip',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 50)),
                subtitle: Text(
                  '\$4000',
                  //TODO link this to database to show payslip of the user
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 50),
                ),
              )),
        ]));
  }
}

class Leaves extends StatefulWidget {
  const Leaves({Key? key}) : super(key: key);

  @override
  _LeavesState createState() => _LeavesState();
}

class _LeavesState extends State<Leaves> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                    height: 200.0,
                    width: 200.0,
                    child: CircularPercentIndicator(
                      radius: 60.0,
                      lineWidth: 5.0,
                      percent: 1.0,
                      center: new Text('100'),
                      progressColor: Colors.teal[300],
                    ))),
            SizedBox(
              //change size of CircularProgressIndicator with height and width values oh its parent SizedBox
              height: 200.0,
              width: 200.0,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      color: Colors.red,
                      width: 200,
                      height: 200,
                      child: new CircularProgressIndicator(
                        strokeWidth: 20,
                        value: 0.3,
                        color: Colors.teal[300],
                        backgroundColor: Colors.grey[400],
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Grab leave days from database")),
                ],
              ),
            ),
            SizedBox(
                child: Container(
                    color: Colors.red,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Leaves',
                          style: TextStyle(fontSize: 50),
                          textAlign: TextAlign.right,
                        ))))
          ],
        ),
        // SizedBox(
        //   height: 200.0,
        //   child: Stack(
        //     children: <Widget>[
        //       Align(
        //         alignment: Alignment.centerLeft,
        //         child: Container(
        //           width: 200,
        //           height: 200,
        //           child: Padding(
        //             padding: EdgeInsets.all(12.0),
        //             child: new CircularProgressIndicator(
        //               strokeWidth: 20,
        //               value: 0.3,
        //               color: Colors.teal[300],
        //               backgroundColor: Colors.grey[400],
        //             ),
        //           ),
        //         ),
        //       ),
        //       Center(child: Text("Grab leave days from database")),
        //     ],
        //   ),
        // ),
      ],
    ));
  }
}

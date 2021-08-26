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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Container(
              color: Colors.grey[350],
              child: const ListTile(
                title: Text('Payslip',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 50)),
                subtitle: Text(
                  '\$4000.00',
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
      //set all children within to line up vertically
      mainAxisAlignment: MainAxisAlignment
          .start, //starting point for the first row in this column
      children: <Widget>[
        Container(
          color: Colors.grey[350],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //everything inside this row will line up horizontally
            children: [
              Align(
                  //set alignment of the CircularPercentIndicator to the left side withing this row
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                      //SizedBox to contain the PercentIndicator
                      height: 200.0,
                      width: 200.0,
                      child: CircularPercentIndicator(
                        radius: 120.0,
                        lineWidth: 15.0,
                        percent: 0.8,
                        center: new Text('24/30'),
                        progressColor: Colors.tealAccent[400],
                      ))),
              // SizedBox(
              //   //change size of CircularProgressIndicator with height and width values oh its parent SizedBox
              //   height: 200.0,
              //   width: 200.0,
              //   child: Stack(
              //     children: <Widget>[
              //       Align(
              //         alignment: Alignment.centerLeft,
              //         child: Container(
              //           color: Colors.red,
              //           width: 200,
              //           height: 200,
              //           child: new CircularProgressIndicator(
              //             strokeWidth: 20,
              //             value: 0.3,
              //             color: Colors.teal[300],
              //             backgroundColor: Colors.grey[400],
              //           ),
              //         ),
              //       ),
              //       Align(
              //           alignment: Alignment.centerLeft,
              //           child: Text("Grab leave days from database")),
              //     ],
              //   ),
              // ),
              SizedBox(
                  child: Container(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'LEAVES',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ))))
            ],
          ),
        ),
        SizedBox(
            height: 200.0,
            width: 200.0,
            child: CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 15.0,
              percent: 0.8,
              center: new Text('24/30'),
              progressColor: Colors.tealAccent[400],
            )),
        Card(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: ListTile(
                title: Text(
                  'Payslip',
                  style: TextStyle(fontSize: 50),
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  '\$4000',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 50),
                ),
              ),
              color: Colors.grey[350],
            ),
          ],
        )),
      ],
    ));
  }
}

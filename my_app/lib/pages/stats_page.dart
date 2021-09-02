import 'package:flutter/material.dart';
import 'package:my_app/helper/drawer_navigation.dart';
import 'package:my_app/helper/employee.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
            title: const Text('Profile'),
          ),
          body: const TabBarView(
            children: [
              Payslip(),
              Leaves(),
              Employee(),
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
  final currentUserID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    CollectionReference employees =
        FirebaseFirestore.instance.collection('Employees');
    return Container(
        child: Column(
      //set all children within to line up vertically
      mainAxisAlignment: MainAxisAlignment
          .spaceEvenly, //starting point for the first row in this column
      children: [
        Center(
            child: FutureBuilder<DocumentSnapshot>(
                future: employees.doc(currentUserID).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    Container(
                      color: Colors.grey[350],
                      height: 200,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularPercentIndicator(
                            radius: 120.0,
                            lineWidth: 15.0,
                            percent: 0.8,
                            center: new Text('24/30',
                                style: TextStyle(fontSize: 17)),
                            //TODO link this up to database somehow
                            progressColor: Colors.tealAccent[400],
                            backgroundColor: Colors.grey[500],
                          ),
                          Padding(
                            //the spacing between Text and Percent indicator
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                          ),
                          Text('LEAVES',
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    );
                    Divider(
                      thickness: 3,
                      indent: 20,
                      endIndent: 20,
                    );
                    //new row Attendance related widgets
                    Container(
                      color: Colors.grey[350],
                      height: 200,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('ATTENDANCE',
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold)),
                          Padding(
                            //the spacing between Text and Percent indicator
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                          ),
                          CircularPercentIndicator(
                            radius: 120.0,
                            lineWidth: 15.0,
                            percent: 0.88,
                            center:
                                new Text('88%', style: TextStyle(fontSize: 17)),
                            progressColor: Colors.red[200],
                            backgroundColor: Colors.grey[500],
                          ),
                        ],
                      ),
                    );
                    Divider(
                      thickness: 3,
                      indent: 20,
                      endIndent: 20,
                    );
                    //Payslip row
                    Container(
                        height: 200,
                        color: Colors.grey[350],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListTile(
                              title: Text(
                                'Payslip',
                                style: TextStyle(fontSize: 50),
                                textAlign: TextAlign.center,
                              ),
                              subtitle: Text(
                                "${data['name']}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 50),
                              ),
                            ),
                          ],
                        ));
                  }
                  return Text('loading');
                })),
      ],
    ));
  }
}

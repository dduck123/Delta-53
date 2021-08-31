import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Employee extends StatefulWidget {
  const Employee({Key? key}) : super(key: key);

  @override
  _EmployeeState createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  final currentUserID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    CollectionReference employees =
        FirebaseFirestore.instance.collection('Employees');
    return Scaffold(
        body: Column(children: <Widget>[
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.indigoAccent,
                Colors.indigo,
                Colors.white
              ])),
          child: Container(
            width: double.infinity,
            height: 350.0,
            child: Center(
              child: FutureBuilder<DocumentSnapshot>(
                  future: employees.doc(currentUserID).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://actnowtraining.files.wordpress.com/2012/02/cat.jpg",
                            ),
                            radius: 50.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "${data['name']} ${data['surname']}",
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 4.0),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.white,
                            shadowColor: Colors.black,
                            elevation: 8.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 22.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Position",
                                          style: TextStyle(
                                            color: Colors.indigo,
                                            fontSize: 24.0,

                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "${data['position']}",
                                          style: TextStyle(
                                            fontSize: 28.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    }
                    return Text("loading...");
                  }),
            ),
          )),
      Center(
          child: FutureBuilder<DocumentSnapshot>(
        future: employees.doc(currentUserID).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "User ID: " + currentUserID,
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 10),
              ],
            );
          }

          return Text("loading...");
        },
      ))
    ]));
  }
}

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
        body: Center(
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
                  Text("Full Name: ${data['name']} ${data['surname']}",
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 24,
                    ),)
                ],
              );
            }

            return Text("loading...");
          },
        )));
  }
}

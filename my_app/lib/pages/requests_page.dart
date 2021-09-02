import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/helper/drawer_navigation.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final textControllerTitle = TextEditingController();
  final textControllerMessage = TextEditingController();
  var textTitle = TextEditingController();
  var textMessage = TextEditingController();

  CollectionReference requests =
      FirebaseFirestore.instance.collection('events');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.indigo[300],
      ),
      home: Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          title: Text("Requests"),
        ),
        body: StreamBuilder(
            stream: requests.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView(
                children: snapshot.data!.docs.map((requests) {
                  return Card(
                    elevation: 10.0,
                    child: Container(
                      child: ListTile(
                        title: Transform.translate(
                          offset: Offset(0, 2),
                          child: Text(
                            requests['title'],
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        subtitle: Transform.translate(
                          offset: Offset(0, 4),
                          child: Text(
                            requests['description'],
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        trailing: Wrap(
                          spacing: 6,
                          children: <Widget>[
                            PopupMenuButton(itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  value: "Edit",
                                  child: Text("Edit"),
                                ),
                                PopupMenuItem(
                                  value: "Delete",
                                  child: Text("Delete"),
                                )
                              ];
                            }, onSelected: (String value) {
                              if (value == "Edit") {
                                textTitle.text = requests["title"];
                                textMessage.text = requests["description"];
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        elevation: 20,
                                        child: Container(
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: <Widget>[
                                              SizedBox(height: 20),
                                              Center(
                                                  child:
                                                      Text('Update Request')),
                                              SizedBox(height: 20),
                                              TextField(
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.all(16.0),
                                                  labelText: 'Title',
                                                ),
                                                controller: textTitle,
                                              ),
                                              TextField(
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.all(16.0),
                                                  labelText: 'Description',
                                                ),
                                                controller: textMessage,
                                              ),
                                              RaisedButton(
                                                child: Text("Update"),
                                                onPressed: () {
                                                  requests.reference.update({
                                                    'title': textTitle.text,
                                                    'description':
                                                        textMessage.text,
                                                  });

                                                  Navigator.pop(
                                                      context, requests);
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                              if (value == "Delete") {
                                requests.reference.delete();
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  elevation: 16,
                  child: Container(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Center(child: Text('New Request')),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16.0),
                            labelText: 'Title',
                          ),
                          controller: textControllerTitle,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16.0),
                            labelText: 'Description',
                          ),
                          controller: textControllerMessage,
                        ),
                        RaisedButton(
                          child: Text("Add Request"),
                          onPressed: () {
                            requests.add({
                              'title': textControllerTitle.text,
                              'description': textControllerMessage.text,
                            });
                            textControllerTitle.clear();
                            textControllerMessage.clear();
                            Navigator.pop(context, requests);
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        drawer: MyDrawer(),
      ),
    );
  }
}




              // return ListView(
              //   scrollDirection: Axis.vertical,
              //   padding: EdgeInsets.zero,
              //   children: snapshot.data!.docs.map((events) {
              //     return Card(
              //       child: Container(
              //         child: Text("Title: " + events['title']),
              //       ),
              //     );
              //   }).toList(),
              // );
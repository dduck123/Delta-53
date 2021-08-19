import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/helper/drawer_navigation.dart';
import 'dart:math';

class Announce extends StatefulWidget {
  const Announce({Key? key}) : super(key: key);

  @override
  _AnnounceState createState() => _AnnounceState();
}

class _AnnounceState extends State<Announce> {
  final textControllerTitle = TextEditingController();
  final textControllerMessage = TextEditingController();
  var textTitle = TextEditingController();
  var textMessage = TextEditingController();
  final _random = Random();

  CollectionReference announcements =
      FirebaseFirestore.instance.collection('Announcements');

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Announcement"),
        ),
        body: StreamBuilder(
          stream: announcements.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text("Loading..."));
            }
            return ListView(
              padding: const EdgeInsets.all(20),
              children: snapshot.data!.docs.map((announce) {
                return Card(
                  elevation: 10.0,
                  shadowColor: Colors.purpleAccent,
                  margin: EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Container(

                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      tileColor: Colors.primaries[_random.nextInt(Colors.primaries.length)]
                [_random.nextInt(4) * 100],
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      title: Text(announce['title']),
                      subtitle: Text(announce['message']),
                      trailing: PopupMenuButton(itemBuilder: (context) {
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
                          textTitle.text = announce["title"];
                          textMessage.text = announce["message"];
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)),
                                  elevation: 16,
                                  child: Container(
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        SizedBox(height: 20),
                                        Center(
                                            child: Text('Update announcement')),
                                        SizedBox(height: 20),
                                        TextField(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.only(top: 14.0),
                                            labelText: 'Title',
                                          ),
                                          controller: textTitle,
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.only(top: 14.0),
                                            labelText: 'Message',
                                          ),
                                          controller: textMessage,
                                        ),
                                        RaisedButton(
                                          child: Text("Update"),
                                          onPressed: () {
                                            announce.reference.update({
                                              'title': textTitle.text,
                                              'message': textMessage.text,
                                            });

                                            Navigator.pop(
                                                context, announcements);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                        if (value == "Delete") {
                          announce.reference.delete();
                        }
                      }),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  elevation: 16,
                  child: Container(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Center(child: Text('Add new announcement')),
                        SizedBox(height: 20),
                        TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0),
                            labelText: 'Title',
                          ),
                          controller: textControllerTitle,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0),
                            labelText: 'Message',
                          ),
                          controller: textControllerMessage,
                        ),
                        RaisedButton(
                          child: Text("Add"),
                          onPressed: () {
                            announcements.add({
                              'title': textControllerTitle.text,
                              'message': textControllerMessage.text,
                            });
                            textControllerTitle.clear();
                            textControllerMessage.clear();
                            Navigator.pop(context, announcements);
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

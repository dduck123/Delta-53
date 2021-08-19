import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Announce extends StatefulWidget {
  const Announce({Key? key}) : super(key: key);

  @override
  _AnnounceState createState() => _AnnounceState();
}

class _AnnounceState extends State<Announce> {
  final textControllerTitle = TextEditingController();
  final textControllerMessage = TextEditingController();
  CollectionReference announcements =
  FirebaseFirestore.instance.collection('Announcements');

  @override

  Widget build(BuildContext context) {

    var size = MediaQuery
        .of(context)
        .size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

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
            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeight),
              children: snapshot.data!.docs.map((announce) {
                return Center(
                  child: ListTile(
                    title: Text(announce['title']),
                    subtitle: Text(announce['message']),
                    trailing: PopupMenuButton(
                      itemBuilder: (context){
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
                      },
                      onSelected: (String value){
                        if (value == "Delete"){
                          announce.reference.delete();
                        }
                      }
                    ),


                  ),
                );
              }).toList(),
            );
            // return ListView(
            //   children: snapshot.data!.docs.map((announce) {
            //     return Center(
            //       child: ListTile(
            //         title: Text(announce['title']),
            //         subtitle: Text(announce['message']),
            //         trailing: Icon(Icons.more_vert),
            //         onLongPress: () {
            //           announce.reference.delete();
            //         },
            //       ),
            //     );
            //   }).toList(),
            // );
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
      ),
    );
  }
}



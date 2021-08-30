import 'package:my_app/pages/leave_editing_page.dart';
import 'package:my_app/pages/leave_provider.dart';
import 'package:my_app/pages/leave_main_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class LeaveViewingPage extends StatelessWidget {
  final Leave event;

  const LeaveViewingPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
          actions: buildViewingActions(context, event),
        ),
        body: ListView(
          padding: EdgeInsets.all(32),
          children: <Widget>[
            buildDateTime(event),
            SizedBox(height: 32),
            Text(
              event.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 24),
            Text(
              event.description,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      );

  Widget buildDateTime(Leave event) {
    return Column(
      children: [
        buildDate(event.isAllDay ? 'All-day' : 'From: ', event.from),
        if(!event.isAllDay) buildDate('To: ', event.to),
      ],
    );
  }
  Widget buildDate(String title, DateTime date) => Row(
    children: [
      Text(title),
      Text(Utils.toDate(date) + " " + Utils.toTime(date),)
    ],

  );




  List<Widget> buildViewingActions(BuildContext context, Leave event) =>[
    IconButton(
      icon: Icon(Icons.edit),
      onPressed: () =>
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LeaveEditingPage(leave: event),

            ),
          ),
    ),
    IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          final provider = Provider.of<LeaveProvider>(context, listen: false);
          provider.deleteLeave(event);
          Navigator.of(context).pop();
        }
    ),
  ];
}
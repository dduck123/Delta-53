import 'package:grouped_list/grouped_list.dart';
import 'package:flutter/material.dart';
import 'package:my_app/drawer_navigation.dart';

List _elements = [
  {
    'qns': 'Who else can access my data',
    'ans':
        'Only you and the HR team can access your data. Do not give out your password to anyone else. ',
    'cat': 'How to use'
  },
  {
    'qns': 'What if i need to change my personal details',
    'ans':
        'Your name and date of birth are key items of data which can only be amended with relevant supporting documentation. Should you need to change these details, please refer to the HR department for further assistance.',
    'cat': 'How to use'
  },
  {
    'qns': 'What do I do if I think my absence record is incorrect',
    'ans':
        'Please contact your manager or department admin for assitance in amending the correct changes to your record.',
    'cat': 'How to use'
  },
  {
    'qns': 'Where to report a person...',
    'ans': 'Contact 911',
    'cat': 'Contact support'
  },
  {'qns': 'Daniel Miller is who?', 'ans': 'THE GOAT', 'cat': 'How to use'},
  {
    'qns': 'About Delta',
    'ans':
        'Delta is an app aimed to assist teams and make project management easier as the changes to work life becomes more home-based.',
    'cat': 'About'
  },
];

class Faq extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.indigo[300],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Grouped List View Example'),
        ),
        body: GroupedListView<dynamic, String>(
          elements: _elements,
          groupBy: (element) => element['cat'],
          groupComparator: (value1, value2) => value2.compareTo(value1),
          itemComparator: (item1, item2) =>
              item1['qns'].compareTo(item2['qns']),
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: true,
          groupSeparatorBuilder: (String value) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          itemBuilder: (c, element) {
            return Card(
              elevation: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                child: ListTile(
                  tileColor: Colors.blue[100],
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Icon(Icons.account_circle),
                  title: Text(element['qns']),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(element['qns'], element['ans']),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
        drawer: MyDrawer(),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String qns;
  final String ans;
  DetailScreen(this.qns, this.ans);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(qns),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(ans),
      ),
    );
  }
}

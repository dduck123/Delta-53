import 'package:flutter/cupertino.dart';
import 'package:my_app/pages/main_page.dart';
import 'package:provider/provider.dart';

class EventProvider extends ChangeNotifier{
  final List<Meeting> _events = [];

  List<Meeting> get events => _events;

  void addEvent(Meeting event){
    _events.add(event);

    notifyListeners();
  }
}
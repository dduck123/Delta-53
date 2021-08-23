import 'package:flutter/material.dart';
import 'package:my_app/pages/main_page.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:my_app/pages/event_provider.dart';



class CalendarWidget extends StatelessWidget{
  @override

  Widget build(BuildContext context){

    final events = Provider.of<EventProvider>(context).events;

    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
    );
  }
}

class EventDataSource extends CalendarDataSource{
  EventDataSource(List<Meeting> appointments) {
    this.appointments = appointments;
  }
  Meeting getEvent(int index) => appointments![index] as Meeting;

  @override
  DateTime getStartTime(int index) => getEvent(index).from;

  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getSubject(int index) => getEvent(index).title;

  @override
  Color getColor(int index) => getEvent(index).backgroundColor;

  @override
  bool isAllDay(int index) => getEvent(index).isAllDay;
}
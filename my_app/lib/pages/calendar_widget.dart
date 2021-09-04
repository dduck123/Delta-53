import 'package:flutter/material.dart';
import 'package:my_app/pages/main_page.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:my_app/pages/event_provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:my_app/pages/event_viewing_page.dart';



class CalendarWidget extends StatelessWidget{
  @override

  Widget build(BuildContext context){

    final events = Provider.of<EventProvider>(context).events;

    return SfCalendar(
      view: CalendarView.day,
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      onLongPress: (details) {
        final provider = Provider.of<EventProvider>(context, listen: false);
        provider.setDate(details.date!);

        showModalBottomSheet(
            context: context,
            builder: (context) => TasksWidget(),
        );
      }
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

//Task Widget

class TasksWidget extends StatefulWidget{
  @override
  _TasksWidgetState createState() => _TasksWidgetState();

}

class _TasksWidgetState extends State<TasksWidget>{
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;

    if (selectedEvents.isEmpty) {
      return Center(
        child: Text(
          'No events found',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      );
    }
    return SfCalendarTheme(
      data: SfCalendarThemeData(
        timeTextStyle: TextStyle(fontSize: 16, color: Colors.blue),
      ),
      child: SfCalendar(
        view: CalendarView.timelineDay,
        dataSource: EventDataSource(provider.events),
        initialDisplayDate: provider.selectedDate,
        appointmentBuilder: appointmentBuilder,
        headerHeight: 0,
        onTap: (details) {
          if (details.appointments == null) return;
          final event = details.appointments!.first;

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EventViewingPage(event: event),
          ));
        },
        todayHighlightColor: Colors.black,
        selectionDecoration: BoxDecoration(
          color: Colors.red.withOpacity(0.3),
        ),
      ),
    );
  }

  Widget appointmentBuilder(
      BuildContext context,
      CalendarAppointmentDetails details
      )
  {
    final event = details.appointments.first;

    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        color: event.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
      child: Text(
        event.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight:  FontWeight.bold,
        ),
      ),
    ));
  }


}
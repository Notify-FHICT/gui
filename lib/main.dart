import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Container(
          child: const MyList(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyList extends StatefulWidget {
  const MyList({super.key, required this.title});
  final String title;
  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  String _text = '';
  void _selectionChanged(CalendarSelectionDetails details) {
    _text = '';
    List<Meeting> events = _getDataSource();
    final DateTime today = DateTime.now();
    for (var Meeting in events) {
      // print(Meeting.from.day.toString() + " " + details.date!.day.toString());
      if (Meeting.from.day == details.date!.day) {
        _text += '\n';
        _text += Meeting.eventName.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double aspectRatio = constraints.maxWidth / constraints.maxHeight;
        List<Widget> widgets = [
          Expanded(
            child: Container(
              height: constraints.maxWidth / 2,
              width: constraints.maxHeight / 2,
              color: Colors.blue,
              child: Center(
                child: MyInfoBox(title: 'Flutter Demo Home Page'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: constraints.maxWidth / 2,
              width: constraints.maxHeight / 2,
              color: Colors.green,
              child: Center(
                child: MyCalendar(
                    selectionChanged: _selectionChanged,
                    title: 'Flutter Demo Home Page'),
              ),
            ),
          ),
        ];

        if (aspectRatio > 1.0) {
          // Landscape
          return Row(children: widgets);
        } else {
          // Portrait
          return Column(children: widgets);
        }
      },
    );
  }
}

class MyInfoBox extends StatefulWidget {
  const MyInfoBox({super.key, required this.title});
  final String title;
  @override
  State<MyInfoBox> createState() => _MyInfoBoxState();
}

class _MyInfoBoxState extends State<MyInfoBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: const Text(
          textAlign: TextAlign.center,
          'List, contains all items from selected day'),
    );
  }
}

class MyCalendar extends StatelessWidget {
  const MyCalendar(
      {required this.selectionChanged, super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  // final CalendarTapCallback selectionChanged;
  // final CalendarSelectionDetails selectionChanged;
  final CalendarSelectionChangedCallback? SelectionChanged;

//   @override
//   State<MyCalendar> createState() => _MyCalendarState();
// }

// class _MyCalendarState extends State<MyCalendar> {
//   final CalendarController _controller = CalendarController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.day,
        dataSource: MeetingDataSource(_getDataSource()),
        allowedViews: const [
          CalendarView.day,
          CalendarView.week,
          CalendarView.month,
        ],
        // controller: _controller,
        onSelectionChanged: (CalendarSelectionDetails details) {
          DateTime date = details.date!;
          CalendarResource resource = details.resource!;
        },
      ),
    );
  }
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
  DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(Meeting(
      'Conference', startTime, endTime, const Color(0xFF0F8644), false));

  startTime = DateTime(today.year, today.month, today.day, 11, 0, 0);
  endTime = startTime.add(const Duration(hours: 2));
  meetings.add(Meeting('Conference 2', startTime, endTime,
      Color.fromARGB(255, 150, 36, 15), false));

  startTime = DateTime(today.year, today.month, today.day + 1, 11, 30, 0);
  endTime = startTime.add(const Duration(hours: 2));
  meetings.add(Meeting('rainbow 6', startTime, endTime,
      Color.fromARGB(255, 31, 29, 146), false));

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

import 'package:syncfusion_flutter_calendar/calendar.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('size= ${MediaQuery.of(context).size.height}'),
        ),
        body: ListView(
          children: <Widget>[
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                child: const MyInfoBox(title: 'Flutter Demo Home Page'),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: const MyCalendar(title: 'Flutter Demo Home Page'),
            ),
          ],
        ),
      ),
      //home: const MyCalendar(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyInfoBox extends StatefulWidget {
  const MyInfoBox({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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

class MyCalendar extends StatefulWidget {
  const MyCalendar({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(),
    );
  }
}

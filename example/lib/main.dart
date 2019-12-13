import 'package:example/scheduling_calendar_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '自定义排班日历 Demo',
      theme: ThemeData.light(),
      home: SchedulingCalendarPage(),
    );
  }
}

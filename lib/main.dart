import 'package:flutter/material.dart';
import 'package:my_tasks_app/screens/main_screen.dart';
import 'package:my_tasks_app/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Tasks App',
      theme: theme,
      home: MainScreen(),
      routes: {
        MainScreen.routeName: (ctx) => MainScreen(),
      },
      // routes: '',
    );
  }
}


import 'package:flutter/material.dart';
import 'package:my_tasks_app/helpers/custom_scroll_behavior.dart';
import 'package:my_tasks_app/providers/list_provider.dart';
import 'package:my_tasks_app/screens/add_task_screen.dart';
import 'package:my_tasks_app/screens/main_screen.dart';
import 'package:my_tasks_app/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ListProvider()),
      ],
      child: MaterialApp(
        title: 'My Tasks App',
        theme: theme,
        builder: (ctx, child) {
          return ScrollConfiguration(
              behavior: CustomScrollBehavior(), child: child!);
        },
        home: MainScreen(),
        routes: {
          MainScreen.routeName: (ctx) => MainScreen(),
          AddTaskScreen.routeName: (ctx) => AddTaskScreen(),
        },
      ),
    );
  }
}

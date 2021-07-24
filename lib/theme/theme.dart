import 'package:flutter/material.dart';
import 'package:my_tasks_app/helpers/custom_route_transition.dart';

final ThemeData theme = ThemeData(
  primarySwatch: Colors.blue,
  primaryTextTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black87,
        fontSize: 22,
      ),
      headline4: TextStyle(
        color: Colors.black54,
        fontSize: 14,
      ),
      headline3: TextStyle(
        color: Colors.black87,
        fontSize: 16,
      ),
    overline: TextStyle(
      decoration: TextDecoration.lineThrough,
      color: Colors.black26,
    )
  ),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: CustomTransitionBuilder(),
    TargetPlatform.iOS: CustomTransitionBuilder(),
  }),
);
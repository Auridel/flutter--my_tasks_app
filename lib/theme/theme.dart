import 'package:flutter/material.dart';

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
);
import 'package:flutter/material.dart';

void showError(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      'Произошла ошибка. Пожалуйста повторите позднее',
      textAlign: TextAlign.center,
    ),
  ));
}
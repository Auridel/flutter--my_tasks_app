import 'package:flutter/material.dart';
import 'package:my_tasks_app/widgets/custom_header.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomHeader(
              isBackButton: false,
              title: 'Задачи',
              rightButton: IconButton(
                icon: Icon(Icons.category_outlined),
                onPressed: () {
                  print('Category pressed');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

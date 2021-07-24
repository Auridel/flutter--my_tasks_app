import 'package:flutter/material.dart';
import 'package:my_tasks_app/widgets/categories.dart';
import 'package:my_tasks_app/widgets/custom_header.dart';

class AddTaskScreen extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  static const routeName = '/add-task';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomHeader(
              isBackButton: true,
              rightButton: IconButton(
                icon: Icon(
                  Icons.check,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  final isValid = _form.currentState?.validate();
                  if (isValid == null || !isValid) {
                    return;
                  }
                },
              ),
            ),
            Form(
                key: _form,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    decoration: InputDecoration(
                      // contentPadding: const EdgeInsets.symmetric(vertical: 6),
                      hintText: 'Название задачи',
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    style: TextStyle(
                      color:
                          Theme.of(context).primaryTextTheme.headline4?.color,
                      fontSize: Theme.of(context)
                          .primaryTextTheme
                          .headline6
                          ?.fontSize,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ввените название задачи';
                      }
                      return null;
                    },
                  ),
                )),
            SizedBox(height: 20,),
            Categories(null),
          ],
        ),
      ),
    );
  }
}

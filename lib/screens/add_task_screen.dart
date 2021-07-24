import 'package:flutter/material.dart';
import 'package:my_tasks_app/providers/list_provider.dart';
import 'package:my_tasks_app/widgets/categories.dart';
import 'package:my_tasks_app/widgets/custom_header.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  static const routeName = '/add-task';

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _form = GlobalKey<FormState>();
  var isFetching = false;
  int? selectedCategory;
  String title = '';

  void _setSelectedCategory(int id) {
    selectedCategory = id;
  }

  void _addTask() {
    final isValid = _form.currentState?.validate();
    if (isValid != null && isValid && selectedCategory != null) {
      Provider.of<ListProvider>(context, listen: false)
          .addTodo(selectedCategory!, title)
          .then((_) {
        Navigator.of(context).pop();
      }).catchError((_) {
        setState(() {
          isFetching = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Произошла ошибка. Пожалуйста повторите позднее',
            textAlign: TextAlign.center,
          ),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomHeader(
              isBackButton: true,
              rightButton: !isFetching
                  ? IconButton(
                      icon: Icon(
                        Icons.check,
                        color: theme.primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          isFetching = true;
                        });
                        _addTask();
                      },
                    )
                  : SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      )),
            ),
            Form(
                key: _form,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Название задачи',
                      hintStyle: TextStyle(
                        color: theme.primaryTextTheme.headline4?.color,
                      ),
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: theme.primaryTextTheme.headline4?.color,
                      fontSize: theme.primaryTextTheme.headline6?.fontSize,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ввените название задачи';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      title = value;
                    },
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Categories(
              setSelectedCategory: _setSelectedCategory,
            ),
          ],
        ),
      ),
    );
  }
}

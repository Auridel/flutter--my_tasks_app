import 'package:flutter/material.dart';
import 'package:my_tasks_app/helpers/error_snackbar.dart';
import 'package:my_tasks_app/models/todos.dart';
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
  Todos? routeArgs;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      routeArgs = ModalRoute.of(context)?.settings.arguments as Todos?;
      if (routeArgs != null) {
        setState(() {
          title = routeArgs!.text;
          selectedCategory = routeArgs!.listId;
        });
      }
      print('${routeArgs?.text}');
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _setSelectedCategory(int id) {
    selectedCategory = id;
  }

  bool _validateFields() {
    final isValid = _form.currentState?.validate();
    return isValid != null && isValid && selectedCategory != null;
  }

  void _editTask() {
    if (_validateFields() && routeArgs != null && selectedCategory != null) {
      setState(() {
        isFetching = true;
      });
      Provider.of<ListProvider>(context, listen: false)
          .editTask(routeArgs!, selectedCategory!, title)
          .then((_) {
        Navigator.of(context).pop();
      }).catchError((_) {
        setState(() {
          isFetching = false;
          showError(context);
        });
      });
    }
  }

  void _addTask() {
    if (_validateFields()) {
      setState(() {
        isFetching = true;
      });
      Provider.of<ListProvider>(context, listen: false)
          .addTodo(selectedCategory!, title)
          .then((_) {
        Navigator.of(context).pop();
      }).catchError((_) {
        setState(() {
          isFetching = false;
        });
        showError(context);
      });
    }
  }

  void _onSubmitHandler() {
    if (routeArgs != null) {
      _editTask();
      return;
    }
    _addTask();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            leading: Container(),
            pinned: true,
            floating: false,
            expandedHeight: 101,
            backgroundColor: theme.backgroundColor,
            flexibleSpace: CustomHeader(
              isBackButton: true,
              rightButton: !isFetching
                  ? IconButton(
                      icon: Icon(
                        Icons.check,
                        color: theme.primaryColor,
                      ),
                      onPressed: () {
                        _onSubmitHandler();
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 15, bottom: 15),
                      child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          )),
                    ),
            ),
          ),
          SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Form(
                    key: _form,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        initialValue: routeArgs?.text ?? '',
                        decoration: InputDecoration(
                          hintText: 'Название задачи',
                          hintStyle: TextStyle(
                            color: theme.primaryTextTheme.headline4?.color,
                            fontSize:
                                theme.primaryTextTheme.headline5?.fontSize,
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
                            return 'Введите название задачи';
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
                  selectedId: selectedCategory,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

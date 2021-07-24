import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tasks_app/models/list_model.dart';
import 'package:my_tasks_app/providers/list_provider.dart';
import 'package:my_tasks_app/screens/add_task_screen.dart';
import 'package:my_tasks_app/widgets/custom_header.dart';
import 'package:my_tasks_app/widgets/task_list.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddTaskScreen.routeName);
        },
      ),
      body: FutureBuilder(
        future: Provider.of<ListProvider>(context, listen: false)
            .fetchAndSetLists(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.error != null) {
            return Center(
              child: Text('Something went wrong'),
            );
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  ),
                  Consumer<ListProvider>(
                    builder: (ctx, listData, child) => ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, i) => TaskList(listData.items[i]),
                      itemCount: listData.items.length,
                      shrinkWrap: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

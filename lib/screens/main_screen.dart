import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tasks_app/providers/list_provider.dart';
import 'package:my_tasks_app/screens/add_task_screen.dart';
import 'package:my_tasks_app/widgets/bottom_modal.dart';
import 'package:my_tasks_app/widgets/custom_header.dart';
import 'package:my_tasks_app/widgets/task_list.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var isListsNotEmpty = false;

  @override
  void initState() {
    isListsNotEmpty =
        Provider.of<ListProvider>(context, listen: false).items.length > 0;
    super.initState();
  }

  void _setListsIsEmpty(bool isListsHasItems) {
    if (isListsNotEmpty != isListsHasItems) {
      setState(() {
        isListsNotEmpty = isListsHasItems;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      floatingActionButton: isListsNotEmpty
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddTaskScreen.routeName);
              },
            )
          : null,
      body: FutureBuilder(
        future: isListsNotEmpty
            ? Future.delayed(Duration.zero)
            : Provider.of<ListProvider>(context, listen: false)
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
            return CustomScrollView(
                physics: ClampingScrollPhysics(),
                clipBehavior: Clip.hardEdge,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    floating: false,
                    expandedHeight: 101,
                    backgroundColor: theme.backgroundColor,
                    flexibleSpace: CustomHeader(
                      isBackButton: false,
                      title: 'Задачи',
                      rightButton: IconButton(
                        icon: Icon(Icons.category_outlined),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (ctx) {
                                return BottomModal();
                              });
                        },
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    child:
                        Consumer<ListProvider>(builder: (ctx, listData, child) {
                      final lists = listData.items;
                      final isListsHasItems = lists.length > 0;
                      Future.delayed(Duration.zero, () async {
                        _setListsIsEmpty(isListsHasItems);
                      });
                      return lists.length == 0
                          ? Center(
                              child: Image.asset(
                                'assets/images/empty.jpg',
                                fit: BoxFit.contain,
                              ),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (ctx, i) => TaskList(lists[i]),
                              itemCount: lists.length,
                              shrinkWrap: true,
                            );
                    }),
                  ),
                ]);
          }
        },
      ),
    );
  }
}

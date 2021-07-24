import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tasks_app/helpers/error_snackbar.dart';
import 'package:my_tasks_app/providers/list_provider.dart';
import 'package:provider/provider.dart';

class BottomModal extends StatefulWidget {

  @override
  _BottomModalState createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomModal> {
  int? fetchingId;

  void _showError() {
    showError(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: Color(0xff737373),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(10),
              topRight: const Radius.circular(10)),
        ),
        child: SingleChildScrollView(
          child: Consumer<ListProvider>(
            builder: (_, listData, child) => Column(
              children: [
                ListView.builder(
                  physics:
                  const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (_, i) {
                    final list = listData.items[i];
                    return GestureDetector(
                      onTap: () {
                        final listId = list.id;
                        setState(() {
                          fetchingId = listId;
                        });
                        listData.deleteList(listId).then((_) {
                          setState(() {
                            Navigator.of(context).pop();
                          });
                        })
                            .catchError((_) {
                          setState(() {
                            fetchingId = null;
                          });
                          _showError();
                        });
                      },
                      child: ListTile(
                        title:
                        Text(list.title),
                        trailing: fetchingId == list.id ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: theme.errorColor,),
                        ) : Icon(
                          CupertinoIcons.trash,
                          color: theme.errorColor,
                          size: 20,
                        ),
                      ),
                    );
                  },
                  itemCount: listData.items.length,
                ),
                GestureDetector(
                  onTap: () {
                    print('add pressed');
                  },
                  child: ListTile(
                    title: Text(
                      'Новая категория',
                      style: TextStyle(
                          color: theme.primaryTextTheme
                              .headline4?.color),
                    ),
                    trailing: Icon(Icons.add,
                        color: theme.primaryTextTheme
                            .headline4?.color),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
  final _form = GlobalKey<FormState>();
  final _input = GlobalKey<FormFieldState>();
  var isFetching = false;
  var isInputVisible = false;
  int? fetchingId;

  void _showError() {
    showError(context);
  }

  void _addList() {
    final isValid = _form.currentState?.validate();
    final title = _input.currentState?.value.toString();
    if (isValid != null && isValid && title != null && title.isNotEmpty) {
      setState(() {
        isFetching = true;
      });
      Provider.of<ListProvider>(context, listen: false)
          .addList(title)
          .then((_) {
        _input.currentState?.reset();
        setState(() {
          isFetching = false;
          isInputVisible = false;
        });
      }).catchError((_) {
        setState(() {
          isFetching = false;
        });
        _showError();
      });
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                  physics: const NeverScrollableScrollPhysics(),
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
                        }).catchError((_) {
                          setState(() {
                            fetchingId = null;
                          });
                          _showError();
                        });
                      },
                      child: ListTile(
                        title: Text(list.title),
                        trailing: fetchingId == list.id
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: theme.errorColor,
                                  strokeWidth: 2,
                                ),
                              )
                            : Icon(
                                CupertinoIcons.trash,
                                color: theme.errorColor,
                                size: 20,
                              ),
                      ),
                    );
                  },
                  itemCount: listData.items.length,
                ),
                AnimatedContainer(
                    height: isInputVisible ? 48 : 0,
                    duration: Duration(milliseconds: 150),
                    child: Form(
                        key: _form,
                        child: Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextFormField(
                                key: _input,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Введите название';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Введите название',
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: theme
                                          .primaryTextTheme.headline4?.color,
                                    )),
                              ),
                            )),
                            if (isInputVisible)
                              IconButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    _addList();
                                  },
                                  icon: isFetching
                                      ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Icon(
                                          Icons.check,
                                          color: theme.primaryColor,
                                        )),
                          ],
                        ))),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isInputVisible = !isInputVisible;
                    });
                  },
                  child: ListTile(
                    title: Text(
                      'Новая категория',
                      style: TextStyle(
                          color: theme.primaryTextTheme.headline4?.color),
                    ),
                    trailing: Icon(isInputVisible ? Icons.close : Icons.add,
                        color: isInputVisible
                            ? theme.errorColor
                            : theme.primaryTextTheme.headline4?.color),
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

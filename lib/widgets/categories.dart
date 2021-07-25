import 'package:flutter/material.dart';
import 'package:my_tasks_app/models/list_model.dart';
import 'package:my_tasks_app/providers/list_provider.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  final int? selectedId;
  final Function(int id) setSelectedCategory;

  Categories({required this.setSelectedCategory, this.selectedId});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<ListModel> lists = [];
  var selectedListId;

  @override
  void initState() {
    lists = Provider.of<ListProvider>(context, listen: false).items;
    selectedListId =
        lists.length > 0 ? (widget.selectedId ?? lists[0].id) : null;
    super.initState();
  }

  void _updateListId() {
    if (selectedListId != null) {
      widget.setSelectedCategory(selectedListId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    _updateListId();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Text(
              'Категория'.toUpperCase(),
              style: TextStyle(
                color: theme.primaryTextTheme.headline4?.color,
                fontSize: theme.primaryTextTheme.headline4?.fontSize,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, i) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedListId = lists[i].id;
                });
              },
              child: ListTile(
                title: Text(
                  lists[i].title,
                ),
                trailing: Icon(
                  selectedListId == lists[i].id
                      ? Icons.radio_button_on
                      : Icons.radio_button_off,
                  color: selectedListId == lists[i].id
                      ? theme.primaryColor
                      : Colors.black54,
                ),
              ),
            ),
            itemCount: lists.length,
          ),
        ],
      ),
    );
  }
}

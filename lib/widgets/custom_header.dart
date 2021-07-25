import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String? title;
  final Widget? rightButton;
  final bool isBackButton;

  CustomHeader({this.title, this.rightButton, required this.isBackButton});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width,
      child: SizedBox(
        width: deviceSize.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: isBackButton
                  ? IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  : null,
            ),
            Flexible(
              flex: 2,
              child: FlexibleSpaceBar(
                title: Text(
                  title ?? '',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: theme.primaryTextTheme.headline6?.fontWeight,
                      color: theme.primaryTextTheme.headline6?.color,
                      fontSize: theme.primaryTextTheme.headline6?.fontSize),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: rightButton,
            ),
          ],
        ),
      ),
    );
  }
}

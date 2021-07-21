import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String? title;
  final Widget? rightButton;
  final bool isBackButton;

  CustomHeader({this.title, this.rightButton, required this.isBackButton});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width,
      height: 250,
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          SizedBox(
            width: deviceSize.width,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isBackButton)
                  Positioned(
                      left: 20,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.black,
                        onPressed: () {
                          print('back');
                        },
                      )),
                if (title != null && title!.isNotEmpty)
                  Positioned(
                    left: 70,
                    child: Text(
                      title!,
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6?.color,
                        fontSize: Theme.of(context)
                            .primaryTextTheme
                            .headline6
                            ?.fontSize,
                      ),
                    ),
                  ),
                if (rightButton != null) Positioned(child: rightButton!, right: 20,),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

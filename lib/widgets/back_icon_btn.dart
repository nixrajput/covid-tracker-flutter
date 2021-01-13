import 'package:flutter/material.dart';

class BackIconBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: Theme.of(context).accentColor,
      ),
    );
  }
}

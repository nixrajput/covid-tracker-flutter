import 'package:flutter/material.dart';

class FlatResponseButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onPress;

  const FlatResponseButton({this.icon, this.title, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkResponse(
        onTap: onPress,
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Theme.of(context).accentColor,
            ),
            const SizedBox(width: 16.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:covid_tracker/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final double titleSize;
  final Color titleColor;
  final Widget leading;
  final Widget trailing;
  final Color bgColor;
  final EdgeInsets padding;
  final double elevation;

  const CustomAppBar({
    @required this.title,
    this.titleSize,
    this.titleColor,
    this.leading,
    this.trailing,
    this.padding,
    this.bgColor,
    this.elevation,
  }) : assert(title != null, 'Title must not be null.');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: bgColor ?? Theme.of(context).bottomAppBarColor,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: Offset(0.0, elevation ?? 0.0),
            blurRadius: 4.0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (leading != null) leading,
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleSize ?? 20.0,
                fontWeight: FontWeight.bold,
                color: titleColor ?? Theme.of(context).accentColor,
              ),
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}

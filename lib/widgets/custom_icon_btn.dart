import 'package:flutter/material.dart';

class CustomIconBtn extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;
  final EdgeInsets padding;
  final double iconSize;
  final Color bgColor;

  const CustomIconBtn({
    this.icon,
    this.iconColor,
    this.onTap,
    this.padding,
    this.iconSize,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: bgColor ?? Colors.transparent,
        padding: padding ?? const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: iconColor ?? Theme.of(context).accentColor,
          size: iconSize ?? 24.0,
        ),
      ),
    );
  }
}

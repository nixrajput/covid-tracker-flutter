import 'package:flutter/material.dart';

class CustomRoundedBtn extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double? borderRadius;
  final EdgeInsets? padding;
  final double? width;

  const CustomRoundedBtn({
    required this.title,
    required this.onTap,
    this.borderRadius,
    this.padding,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        padding: padding ?? const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 16.0)),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}

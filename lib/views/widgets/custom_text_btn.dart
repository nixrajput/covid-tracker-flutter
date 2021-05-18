import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextBtn extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? bgColor;
  final double? fontSize;
  final EdgeInsets? padding;

  const CustomTextBtn({
    required this.text,
    required this.onTap,
    this.textColor,
    this.bgColor,
    this.fontSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: bgColor ?? Colors.transparent,
        padding: padding ?? const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: fontSize ?? 14.0,
              fontWeight: FontWeight.bold,
              color: textColor ?? Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}

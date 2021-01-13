import 'package:flutter/material.dart';

class GradientCard extends StatelessWidget {
  final String text;

  GradientCard({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.all(20.0),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF60BE93),
            Color(0xFF1B8D59),
          ],
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: RichText(
        text: TextSpan(
          text: text,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

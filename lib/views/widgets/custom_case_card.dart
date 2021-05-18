import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CustomCaseCard extends StatelessWidget {
  final String title;
  final String value1;
  final String value2;
  final Color? bgColor;
  final VoidCallback? onTap;

  const CustomCaseCard({
    Key? key,
    required this.title,
    required this.value1,
    this.bgColor,
    this.value2 = '',
    this.onTap,
  }) : super(key: key);

  String _formatNumber(num) {
    final _numFormat = NumberFormat("#,##,000", "HI");
    return _numFormat.format(int.parse(num));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            )),
          ),
          Text(
            _formatNumber(value1),
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              color: bgColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            )),
          ),
          if (value2.isNotEmpty)
            Text(
              "+ ${_formatNumber(value2)}",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: bgColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              )),
            )
        ],
      ),
    );
  }
}

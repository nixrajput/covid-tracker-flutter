import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class StateWiseCaseCard extends StatelessWidget {
  final String title;
  final String confirmedCases;
  final String activeCases;
  final String recoveredCases;
  final String deathCases;
  final String confirmedCasesDaily;
  final String activeCasesDaily;
  final String recoveredCasesDaily;
  final String deathCasesDaily;
  final String stateNotes;
  final Color? bgColor;
  final Color cardColor;

  const StateWiseCaseCard({
    Key? key,
    required this.title,
    this.bgColor,
    required this.confirmedCases,
    required this.recoveredCases,
    required this.deathCases,
    required this.activeCases,
    this.stateNotes = '',
    this.confirmedCasesDaily = '',
    this.activeCasesDaily = '',
    this.recoveredCasesDaily = '',
    this.deathCasesDaily = '',
    this.cardColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: cardColor,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextCard(
                title: "Confirmed",
                value1: confirmedCases,
                value2: confirmedCasesDaily,
                bgColor: Colors.orangeAccent,
              ),
              TextCard(
                title: "Active",
                value1: activeCases,
                bgColor: Colors.lightBlue,
              ),
              TextCard(
                title: "Recovered",
                value1: recoveredCases,
                bgColor: Colors.lightGreen,
              ),
              TextCard(
                title: "Deaths",
                value1: deathCases,
                bgColor: Colors.redAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextCard extends StatelessWidget {
  final String title;
  final String value1;
  final String value2;
  final Color? bgColor;

  const TextCard({
    Key? key,
    required this.title,
    required this.value1,
    this.bgColor,
    this.value2 = '',
  }) : super(key: key);

  String _formatNumber(num) {
    final _numFormat = NumberFormat("#,##,000", "HI");
    return _numFormat.format(int.parse(num));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
          ),
          Text(
            _formatNumber(value1),
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: bgColor,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (value2.isNotEmpty) SizedBox(width: 10.0),
          if (value2.isNotEmpty)
            Text(
              "+ ${_formatNumber(value2)}",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: bgColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

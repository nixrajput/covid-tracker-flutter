import 'package:covid_tracker/constants/strings.dart';
import 'package:covid_tracker/screens/guidelines_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelpCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, GuidelinesScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * .4,
                top: 20,
                right: 20,
              ),
              height: 160.0,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Consult to any Doctor "
                    "or visit to a nearly Medical Center",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    "If any symptom appears!",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SvgPicture.asset(NURSE_ICON_PATH),
            ),
            Positioned(
              top: 30,
              right: 10,
              child: SvgPicture.asset(VIRUS_ICON_PATH),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:covid_tracker/constants/strings.dart';
import 'package:covid_tracker/screens/guidelines_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PreventionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          PreventionCardItem(
            svgSrc: WASH_HAND_ICON_PATH,
            title: "Wash Hands",
          ),
          PreventionCardItem(
            svgSrc: USE_MASK_ICON_PATH,
            title: "Use Masks",
          ),
          PreventionCardItem(
            svgSrc: DISINFECT_ICON_PATH,
            title: "Clean Disinfect",
          ),
        ],
      ),
    );
  }
}

class PreventionCardItem extends StatelessWidget {
  final String svgSrc;
  final String title;

  const PreventionCardItem({
    this.svgSrc,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, GuidelinesScreen.routeName);
      },
      child: Container(
        child: Column(
          children: <Widget>[
            SvgPicture.asset(svgSrc),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

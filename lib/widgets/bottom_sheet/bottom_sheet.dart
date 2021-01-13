import 'package:covid_tracker/constants/strings.dart';
import 'package:covid_tracker/screens/guidelines_screen.dart';
import 'package:covid_tracker/widgets/bottom_sheet/flat_response_button.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final Function sendMailFunc;
  final Function shareFunc;
  final Function aboutFunc;

  const CustomBottomSheet({this.sendMailFunc, this.shareFunc, this.aboutFunc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FlatResponseButton(
              onPress: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, GuidelinesScreen.routeName);
              },
              icon: Icons.bookmark_border,
              title: '$VIEW $GUIDELINES',
            ),
            FlatResponseButton(
              onPress: () {
                Navigator.pop(context);
                sendMailFunc();
              },
              icon: Icons.mail_outline,
              title: CONTACT_US,
            ),
            FlatResponseButton(
              onPress: () {
                Navigator.pop(context);
                shareFunc();
              },
              icon: Icons.share,
              title: SHARE,
            ),
            FlatResponseButton(
              onPress: () {
                Navigator.pop(context);
                aboutFunc();
              },
              icon: Icons.info_outline,
              title: ABOUT,
            ),
          ],
        ),
      ),
    );
  }
}

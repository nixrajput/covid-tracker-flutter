import 'package:covid_tracker/constants/strings.dart';
import 'package:covid_tracker/widgets/cards/single_case_type_card.dart';
import 'package:flutter/material.dart';

class CaseInfoCard extends StatelessWidget {
  final String infected;
  final String tested;
  final String recovered;
  final String deceased;
  final String country;
  final String moreData;
  final String historyData;
  final String sourceUrl;
  final String lastUpdatedApify;

  const CaseInfoCard({
    Key key,
    this.infected,
    this.tested,
    this.recovered,
    this.deceased,
    this.country,
    this.moreData,
    this.historyData,
    this.sourceUrl,
    this.lastUpdatedApify,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.zero,
            bottomLeft: Radius.zero,
            bottomRight: Radius.circular(16.0)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2.0),
            blurRadius: 8.0,
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            country,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).textTheme.subtitle1.color,
              fontWeight: FontWeight.bold,
              fontSize: bodyHeight * 0.025,
            ),
          ),
          Divider(),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SingleCaseTypeCard(
                title: INFECTED,
                value: infected,
              ),
              SingleCaseTypeCard(
                title: RECOVERED,
                value: recovered,
              ),
              SingleCaseTypeCard(
                title: DEATHS,
                value: deceased,
              ),
            ],
          )
        ],
      ),
    );
  }
}

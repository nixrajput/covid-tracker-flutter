import 'package:covid_tracker/utils/util_functions.dart';
import 'package:flutter/material.dart';

class SingleCaseTypeCard extends StatelessWidget {
  final String title;
  final String value;
  final Color titleColor;
  final Color valueColor;

  const SingleCaseTypeCard({
    Key key,
    this.title,
    this.value,
    this.titleColor,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: titleColor ?? Theme.of(context).textTheme.subtitle1.color,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          Text(
            formatToNumeric(value),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: valueColor ?? Theme.of(context).textTheme.subtitle1.color,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}

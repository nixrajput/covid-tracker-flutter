import 'package:covid_tracker/constants/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineReportChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.2,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: getSpots(),
              isCurved: true,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
              colors: [accentColor],
              barWidth: 4,
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> getSpots() {
    return [
      FlSpot(0, 0),
      FlSpot(1, 5),
      FlSpot(2, 3),
      FlSpot(3, 8),
      FlSpot(4, 10),
      FlSpot(5, 12),
      FlSpot(6, 15),
    ];
  }
}

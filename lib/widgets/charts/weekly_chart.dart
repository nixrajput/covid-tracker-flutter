import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyChart extends StatelessWidget {
  final List<dynamic> weekList;
  final List<double> barChartData;
  final Color barColor;

  WeeklyChart({this.weekList, this.barChartData, this.barColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: AspectRatio(
        aspectRatio: 1.7,
        child: BarChart(
          BarChartData(
            barTouchData: BarTouchData(
                enabled: false,
                touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.transparent,
                    tooltipPadding: EdgeInsets.all(0),
                    tooltipBottomMargin: 8.0,
                    getTooltipItem: (BarChartGroupData group, int groupIndex,
                        BarChartRodData rod, int rodIndex) {
                      return BarTooltipItem(
                          rod.y.round().toString(), TextStyle(color: barColor));
                    })),
            barGroups: [
              BarChartGroupData(x: 0, barRods: [
                BarChartRodData(width: 16, y: barChartData[0]),
              ], showingTooltipIndicators: [
                0
              ]),
              BarChartGroupData(
                  x: 1,
                  barRods: [BarChartRodData(width: 16, y: barChartData[1])],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 2,
                  barRods: [BarChartRodData(width: 16, y: barChartData[2])],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 3,
                  barRods: [BarChartRodData(width: 16, y: barChartData[3])],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 4,
                  barRods: [BarChartRodData(width: 16, y: barChartData[4])],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 5,
                  barRods: [BarChartRodData(width: 16, y: barChartData[5])],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 6,
                  barRods: [BarChartRodData(width: 16, y: barChartData[6])],
                  showingTooltipIndicators: [0]),
            ],
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              leftTitles: SideTitles(
                showTitles: false,
              ),
              bottomTitles: SideTitles(
                showTitles: true,
                getTitles: getWeek,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getWeek(double value) {
    switch (value.toInt()) {
      case 0:
        return weekList[0].toString();
      case 1:
        return weekList[1].toString();
      case 2:
        return weekList[2].toString();
      case 3:
        return weekList[3].toString();
      case 4:
        return weekList[4].toString();
      case 5:
        return weekList[5].toString();
      case 6:
        return weekList[6].toString();
      default:
        return '';
    }
  }
}

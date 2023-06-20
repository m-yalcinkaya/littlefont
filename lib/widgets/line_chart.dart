import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/modals/weather.dart';

class WeatherLineChart extends ConsumerStatefulWidget {
  final Weather? weatherData;
  const WeatherLineChart({
    super.key,
    required this.weatherData,
  });

  @override
  ConsumerState<WeatherLineChart> createState() => _LineChartSample5State();
}

class _LineChartSample5State extends ConsumerState<WeatherLineChart> {
  final Color gradientColor1 = Colors.blue;
  final Color gradientColor2 = Colors.orange;
  final Color gradientColor3 = Colors.red;
  final Color indicatorStrokeColor = Colors.green;
  
  DateTime now = DateTime.now();

  late String day;
  List<int> showingTooltipOnSpots = [1, 3, 5];
  late double day1Temp;
  late double day2Temp;
  late double day3Temp;
  late double day4Temp;
  late double day5Temp;
  late double day6Temp;
  late double day7Temp;


  double maxTempY(){
    List<double> list = [day1Temp, day2Temp, day3Temp, day4Temp, day5Temp, day6Temp, day7Temp];
    double maxTemp = day1Temp;
    for(double value in list){
      if(value > maxTemp){
        maxTemp = value;
      }
    }
    maxTemp = maxTemp.floorToDouble() + 2;
    return maxTemp;
  }

  double minTempY(){
    List<double> list = [day1Temp, day2Temp, day3Temp, day4Temp, day5Temp, day6Temp, day7Temp];
    double minTemp = day1Temp;
    for(double value in list){
      if(value < minTemp){
        minTemp = value;
      }
    }
    minTemp = minTemp.ceilToDouble() - 2;
    return minTemp;
  }


  @override
  initState(){
    day1Temp = widget.weatherData!.currentTemp!.roundToDouble();
    day2Temp = widget.weatherData?.tempsDaily[1]["day"].roundToDouble();
    day3Temp = widget.weatherData?.tempsDaily[2]["day"].roundToDouble();
    day4Temp = widget.weatherData?.tempsDaily[3]["day"].roundToDouble();
    day5Temp = widget.weatherData?.tempsDaily[4]["day"].roundToDouble();
    day6Temp = widget.weatherData?.tempsDaily[5]["day"].roundToDouble();
    day7Temp = widget.weatherData?.tempsDaily[6]["day"].roundToDouble();
    super.initState();
  }

  List<FlSpot> get allSpots => [
    FlSpot(0, day1Temp),
    FlSpot(1, day2Temp),
    FlSpot(2, day3Temp),
    FlSpot(3, day4Temp),
    FlSpot(4, day5Temp),
    FlSpot(5, day6Temp),
    FlSpot(6, day7Temp),
  ];

  String getDayOfWeek(int weekday) {
    if(weekday != 7){
      weekday = weekday%7;
    }
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        spots: allSpots,
        isCurved: false,
        barWidth: 4,
        shadow: const Shadow(
          blurRadius: 10,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              gradientColor1.withOpacity(0.4),
              gradientColor2.withOpacity(0.4),
              gradientColor3.withOpacity(0.4),
            ],
          ),
        ),
        dotData: const FlDotData(show: true),
        gradient: LinearGradient(
          colors: [
            gradientColor1,
            gradientColor2,
            gradientColor3,
          ],
          stops: const [0.2, 0.9, 1],
        ),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return LineChart(
            LineChartData(
              maxY: maxTempY(),
              minY: minTempY(),
              showingTooltipIndicators: showingTooltipOnSpots.map((index) {
                return ShowingTooltipIndicators([
                  LineBarSpot(
                    tooltipsOnBar,
                    lineBarsData.indexOf(tooltipsOnBar),
                    tooltipsOnBar.spots[index],
                  ),
                ]);
              }).toList(),
              lineTouchData: LineTouchData(
                enabled: true,
                handleBuiltInTouches: true,
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? response) {
                  if (response == null || response.lineBarSpots == null) {
                    return;
                  }
                  if (event is FlTapUpEvent) {
                    final spotIndex = response.lineBarSpots!.first.spotIndex;
                    setState(() {
                      if (showingTooltipOnSpots.contains(spotIndex)) {
                        showingTooltipOnSpots.remove(spotIndex);
                      } else {
                        showingTooltipOnSpots.add(spotIndex);
                      }
                    });
                  }
                },
                mouseCursorResolver:
                    (FlTouchEvent event, LineTouchResponse? response) {
                  if (response == null || response.lineBarSpots == null) {
                    return SystemMouseCursors.basic;
                  }
                  return SystemMouseCursors.click;
                },
                getTouchedSpotIndicator:
                    (LineChartBarData barData, List<int> spotIndexes) {
                  return spotIndexes.map((index) {
                    return TouchedSpotIndicatorData(
                      const FlLine(
                        color: Colors.pink,
                      ),
                      FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                              radius: 8,
                              strokeWidth: 2,
                              strokeColor: indicatorStrokeColor,
                            ),
                      ),
                    );
                  }).toList();
                },
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: Colors.grey,
                  tooltipRoundedRadius: 8,
                  getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                    return lineBarsSpot.map((lineBarSpot) {
                      final spotIndex = lineBarSpot.spotIndex;
                      final dayIndex = now.weekday + spotIndex;
                      final day = getDayOfWeek(dayIndex % 7); // Mod işlemi ile döngü oluştur

                      return LineTooltipItem(
                        '${lineBarSpot.y.round().toString()} \u00B0C\n$day',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }).toList();
                  },
                ),

              ),
              lineBarsData: lineBarsData,
              titlesData: const FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  )
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                topTitles: AxisTitles(
                  axisNameWidget: Text(
                    'Daily Weather Line Chart',
                    textAlign: TextAlign.left,
                  ),
                  axisNameSize: 25,
                  sideTitles: SideTitles(
                    showTitles: false,
                    reservedSize: 0,
                  ),
                ),
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: Colors.black,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}


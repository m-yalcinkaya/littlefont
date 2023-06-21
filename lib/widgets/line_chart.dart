import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/modals/weather.dart';
import 'package:littlefont_app/repository/weather_repository.dart';

class WeatherLineChart extends ConsumerStatefulWidget {
  final Weather? weatherData;
  const WeatherLineChart({
    super.key,
    required this.weatherData,
  });

  @override
  ConsumerState<WeatherLineChart> createState() => _WeatherLineChartState();
}

class _WeatherLineChartState extends ConsumerState<WeatherLineChart> {
  final Color gradientColor1 = Colors.blue;
  final Color gradientColor2 = Colors.orange;
  final Color gradientColor3 = Colors.red;
  final Color indicatorStrokeColor = Colors.green;
  
  DateTime now = DateTime.now();

  late String day;
  List<int> showingTooltipOnSpots = [1, 3, 5];


  double maxTempY(){
    final weatherRepo = ref.read(weatherProvider);
    List<double> list = [
      weatherRepo.day1Temp,
      weatherRepo.day2Temp,
      weatherRepo.day3Temp,
      weatherRepo.day4Temp,
      weatherRepo.day5Temp,
      weatherRepo.day6Temp,
      weatherRepo.day7Temp];
    double maxTemp = weatherRepo.day1Temp;
    for(double value in list){
      if(value > maxTemp){
        maxTemp = value;
      }
    }
    maxTemp = maxTemp.floorToDouble() + 2;
    return maxTemp;
  }

  double minTempY(){
    final weatherRepo = ref.read(weatherProvider);
    List<double> list = [
      weatherRepo.day1Temp,
      weatherRepo.day2Temp,
      weatherRepo.day3Temp,
      weatherRepo.day4Temp,
      weatherRepo.day5Temp,
      weatherRepo.day6Temp,
      weatherRepo.day7Temp];
    double minTemp =weatherRepo.day1Temp;
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
    final weatherRepo = ref.read(weatherProvider);
    weatherRepo.assignTemps(weatherRepo.data);
    super.initState();
  }

  List<FlSpot> get allSpots => [
    FlSpot(0, ref.read(weatherProvider).day1Temp),
    FlSpot(1, ref.read(weatherProvider).day2Temp),
    FlSpot(2, ref.read(weatherProvider).day3Temp),
    FlSpot(3, ref.read(weatherProvider).day4Temp),
    FlSpot(4, ref.read(weatherProvider).day5Temp),
    FlSpot(5, ref.read(weatherProvider).day6Temp),
    FlSpot(6, ref.read(weatherProvider).day7Temp),
    FlSpot(7, ref.read(weatherProvider).day8Temp)
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
          return Padding(
            padding: const EdgeInsets.all(20),
            child: LineChart(
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
                        var dayIndex = now.weekday + spotIndex;
                        if(dayIndex != 7) dayIndex = dayIndex % 7;
                        final day = getDayOfWeek(dayIndex);

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
            ),
          );
        }),
      ),
    );
  }
}


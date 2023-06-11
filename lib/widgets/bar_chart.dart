import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeatherChartPage extends StatefulWidget {
  const WeatherChartPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherChartPageState createState() => _WeatherChartPageState();
}

class _WeatherChartPageState extends State<WeatherChartPage> {
  late List<BarChartGroupData> _barChartGroupData;
  late int _tappedIndex = -1;

  @override
  void initState() {
    super.initState();
    _generateData();
  }

  void _generateData() {
    const List<double> temperatures = [25, 28, 27, 30, 29, 31, 26];
    _barChartGroupData = List.generate(temperatures.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            y: temperatures[index],
            colors: _tappedIndex == index
                ? [Colors.red.shade900]
                : [Colors.blue],
            width: 16,
            borderRadius: BorderRadius.circular(8),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              y: 32,
              colors: [Colors.blue.withOpacity(0.2)],
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.5,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 40,
                minY: 20,
                groupsSpace: 12,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.blueGrey,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      late String weekday;
                      switch (group.x.toInt()) {
                        case 0:
                          weekday = 'Pazartesi';
                          break;
                        case 1:
                          weekday = 'Salı';
                          break;
                        case 2:
                          weekday = 'Çarşamba';
                          break;
                        case 3:
                          weekday = 'Perşembe';
                          break;
                        case 4:
                          weekday = 'Cuma';
                          break;
                        case 5:
                          weekday = 'Cumartesi';
                          break;
                        case 6:
                          weekday = 'Pazar';
                          break;
                      }
                      return BarTooltipItem(
                        '$weekday\n${rod.y}°C',
                        const TextStyle(color: Colors.yellow),
                      );
                    },
                  ),
                  touchCallback: (p0) {
                    if (p0.spot == null) {
                      setState(() {
                        _tappedIndex = -1;
                      });
                      return;
                    }
                    setState(() {
                      _tappedIndex = p0.spot!.touchedBarGroupIndex;
                    });
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    margin: 20,
                    getTitles: (value) {
                      switch (value.toInt()) {
                        case 0:
                          return 'Pzt';
                        case 1:
                          return 'Salı';
                        case 2:
                          return 'Çarş';
                        case 3:
                          return 'Perş';
                        case 4:
                          return 'Cuma';
                        case 5:
                          return 'Cmt';
                        case 6:
                          return 'Paz';
                        default:
                          return '';
                      }
                    },
                  ),
                  leftTitles: SideTitles(
                    showTitles: false,
                    margin: 32,
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: _barChartGroupData,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

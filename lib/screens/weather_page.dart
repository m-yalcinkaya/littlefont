import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/repository/weather_repository.dart';
import 'package:littlefont_app/utilities/weather_utils.dart';
import 'package:weather_icons/weather_icons.dart';

import '../widgets/line_chart.dart';


class WeatherPage extends ConsumerStatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  ConsumerState<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends ConsumerState<WeatherPage> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LittleFont Weather'),
        actions: [
          IconButton(onPressed: () {
            showDialog(context: context,
              builder: (context) {
                return AlertDialog(
                  alignment: Alignment.center,
                    actions: [
                      TextField(controller: controller,),
                      TextButton(
                        onPressed: () {
                          try{
                              ref.read(weatherProvider).getWeather(controller.text).then((weather) {
                                if(weather != null) {
                                  ref.read(weatherProvider).data = weather;
                                }else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalided area name')));
                                }
                                controller.text = '';
                                Navigator.pop(context);
                                final weatherRepo = ref.read(weatherProvider);
                                weatherRepo.assignTemps(weatherRepo.data);
                            });
                          }catch(e){
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
                          }finally{
                            setState(() {
                            });
                          }

                        },child: const Text('Select Area'),
                      ),
                    ],
                );
              },);
          }, icon: const Icon(Icons.change_circle_outlined))
        ],
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 70),
            Text(
              ref
                  .watch(weatherProvider)
                  .data!
                  .areaName ?? 'null',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              '${ref
                  .watch(weatherProvider)
                  .data!
                  .currentTemp?.round()} \u00B0C',
              style: const TextStyle(fontSize: 50),
            ),
            Text(
              '${ref
                  .watch(weatherProvider)
                  .data!
                  .status}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              'Humidity: ${ref.watch(weatherProvider).humidityValue.toInt()}%',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 5,),
            Text('Apparent temperature: ${ref.watch(weatherProvider).feelsLikeTemp.toInt()}\u00B0C', style: TextStyle(fontSize: 20),),
            const SizedBox(height: 60,),
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  
                  children: [
                    SizedBox(
                      width: 57,
                      child: Card(child:
                      Column(children: [
                        Text('${ref.watch(weatherProvider).day1Temp.toInt()}\u00B0C', style: const TextStyle(fontSize: 12)),
                        Icon(weatherIcon(ref.watch(weatherProvider).icon1)),
                        const SizedBox(height: 20,),
                        Text('Min : ${ref.watch(weatherProvider).day1Min.toInt()}\u00B0C', style: const TextStyle(fontSize: 10)),
                        const SizedBox(height: 3,),
                        Text('Max : ${ref.watch(weatherProvider).day1Max.toInt()}\u00B0C', style: const TextStyle(fontSize: 10)),
                      ])),
                    ),
                    SizedBox(
                      width: 57,
                      child: Card(child:
                      Column(children: [
                        Text('${ref.watch(weatherProvider).day2Temp.toInt()}\u00B0C', style: const TextStyle(fontSize: 12)),
                        Icon(weatherIcon(ref.watch(weatherProvider).icon2)),
                        const SizedBox(height: 20,),
                        Text('Min : ${ref.watch(weatherProvider).day2Min.toInt()}\u00B0C', style: const TextStyle(fontSize: 10)),
                        const SizedBox(height: 3,),
                        Text('Max : ${ref.watch(weatherProvider).day2Max.toInt()}\u00B0C', style: const TextStyle(fontSize: 10)),
                      ])),
                    ),
                    SizedBox(
                      width: 57,
                      child: Card(child:
                      Column(children: [
                        Text('${ref.watch(weatherProvider).day3Temp.toInt()}\u00B0C', style: const TextStyle(fontSize: 12)),
                        Icon(weatherIcon(ref.watch(weatherProvider).icon3)),
                        const SizedBox(height: 20,),
                        Text('Min : ${ref.watch(weatherProvider).day3Min.toInt()}\u00B0C', style: const TextStyle(fontSize: 10)),
                        const SizedBox(height: 3,),
                        Text('Max : ${ref.watch(weatherProvider).day3Max.toInt()}\u00B0C', style: const TextStyle(fontSize: 10)),
                      ])),
                    ),
                    SizedBox(
                      width: 57,
                      child: Card(child:
                      Column(children: [
                        Text('${ref.watch(weatherProvider).day4Temp.toInt()}\u00B0C', style: const TextStyle(fontSize: 12)),
                        Icon(weatherIcon(ref.watch(weatherProvider).icon4)),
                        const SizedBox(height: 20,),
                        Text('Min : ${ref.watch(weatherProvider).day4Min.toInt()}\u00B0C', style: const TextStyle(fontSize: 10)),
                        const SizedBox(height: 3,),
                        Text('Max : ${ref.watch(weatherProvider).day4Max.toInt()}\u00B0C', style: const TextStyle(fontSize: 10)),
                      ])),
                    ),
                    SizedBox(
                      width: 57,
                      child: Card(child:
                      Column(children: [
                        Text('${ref.watch(weatherProvider).day5Temp.toInt()}\u00B0C', style: const TextStyle(fontSize: 12)),
                        Icon(weatherIcon(ref.watch(weatherProvider).icon5)),
                        const SizedBox(height: 20,),
                        Text('Min : ${ref.watch(weatherProvider).day5Min.toInt()}\u00B0C', style: const TextStyle(fontSize: 10)),
                        const SizedBox(height: 3,),
                        Text('Max : ${ref.watch(weatherProvider).day5Max.toInt()}\u00B0C', style: const TextStyle(fontSize: 10)),
                      ])),
                    ),
                    SizedBox(
                      width: 57,
                      child: Card(child:
                      Column(children: [
                        Text('${ref.watch(weatherProvider).day6Temp.toInt()}\u00B0C', style: const TextStyle(fontSize: 12)),
                        Icon(weatherIcon(ref.watch(weatherProvider).icon6)),
                        const SizedBox(height: 20,),
                        Text('Min : ${ref.watch(weatherProvider).day6Min.toInt()}\u00B0C', style: const TextStyle(fontSize: 10)),
                        const SizedBox(height: 3,),
                        Text('Max : ${ref.watch(weatherProvider).day6Max.toInt()}\u00B0C', style: const TextStyle(fontSize: 10)),
                      ])),
                    ),
                    SizedBox(
                      width: 57,
                      child: Card(child:
                      Column(children: [
                        Text('${ref.watch(weatherProvider).day7Temp.toInt()}\u00B0C', style: const TextStyle(fontSize: 12)),
                        Icon(weatherIcon(ref.watch(weatherProvider).icon7)),
                        const SizedBox(height: 20,),
                        Text('Min : ${ref.watch(weatherProvider).day7Min.toInt()}\u00B0C', style: const TextStyle(fontSize: 10)),
                        const SizedBox(height: 3,),
                        Text('Max : ${ref.watch(weatherProvider).day7Max.toInt()}\u00B0C', style: const TextStyle(fontSize: 10)),
                      ])),
                    ),

                  ],
                ),
              ),
            ),
            const WeatherLineChart(),
            // const WeatherChartPage(),
          ],
        ),
      ),
    );
  }
}

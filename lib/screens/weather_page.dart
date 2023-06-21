import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/repository/weather_repository.dart';

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
            const Text(
              'Humidity: ',
              style: TextStyle(fontSize: 20),
            ),
            const WeatherLineChart(),
            // const WeatherChartPage(),
          ],
        ),
      ),
    );
  }
}

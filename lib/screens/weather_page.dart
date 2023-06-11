import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/repository/weather_repository.dart';
import 'package:littlefont_app/utilities/weather_utils.dart';
import 'package:littlefont_app/widgets/button.dart';


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
                      Button(
                          text: 'Select area',
                          color: Colors.red,
                          onPressedOperations: () {
                              try{
                                ref.read(weatherRepository).getWeather(controller.text).then((weather) {
                                  if(weather != null) {
                                    ref.read(weatherRepository).data = weather;
                                  }else {
                                    return;
                                  }
                                  Navigator.pop(context);
                                },).catchError(throw Exception('Invalided area name!!'));
                              }catch(e){
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
                              }
                          },
                          width: 50,
                          height: 50,
                          textColor: Colors.white,
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
                  .watch(weatherRepository)
                  .data!
                  .areaName ?? 'null',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              '${ref
                  .watch(weatherRepository)
                  .data!
                  .currentTemp?.round()} \u00B0C',
              style: const TextStyle(fontSize: 50),
            ),
            Text(
              '${ref
                  .watch(weatherRepository)
                  .data!
                  .status}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}

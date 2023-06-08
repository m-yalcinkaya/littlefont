import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/services/weather_service.dart';
import 'package:littlefont_app/utilities/weather_utils.dart';

class WeatherPage extends ConsumerStatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  ConsumerState<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends ConsumerState<WeatherPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LittleFont Weather'),),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 70),
            Text(ref.watch(weatherServiceProvider).data!.areaName ?? 'null', style: const TextStyle(fontSize: 20),),
            Icon(weatherIcon(ref.watch(weatherServiceProvider).data?.icon), size: 100,),
            const SizedBox(height: 70),
            Text(ref.watch(weatherServiceProvider).data!.areaName ?? 'null', style: const TextStyle(fontSize: 20),),

          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/services/weather_service.dart';

import '../modals/weather.dart';

class WeatherRepository extends ChangeNotifier{
  final WeatherService weatherService;
  WeatherRepository(this.weatherService);


  Weather? data;
  String area = 'Aydın';


  Future<Weather?> getWeather(String area) async {
    try {
      final value = await weatherService.getWeatherForDaily(area);
      return value;
    } catch (e) {
      throw Exception('An error occured when loading daily weather data \n$e}');
    }finally{
      notifyListeners();
    }
  }


}


final weatherRepository = ChangeNotifierProvider((ref) {
  return WeatherRepository(ref.read(weatherServiceProvider));
},);

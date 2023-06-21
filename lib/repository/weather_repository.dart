import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/services/weather_service.dart';

import '../modals/weather.dart';

class WeatherRepository extends ChangeNotifier{
  final WeatherService weatherService;
  WeatherRepository(this.weatherService);


  Weather? data;
  String area = 'Aydın';
  late double day1Temp;
  late double day2Temp;
  late double day3Temp;
  late double day4Temp;
  late double day5Temp;
  late double day6Temp;
  late double day7Temp;
  late double day8Temp;


  void assignTemps(weatherData){
    day1Temp = weatherData!.currentTemp!.roundToDouble();
    day2Temp = weatherData?.tempsDaily[1]["day"].roundToDouble();
    day3Temp = weatherData?.tempsDaily[2]["day"].roundToDouble();
    day4Temp = weatherData?.tempsDaily[3]["day"].roundToDouble();
    day5Temp = weatherData?.tempsDaily[4]["day"].roundToDouble();
    day6Temp = weatherData?.tempsDaily[5]["day"].roundToDouble();
    day7Temp = weatherData?.tempsDaily[6]["day"].roundToDouble();
    day8Temp = weatherData?.tempsDaily[7]["day"].roundToDouble();
    notifyListeners();
  }


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


final weatherProvider = ChangeNotifierProvider((ref) {
  return WeatherRepository(ref.read(weatherServiceProvider));
},);

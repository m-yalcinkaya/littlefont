import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont_app/services/weather_service.dart';

import '../modals/weather.dart';

class WeatherRepository extends ChangeNotifier{
  final WeatherService weatherService;
  WeatherRepository(this.weatherService);


  Weather? data;
  String area = 'Aydın';
  late double feelsLikeTemp;
  late int humidityValue;

  late double day1Temp;
  late double day2Temp;
  late double day3Temp;
  late double day4Temp;
  late double day5Temp;
  late double day6Temp;
  late double day7Temp;
  late double day8Temp;

  late double day1Min;
  late double day2Min;
  late double day3Min;
  late double day4Min;
  late double day5Min;
  late double day6Min;
  late double day7Min;
  late double day8Min;

  late double day1Max;
  late double day2Max;
  late double day3Max;
  late double day4Max;
  late double day5Max;
  late double day6Max;
  late double day7Max;
  late double day8Max;


  late String icon1;
  late String icon2;
  late String icon3;
  late String icon4;
  late String icon5;
  late String icon6;
  late String icon7;
  late String icon8;

  void assignTemps(weatherData){
    day1Temp = weatherData!.currentTemp!.roundToDouble();
    day2Temp = weatherData?.tempsDaily[1]["day"].roundToDouble();
    day3Temp = weatherData?.tempsDaily[2]["day"].roundToDouble();
    day4Temp = weatherData?.tempsDaily[3]["day"].roundToDouble();
    day5Temp = weatherData?.tempsDaily[4]["day"].roundToDouble();
    day6Temp = weatherData?.tempsDaily[5]["day"].roundToDouble();
    day7Temp = weatherData?.tempsDaily[6]["day"].roundToDouble();
    day8Temp = weatherData?.tempsDaily[7]["day"].roundToDouble();
    day1Min = weatherData?.tempsDaily[0]["min"].roundToDouble();
    day2Min = weatherData?.tempsDaily[1]["min"].roundToDouble();
    day3Min = weatherData?.tempsDaily[2]["min"].roundToDouble();
    day4Min = weatherData?.tempsDaily[3]["min"].roundToDouble();
    day5Min = weatherData?.tempsDaily[4]["min"].roundToDouble();
    day6Min = weatherData?.tempsDaily[5]["min"].roundToDouble();
    day7Min = weatherData?.tempsDaily[6]["min"].roundToDouble();
    day8Min = weatherData?.tempsDaily[7]["min"].roundToDouble();
    day1Max = weatherData?.tempsDaily[0]["max"].roundToDouble();
    day2Max = weatherData?.tempsDaily[1]["max"].roundToDouble();
    day3Max = weatherData?.tempsDaily[2]["max"].roundToDouble();
    day4Max = weatherData?.tempsDaily[3]["max"].roundToDouble();
    day5Max = weatherData?.tempsDaily[4]["max"].roundToDouble();
    day6Max = weatherData?.tempsDaily[5]["max"].roundToDouble();
    day7Max = weatherData?.tempsDaily[6]["max"].roundToDouble();
    day8Max = weatherData?.tempsDaily[7]["max"].roundToDouble();
    icon1 = weatherData?.icons[0];
    icon2 = weatherData?.icons[1];
    icon3 = weatherData?.icons[2];
    icon4 = weatherData?.icons[3];
    icon5 = weatherData?.icons[4];
    icon6 = weatherData?.icons[5];
    icon7 = weatherData?.icons[6];
    icon8 = weatherData?.icons[7];
    feelsLikeTemp = weatherData?.feelsLike.roundToDouble();
    humidityValue = weatherData?.humidity;
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

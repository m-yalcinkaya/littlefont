import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:littlefont/modals/weather.dart';

class WeatherService {


  Weather? data;

  Future<Weather?> getWeatherForDaily() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=Aydın&units=metric&APPID=43ea6baaad7663dc17637e22ee6f78f2'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> map = jsonDecode(response.body);
        final province = map["name"];
        final lat = map["coord"]["lat"];
        final lon = map["coord"]["lon"];
        final responseDaily = await http.get(Uri.parse(
            'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=43ea6baaad7663dc17637e22ee6f78f2'));
        if(responseDaily.statusCode == 200){
          final Map<String, dynamic> mapDaily = jsonDecode(responseDaily.body);
          final dailyWeather = Weather.fromJson(mapDaily);
          dailyWeather.areaName = province;
          return dailyWeather;
        }
      }
    } catch (e) {
      throw Exception('An error occured when loading daily weather data \n$e}');
    }
    return null;
  }

}

final weatherServiceProvider = Provider((ref) {
  return WeatherService();
});

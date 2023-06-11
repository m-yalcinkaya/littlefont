import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:littlefont_app/modals/weather.dart';

class WeatherService {


  Future<Weather?> getWeatherForDaily(String area) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$area&units=metric&APPID=43ea6baaad7663dc17637e22ee6f78f2'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> map = jsonDecode(response.body);
      final country =  map["sys"]["country"];
      final province = map["name"];
      final lat = map["coord"]["lat"];
      final lon = map["coord"]["lon"];
      final responseDaily = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=43ea6baaad7663dc17637e22ee6f78f2'));
      if(responseDaily.statusCode == 200){
        final Map<String, dynamic> mapDaily = jsonDecode(responseDaily.body);
        final dailyWeather = Weather.fromJson(mapDaily);
        dailyWeather.areaName = '$province, $country';
        return dailyWeather;
      }
    }
    return null;
  }

}

final weatherServiceProvider = Provider((ref) {
  return WeatherService();
});

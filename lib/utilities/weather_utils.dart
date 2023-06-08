import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

IconData weatherIcon(String? iconType) {
  if (iconType == '01d') {return WeatherIcons.day_sunny;}
  else if(iconType == '01n'){return WeatherIcons.night_clear;}
  else if(iconType == '02d') {return WeatherIcons.day_cloudy;}
  else if(iconType == '02n') {return WeatherIcons.night_alt_cloudy;}
  else if(iconType == '03d') {return WeatherIcons.cloud;}
  else if (iconType == '03n') {return WeatherIcons.night_alt_cloudy;}
  else if (iconType == '04d') {return WeatherIcons.cloudy;}
  else if (iconType == '04n') {return WeatherIcons.night_alt_cloudy;}
  else if (iconType == '09d') {return WeatherIcons.rain;}
  else if (iconType == '09n') {return WeatherIcons.night_alt_rain;}
  else if (iconType == '10d') {return WeatherIcons.day_rain;}
  else if (iconType == '10n') {return WeatherIcons.night_rain;}
  else if (iconType == '11d') {return WeatherIcons.lightning;}
  else if (iconType == '11n') {return WeatherIcons.night_lightning;}
  else if (iconType == '13d') {return WeatherIcons.snowflake_cold;}
  else if (iconType == '13n') {return WeatherIcons.night_snow_wind;}
  else if (iconType == '50d') {return WeatherIcons.fog;}
  else {return WeatherIcons.night_fog;}
}
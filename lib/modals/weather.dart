class Weather {
  String? areaName;
  double? currentTemp;
  String? status;
  String? icon;
  double? feelsLike;
  int?  humidity;
  List<Map<String, dynamic>> tempsDaily = [];
  List<String> icons = [];


  Weather({
    required this.areaName,
    required this.currentTemp,
    required this.status,
    required this.icon,
  });

  Weather.fromJson(Map<String, dynamic> map) {
    currentTemp = map["current"]["temp"];
    status = map["current"]["weather"][0]["main"];
    icon = map["current"]["weather"][0]["icon"];
    feelsLike = map["current"]["feels_like"];
    humidity = map["current"]["humidity"];
    tempsDaily = [
      map["daily"][0]["temp"],
      map["daily"][1]["temp"],
      map["daily"][2]["temp"],
      map["daily"][3]["temp"],
      map["daily"][4]["temp"],
      map["daily"][5]["temp"],
      map["daily"][6]["temp"],
      map["daily"][7]["temp"],];
    icons = [
      map["daily"][0]["weather"][0]["icon"],
      map["daily"][1]["weather"][0]["icon"],
      map["daily"][2]["weather"][0]["icon"],
      map["daily"][3]["weather"][0]["icon"],
      map["daily"][4]["weather"][0]["icon"],
      map["daily"][5]["weather"][0]["icon"],
      map["daily"][6]["weather"][0]["icon"],
      map["daily"][7]["weather"][0]["icon"],];
  }
}

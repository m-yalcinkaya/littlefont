class Weather {
  String? areaName;
  double? currentTemp;
  String? status;
  String? icon;
  List<Map<String, dynamic>> tempsDaily = [];

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
    tempsDaily = [
      map["daily"][0]["temp"],
      map["daily"][1]["temp"],
      map["daily"][2]["temp"],
      map["daily"][3]["temp"],
      map["daily"][4]["temp"],
      map["daily"][5]["temp"],
      map["daily"][6]["temp"],
      map["daily"][7]["temp"],];
  }
}

class Weather {
  String? areaName;
  double? currentTemp;
  String? status;
  String? icon;

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
  }
}

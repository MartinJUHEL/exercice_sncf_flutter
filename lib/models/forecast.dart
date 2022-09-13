// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:exercicedevsncf/models/weather.dart';

class Forecast {
  Forecast({
    required this.dt,
    required this.temp,
    required this.weather,
    required this.dtTxt,
  });

  num dt;
  List<Weather> weather;
  num temp;
  DateTime dtTxt;

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        dt: json["dt"],
        temp: json["main"]["temp"],
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        dtTxt: DateTime.parse(json["dt_txt"]),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "temp": temp,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "dt_txt": dtTxt.toIso8601String(),
      };
}

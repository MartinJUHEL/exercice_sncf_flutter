import 'dart:convert';

import 'package:exercicedevsncf/domain/repositories/forecast_repository.dart';
import 'package:exercicedevsncf/models/forecast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final forecastServiceProvider =
    Provider<ForecastRepository>((ref) => ForecastService());

class ForecastService extends ForecastRepository {
  final String apiId = '7665824cd080c83d6092ac1f96442374';
  final String baseUrl = 'http://api.openweathermap.org/data/2.5';
  final String usersEndpoint = '/users';

  @override
  Future<List<Forecast>?> getForecastFive(double lat, double lon) async {
    try {
      var url = Uri.parse(
          '$baseUrl/forecast?lat=$lat&lon=$lon&appid=$apiId&units=metric');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Forecast> forecast = List<Forecast>.from(
            jsonDecode(response.body)["list"].map((x) => Forecast.fromJson(x)));
        return forecast;
      } else {
        return null;
      }
    } catch (e) {
      throw (e.toString());
    }
  }
}

import 'package:exercicedevsncf/models/forecast.dart';

abstract class ForecastRepository {
  Future<List<Forecast>?> getForecastFive(double lat, double lon);
}

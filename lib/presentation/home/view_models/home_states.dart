import 'package:exercicedevsncf/models/coord.dart';
import 'package:exercicedevsncf/models/forecast.dart';
import 'package:exercicedevsncf/utils/enums.dart';

class HomesStates {
  final StandardStateStatus status;
  final String? error;
  final Map<int, List<Forecast>> forecast;
  final Coord location;
  final bool useUserLocation;

  HomesStates({
    required this.status,
    required this.forecast,
    required this.location,
    required this.useUserLocation,
    this.error,
  });

  factory HomesStates.init() {
    return HomesStates(
        status: StandardStateStatus.init,
        error: null,
        forecast: {},
        useUserLocation: false,
        location: Coord(lat: 0, lon: 0));
  }

  HomesStates copyWith(
      {StandardStateStatus? status,
      String? error,
      Map<int, List<Forecast>>? forecast,
      Coord? location,
      bool? useUserLocation}) {
    return HomesStates(
        status: status ?? this.status,
        error: error ?? this.error,
        forecast: forecast ?? this.forecast,
        location: location ?? this.location,
        useUserLocation: useUserLocation ?? this.useUserLocation);
  }
}

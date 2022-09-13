import 'package:easy_localization/src/public_ext.dart';
import 'package:exercicedevsncf/data/services/forecast/forecast_service.dart';
import 'package:exercicedevsncf/data/services/location/location_service.dart';
import 'package:exercicedevsncf/data/services/share_prefs/login_share_pref_service.dart';
import 'package:exercicedevsncf/domain/repositories/forecast_repository.dart';
import 'package:exercicedevsncf/domain/repositories/location_repository.dart';
import 'package:exercicedevsncf/models/coord.dart';
import 'package:exercicedevsncf/models/forecast.dart';
import 'package:exercicedevsncf/presentation/home/view_models/home_states.dart';
import 'package:exercicedevsncf/providers/authentication_provider.dart';
import 'package:exercicedevsncf/utils/enums.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomesStates>((ref) {
  HomeViewModel vm = HomeViewModel(ref.read(forecastServiceProvider),
      ref.read(locationServiceProvider), ref);
  return vm;
});

class HomeViewModel extends StateNotifier<HomesStates> {
  HomeViewModel(
    this._forecastRepository,
    this._locationRepository,
    this._ref,
  ) : super(HomesStates.init()) {
    getForecastByDay(state.location.lat, state.location.lon);
  }

  final ForecastRepository _forecastRepository;
  final LocationRepository _locationRepository;
  final Ref _ref;

  Map<int, List<Forecast>> mapForecastByDay(List<Forecast> forecast) {
    var lastDay = forecast[0].dtTxt.day;
    Map<int, List<Forecast>> forecastByDay = {};
    for (var element in forecast) {
      if (element.dtTxt.day != lastDay) {
        forecastByDay[element.dtTxt.day] = [element];
        lastDay = element.dtTxt.day;
      } else {
        forecastByDay[element.dtTxt.day]?.add(element);
      }
    }
    return forecastByDay;
  }

  Future<void> getForecastByDay(double lat, double lon,
      {bool forceRefresh = false}) async {
    try {
      if (!forceRefresh) {
        state = state.copyWith(status: StandardStateStatus.loading);
      }
      print('$lat $lon');
      List<Forecast>? forecast =
          await _forecastRepository.getForecastFive(lat, lon);
      if (forecast != null) {
        state = state.copyWith(
            status: StandardStateStatus.ok,
            forecast: mapForecastByDay(forecast));
      } else {
        state = state.copyWith(
            status: StandardStateStatus.error, error: 'problem'.tr());
      }
    } catch (e) {
      print(e);
      state = state.copyWith(
          status: StandardStateStatus.error, error: e.toString());
    }
  }

  Future<void> toggleLocation() async {
    try {
      state = state.copyWith(status: StandardStateStatus.loading);
      if (!state.useUserLocation) {
        state = state.copyWith(useUserLocation: true);
        Coord location = await _locationRepository.getLocation();
        state =
            state.copyWith(location: location, status: StandardStateStatus.ok);
        await getForecastByDay(state.location.lat, state.location.lon);
      } else {
        state = state.copyWith(
            location: Coord(lat: 48.858370, lon: 2.294481),
            useUserLocation: false,
            status: StandardStateStatus.ok);
        await getForecastByDay(state.location.lat, state.location.lon);
      }
    } catch (e) {
      print(e);
      state = state.copyWith(
          status: StandardStateStatus.error, error: e.toString());
    }
  }

  Future<void> logout() async {
    await _ref.read(loginProvider.notifier).setLogin('');
    _ref.read(authenticationProvider.notifier).state = false;
  }
}

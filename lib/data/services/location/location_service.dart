import 'package:easy_localization/easy_localization.dart';
import 'package:exercicedevsncf/domain/repositories/location_repository.dart';
import 'package:exercicedevsncf/models/coord.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';

final locationServiceProvider =
    Provider<LocationRepository>((ref) => LocationService());

class LocationService extends LocationRepository {
  late Coord _currentLocation;
  var location = Location();

  @override
  Future<Coord> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = Coord(
        lat: userLocation.latitude!,
        lon: userLocation.longitude!,
      );
    } on Exception catch (e) {
      throw ('${'location_problem'.tr()}: ${e.toString()}');
    }
    return _currentLocation;
  }
}

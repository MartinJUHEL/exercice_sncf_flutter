import 'package:exercicedevsncf/models/coord.dart';

abstract class LocationRepository {
  Future<Coord> getLocation();
}

import 'package:location/models/location.dart';
import 'package:location/models/locations_data.dart';

class LocationService {
  var _locations;

  LocationService() {
    _locations = LocationsData.buildList();
    print('Apres le constructur du LocationService');
  }

  List<Location> getLocations() {
    return _locations;
  }

// Returns the list of the location
}
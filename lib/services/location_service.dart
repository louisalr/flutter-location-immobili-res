import 'dart:convert';

import 'package:location/models/location.dart';
import 'package:location/models/locations_data.dart';
import 'package:http/http.dart' as http;

class LocationService {
  final LocationApiClient locationApiClient;

  LocationService(): locationApiClient = LocationApiClientImpl();

  Future<List<Location>> getLocations() async{
    List<Location> list = await locationApiClient.getLocations();
    return list;
  }

  Future<Location> getLocation(int id){
    return locationApiClient.getLocation(id);
  }

}

abstract class LocationApiClient{
  Future<List<Location>> getLocations();
  Future<Location> getLocation(int id);
}

class LocationApiData implements LocationApiClient{
  @override
  Future<Location> getLocation(int id) {
    Location location = LocationsData.buildList().where((element) => element.id == id).first;
    return Future.delayed(const Duration(seconds: 1), () => location);
  }

  @override
  Future<List<Location>> getLocations() {
   return Future.delayed(const Duration(seconds: 1), () => LocationsData.buildList());
  }
  
}

class LocationApiClientImpl implements LocationApiClient {

  static Future<List<Location>> fetchLocations() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:9000/api/locations/locations.json'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body) as List;
      return parsed.map((location) => Location.fromJson(location)).toList();
    } else {
      print("Error loading data");
      throw Exception('Failed to load locations');
    }
  }

  @override
  Future<Location> getLocation(int id) {
    // TODO: implement getLocation
    throw UnimplementedError();
  }

  @override
  Future<List<Location>> getLocations() {
    return fetchLocations();
  }
}


import 'dart:async';

import 'package:location/location.dart';
import 'package:shoodar/features/user/domain/entities/user_location.dart';


class LocationService {
  UserLocation _currentLocation;
  var location;

  PermissionStatus _permissionGranted;

  StreamController<UserLocation> _locationController = StreamController<UserLocation>();

   LocationService() {
        location = new Location();
        location.onLocationChanged.listen((LocationData locationData) {
          if(locationData != null) {
            _currentLocation = UserLocation(
                latitude: locationData.latitude,
                longitude: locationData.longitude
            );
            _locationController.add(_currentLocation);
          }
           
        });
  }

  UserLocation get getCurrentLocation => _currentLocation;

  Stream<UserLocation> get locationStream => _locationController.stream;      

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
    return _currentLocation;
  }

  void checkPermissionSatus() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        _permissionGranted = PermissionStatus.denied;
      }
    } 
}

}

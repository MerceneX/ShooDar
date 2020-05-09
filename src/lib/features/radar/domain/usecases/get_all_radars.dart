
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';

import '../../domain/repositories/radar_repository.dart';
import '../../../../core/usecases/usecase.dart';

class GetAllRadars implements UseCase<void, NoParams> {
  final RadarRepository radarRepository;

  GetAllRadars(this.radarRepository);

  @override
  Future<Set<Marker>> call(NoParams params) async {
    List<Radar> radars = await radarRepository.getAllRadars();
    BitmapDescriptor markerPin = await _getCustomMapPin();
    Set<Marker> markers = _transformRadarsToMarkers(radars, markerPin);

    return markers;
  }

  Set<Marker> _transformRadarsToMarkers(List<Radar> radars, BitmapDescriptor markerIcon) {
    Set<Marker> _markers = new Set<Marker>();
    radars.forEach((radar) => {
        _markers.add(Marker(
          markerId: MarkerId(radar.id),
          position: LatLng(radar.latitude, radar.longitude),
          infoWindow: InfoWindow(
            title: 'Created at:',
            snippet: "${transformTimeCreated(radar.timeCreated)} ago",
          ),
          icon: markerIcon
        ))    

      });
      return _markers;
}

Future<BitmapDescriptor> _getCustomMapPin() async {
  BitmapDescriptor pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/icons8-police-car-64.png');
  return pinLocationIcon;
}

String transformTimeCreated(DateTime timeCreated) {
  DateTime now = DateTime.now();
  Duration difference = now.difference(timeCreated);

  String result = "";

  if (difference.inHours == 0 && difference.inMinutes != 0) {
    result = "${difference.inMinutes} min";  
  } else if (difference.inMinutes == 0) {
    result = "less then a minute";
  } else {
    int min = difference.inHours * 60 - difference.inMinutes;
    result = "${difference.inHours} h $min min";
  }
  return result;
}


}

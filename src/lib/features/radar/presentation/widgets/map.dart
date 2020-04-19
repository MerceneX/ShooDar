import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';

class Map extends StatefulWidget {
  static const LatLng _center = const LatLng(46.056946, 14.505751);

  final List<Radar> radars;

  const Map({
      Key key,
      @required this.radars,
    }) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  final Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers,
          initialCameraPosition: CameraPosition(
            target: Map._center,
            zoom: 7.0)
            )
      );
  }

   void _onMapCreated(GoogleMapController controller) {
      _addMarkers();
      _controller.complete(controller);
    
  }

  void _addMarkers() {
    setState(() {
      widget.radars.forEach((radar) => {
      _markers.add(Marker(
        markerId: MarkerId(radar.id),
        position: LatLng(radar.latitude, radar.longitude),
        infoWindow: InfoWindow(
          title: 'Created at:',
          snippet: radar.timeCreated.toString(),
        ),
        icon: BitmapDescriptor.defaultMarker,
      ))    
    });
    });
  }
}




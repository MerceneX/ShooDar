import '../../domain/entitites/radar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RadarDataSource {
  void addRadar(Radar radar);
}

class RadarDataSourceImpl implements RadarDataSource {
  final databaseRef = Firestore.instance;

  @override
  void addRadar(Radar radar) async {
    await databaseRef.collection("radars").add({
          'timeCreated': new DateTime.now(),
          'location': new GeoPoint(radar.latitude, radar.longitude)
    });
  }
}

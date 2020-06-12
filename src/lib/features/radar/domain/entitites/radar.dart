
import 'package:meta/meta.dart';

class Radar {
  final String id;
  final DateTime timeCreated;
  final DateTime timeDeleted;
  final double latitude;
  final double longitude;
  final bool isSeen;
  final String userId;
  final String address;
  final String administrativeArea;
  bool isActive;
  int radarNotPresentCounter;

  Radar({
    @required this.timeCreated,
    @required this.latitude,
    @required this.longitude,
    @required this.userId,
    this.timeDeleted,
    this.id,
    this.isSeen = false,
    this.address,
    this.administrativeArea,
    this.isActive = false,
    this.radarNotPresentCounter = 0

  });

}
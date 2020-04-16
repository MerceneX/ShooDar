
import 'package:meta/meta.dart';

class Radar {
  final String id;
  final DateTime timeCreated;
  final DateTime timeDeleted;
  final double latitude;
  final double longitude;

  Radar({
    @required this.timeCreated,
    @required this.latitude,
    @required this.longitude,
    this.timeDeleted,
    this.id
  });

}
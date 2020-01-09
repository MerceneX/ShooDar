import 'package:equatable/equatable.dart';

abstract class RadarEvent extends Equatable {
  const RadarEvent();
}

class Loading extends RadarEvent {
  @override
  List<Object> get props => null;
}

class AddRadarEvent extends RadarEvent {
  final double lattitude;
  final double longitude;

  AddRadarEvent(this.lattitude, this.longitude);

  @override
  List<Object> get props => null;
}

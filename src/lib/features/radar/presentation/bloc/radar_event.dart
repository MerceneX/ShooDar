import 'package:equatable/equatable.dart';

abstract class RadarEvent extends Equatable {
  const RadarEvent();
}

// class Loading extends RadarEvent {
//   @override
//   List<Object> get props => null;
// }

class AddRadarEvent extends RadarEvent {
  AddRadarEvent();

  @override
  List<Object> get props => null;
}

class GetRadarsEvent extends RadarEvent {
  GetRadarsEvent();

  @override
  List<Object> get props => [];
}

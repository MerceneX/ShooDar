import 'package:equatable/equatable.dart';

abstract class RadarState extends Equatable {
  const RadarState();
}

class InitialRadarState extends RadarState {
  @override
  List<Object> get props => [];
}

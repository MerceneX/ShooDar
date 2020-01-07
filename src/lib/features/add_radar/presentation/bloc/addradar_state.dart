import 'package:equatable/equatable.dart';

abstract class AddradarState extends Equatable {
  const AddradarState();
}

class InitialAddradarState extends AddradarState {
  @override
  List<Object> get props => [];
}

class AddedState extends AddradarState {
  @override
  List<Object> get props => null;
}

class Adding extends AddradarState {
  @override
  List<Object> get props => null;
}

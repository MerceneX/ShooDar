import 'package:equatable/equatable.dart';

abstract class AddradarEvent extends Equatable {
  const AddradarEvent();
}

class NewAddEvent extends AddradarEvent {
  final double lattitude;
  final double longitude;

  NewAddEvent(this.lattitude, this.longitude);

  @override
  List<Object> get props => null;
}

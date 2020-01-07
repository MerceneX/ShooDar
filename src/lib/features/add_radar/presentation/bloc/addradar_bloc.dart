import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class AddradarBloc extends Bloc<AddradarEvent, AddradarState> {
  @override
  AddradarState get initialState => InitialAddradarState();

  @override
  Stream<AddradarState> mapEventToState(
    AddradarEvent event,
  ) async* {
    // TODO: Add Logic
  }
}

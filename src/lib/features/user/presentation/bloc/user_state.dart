import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialUserState extends UserState {}

class Loading extends UserState {}


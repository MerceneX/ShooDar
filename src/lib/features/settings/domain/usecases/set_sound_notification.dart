import 'package:equatable/equatable.dart';
import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/settings/domain/repositories/settings_repository.dart';

class SetSoundNotification implements UseCase<void, BoolParams> {
  final SettingsRepository repository;

  SetSoundNotification(this.repository);

  @override
  Future<void> call(BoolParams params) async {
    return await repository.setSoundNotification(params.onOff);
  }
}

class BoolParams extends Equatable {
  final bool onOff;

  BoolParams({this.onOff});

  @override
  List<Object> get props => [onOff];
}
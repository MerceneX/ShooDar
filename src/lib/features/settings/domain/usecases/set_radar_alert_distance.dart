import 'package:equatable/equatable.dart';
import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/settings/domain/repositories/settings_repository.dart';

class SetRadarAlertDistance implements UseCase<void, Params> {
  final SettingsRepository repository;

  SetRadarAlertDistance(this.repository);

  @override
  Future<void> call(Params params) async {
    return await repository.setRadarAlertDistance(params.meters);
  }
}

class Params extends Equatable {
  final int meters;

  Params({this.meters});

  @override
  List<Object> get props => [meters];
}
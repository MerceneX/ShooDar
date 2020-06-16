import 'package:equatable/equatable.dart';
import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/settings/domain/repositories/settings_repository.dart';

class SetRadarAlertDistance implements UseCase<void, DistanceParams> {
  final SettingsRepository repository;

  SetRadarAlertDistance(this.repository);

  @override
  Future<void> call(DistanceParams params) async {
    return await repository.setRadarAlertDistance(params.meters);
  }
}

class DistanceParams extends Equatable {
  final int meters;

  DistanceParams({this.meters});

  @override
  List<Object> get props => [meters];
}
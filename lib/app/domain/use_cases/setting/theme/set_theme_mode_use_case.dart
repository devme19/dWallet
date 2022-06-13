import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/core/use_case.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';

class SetThemeModeUseCase implements UseCase<bool, Params> {
  final AppRepository? repository;

  SetThemeModeUseCase({this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) {
    return repository!.setThemeMode(params.boolValue!);
  }
}

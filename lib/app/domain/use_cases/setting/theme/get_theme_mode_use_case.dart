import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/core/use_case.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';

class GetThemeModeUseCase implements UseCase<bool, NoParams> {
  final AppRepository? repository;

  GetThemeModeUseCase({this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository!.getThemeMode();
  }
}

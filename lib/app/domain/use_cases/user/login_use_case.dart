import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/use_case.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';

class LoginUseCase implements UseCase<bool, Params> {
  final AppRepository repository;

  LoginUseCase({required this.repository});
  @override
  Future<Either<Failure, bool>> call(Params params) {
    return repository.login(params.body!);
  }
}

import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';
import 'package:dwallet/app/web3/web3dart.dart';

import '../../../core/use_case.dart';

class SendTransactionUseCase implements UseCase<TransactionInformation,Params>{
  final AppRepository? repository;

  SendTransactionUseCase({this.repository});

  @override
  Future<Either<Failure, TransactionInformation>> call(Params params) {
    // TODO: implement call
    return repository!.sendTransaction(params.body!);
  }

}
import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}

class Params {
  final bool? boolValue;
  final String? value;
  final String? title;
  final String? id;
  final Map<String, dynamic>? body;
  final String? contractAddress;
  final String? apiUrl;
  Params({this.value, this.title, this.body, this.boolValue,this.id,this.contractAddress,this.apiUrl});
}

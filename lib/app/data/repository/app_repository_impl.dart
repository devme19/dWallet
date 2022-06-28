import 'package:dio/dio.dart';
import 'package:dwallet/app/core/exception.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/data/data_sources/local/local_data_source.dart';
import 'package:dwallet/app/data/data_sources/remote/client.dart';
import 'package:dwallet/app/data/data_sources/remote/remote_data_source.dart';
import 'package:dwallet/app/data/models/coin_historical_data_model.dart';
import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/data/models/verification_model.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';

import '../../web3/web3dart.dart';

class AppRepositoryImpl implements AppRepository {
  final AppLocalDataSource? localDataSource;
  final AppRemoteDataSource? remoteDataSource;

  AppRepositoryImpl({this.localDataSource, this.remoteDataSource});

  @override
  Future<Either<Failure, bool>> login(Map<String, dynamic> body) async {
    try {
      Response response =
          await remoteDataSource!.post(url: "user/login", body: body);
      if (response.statusCode == 200) {
        return Right(true);
      }
      return Right(false);
      // bool response = await localDataSource!.login(body['userName'],body['passWord']);
    } on ServerException catch (e) {
      return Left(
          ServerFailure(errorCode: e.errorCode, errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, VerificationModel>> verification(
      Map<String, dynamic> body) async {
    try {
      Response response =
          await remoteDataSource!.post(url: "user/verify", body: body);
      VerificationModel verificationModel =
          VerificationModel.fromJson(response.data);
      return Right(verificationModel);
    } on ServerException catch (e) {
      return Left(
          ServerFailure(errorCode: e.errorCode, errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> setThemeMode(bool isDark) async {
    try {
      bool response = localDataSource!.setThemeMode(isDark);
      return Right(response);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> getThemeMode() async {
    try {
      bool response = localDataSource!.getThemeMode();
      return Right(response);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> getLanguage() async {
    try {
      bool response = localDataSource!.getLanguage();
      return Right(response);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> setLanguage(bool isEn) async {
    try {
      bool response = localDataSource!.setLanguage(isEn);
      return Right(response);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  ////////////////////// Private Key ///////////////
  @override
  Future<Either<Failure, String>> getPrivateKey() async{
    try {
      String response = localDataSource!.getPrivateKey();
      return Right(response);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> savePrivateKey(String key) async{
    try {
      bool response = localDataSource!.savePrivateKey(key);
      return Right(response);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CoinModel>>> getTokenInfo(Map<String,dynamic> parameters) async{
    try {
      Response response = await remoteDataSource!.get(url: "simple/price", queryParameters: parameters);
      CoinModel coinModel;
      List<CoinModel> list = [];
      Map<String,dynamic> data = response.data;
      for (var key in data.keys) {
        coinModel = CoinModel.fromJson2(response.data[key]);
        coinModel.name = key;
        list.add(coinModel);
        //print("array_key" + key);

      }

      return Right(list);
    } on ServerException catch (e) {
      return Left(
          ServerFailure(errorCode: e.errorCode, errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, double>> getBalance(String apiUrl) async{
    try {
      String privateKey = localDataSource!.getPrivateKey();
      EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
      EtherAmount balance = await Client().web3(apiUrl).getBalance(credentials.address);
      print(credentials.address);
      print(balance.getValueInUnit(EtherUnit.ether));
      return Right(balance.getValueInUnit(EtherUnit.ether));
  }catch (e) {
      return Left(
          ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> sendTransaction(Map<String,dynamic> body) async{
    try {
      String privateKey = localDataSource!.getPrivateKey();
      String apiUrl = body['apiUrl'];
      String receiveAddress = body['receiveAddress'];
      double amount = body['amount'];
      EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
      String txHash = await Client().web3(apiUrl).sendTransaction(
        credentials,
        Transaction(
          to: EthereumAddress.fromHex(receiveAddress),
          gasPrice: EtherAmount.inWei(BigInt.one),
          maxGas: 100000,
          value: EtherAmount.fromUnitAndValue(EtherUnit.ether, amount),
        ),
      );
      return Right(txHash);
    }catch (e) {
      return Left(
          ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CoinHistoricalDataModel>> getHistoricalData(Map<String, dynamic> parameters) async{
    try {
      String id= parameters['id'];
      Response response = await remoteDataSource!.get(url: "coins/$id/market_chart", queryParameters: parameters);
      return Right(CoinHistoricalDataModel.fromJson(response.data));
    } on ServerException catch (e) {
      return Left(
          ServerFailure(errorCode: e.errorCode, errorMessage: e.errorMessage));
    }
  }
}

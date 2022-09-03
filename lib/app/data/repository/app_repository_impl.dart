import 'dart:ffi';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dwallet/app/core/exception.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/data/data_sources/local/local_data_source.dart';
import 'package:dwallet/app/data/data_sources/remote/client.dart';
import 'package:dwallet/app/data/data_sources/remote/remote_data_source.dart';
import 'package:dwallet/app/data/models/coin_historical_data_model.dart';
import 'package:dwallet/app/data/models/coin_info_model.dart';
import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/data/models/token_model.dart';
import 'package:dwallet/app/data/models/verification_model.dart';
import 'package:dwallet/app/domain/repository/app_repository.dart';
import 'package:dwallet/app/web3/src/token.dart';
import 'package:flutter/services.dart';
import 'dart:math' as Math;
import '../../web3/src/crypto/formatting.dart';
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
  EtherAmount getWeiAmount(int decimal, double amount){
    int decims = amount.toString().split('.')[1].length;
    BigInt bigIntAmount = BigInt.from(int.parse(amount.toString().replaceAll('.', '')));
    BigInt bigInt = bigIntAmount * BigInt.from(Math.pow(10, decimal - decims));
    print(bigInt);
    print(EtherAmount.inWei(bigInt));
    return EtherAmount.inWei(bigInt);
  }
  @override
  Future<Either<Failure, TransactionInformation>> sendTransaction(Map<String,dynamic> body) async{
    try {
      int retryCount = 0;
      String txHash='';
      String? contractAddress;
      String privateKey = localDataSource!.getPrivateKey();
      String apiUrl = body['apiUrl'];
      int decimal = body['decimal'];
      // String chainId = body['chainId'];
      String receiveAddress = body['receiveAddress'];
      if(body['contractAddress'] != null) {
        contractAddress = body['contractAddress'];
      }
      String sendAddress = localDataSource!.getEthereumAddress();
      double amount = body['amount'];
      // print(bigIntAmount);
      EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
      // var s = EtherAmount.inWei(bigIntAmount);
      // print(s);
      EtherAmount gas =await Client().web3(apiUrl).getGasPrice();
      // int gas1 =await Client().web3(apiUrl).estimateGas(sender: EthereumAddress.fromHex(sendAddress),to: );
      BigInt bigIntChainId = await Client().web3(apiUrl).getChainId();
      int chainId = int.parse(bigIntChainId.toString());
     print('gas $gas');
     if(contractAddress != null){
       String abiCode = await rootBundle.loadString('assets/files/erc20.abi.json');
       final contract = DeployedContract(ContractAbi.fromJson(abiCode, 'MetaCoin'), EthereumAddress.fromHex(contractAddress));
       final transfer = contract.function('transfer');
       await Client().web3(apiUrl).sendTransaction(
         credentials,
         chainId:chainId,
         Transaction.callContract(
           contract: contract,
           function: transfer,
           // gasPrice: gas,
           // // from: EthereumAddress.fromHex(sendAddress),
           // maxGas: 100000,
           // value: getWeiAmount(decimal, amount),
           parameters: [EthereumAddress.fromHex(receiveAddress), BigInt.parse((amount*Math.pow(10, 18)).round().toString())],
         ),
       );
     }
    else
      {
        txHash = await Client().web3(apiUrl).sendTransaction(
              chainId: chainId,
              credentials,
              Transaction(
                from: EthereumAddress.fromHex(sendAddress),
                to: EthereumAddress.fromHex(receiveAddress),
                gasPrice: gas,
                maxGas: 100000,
                value: getWeiAmount(decimal, amount),
              ),
            );
      }
      TransactionInformation transaction =
      await Client().web3(apiUrl).getTransactionByHash(txHash);
      print(transaction);

      return Right(transaction);
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

  @override
  Future<Either<Failure, String>> getTokenName(String contractAddress,String apiUrl) async{
    try {
      final EthereumAddress cAddress = EthereumAddress.fromHex(contractAddress);
      print(contractAddress.length);
      String abiCode = await rootBundle.loadString('assets/files/erc20.abi.json');
      final contract = DeployedContract(ContractAbi.fromJson(abiCode, 'MetaCoin'), cAddress);
      final nameFunction = contract.function('name');
      final tokenName = await Client().web3(apiUrl).call(contract: contract, function: nameFunction,params: []);
      print(tokenName);
      return Right(tokenName[0]);
    }catch (e) {
      return Left(
          ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getTokenSymbol(String contractAddress, String apiUrl) async{
    try {
      final EthereumAddress cAddress = EthereumAddress.fromHex(contractAddress);
      String abiCode = await rootBundle.loadString('assets/files/erc20.abi.json');
      final contract = DeployedContract(ContractAbi.fromJson(abiCode, 'MetaCoin'), cAddress);
      final symbolFunction = contract.function('symbol');
      final tokenSymbol = await Client().web3(apiUrl).call(contract: contract, function: symbolFunction,params: []);
      print(tokenSymbol);
      return Right(tokenSymbol[0]);
    }catch (e) {
      return Left(
          ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getTokenDecimal(String contractAddress, String apiUrl) async{
    try {
      final EthereumAddress cAddress = EthereumAddress.fromHex(contractAddress);
      String abiCode = await rootBundle.loadString('assets/files/erc20.abi.json');
      final contract = DeployedContract(ContractAbi.fromJson(abiCode, 'MetaCoin'), cAddress);
      final symbolFunction = contract.function('decimals');
      final tokenDecimal = await Client().web3(apiUrl).call(contract: contract, function: symbolFunction,params: []);
      print(tokenDecimal);
      return Right(tokenDecimal[0].toString());
    }catch (e) {
      return Left(
          ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TokenModel>> getTokenInfoByContractAddress(String contractAddress, String assetPlatform) async{
    try {
      Response response = await remoteDataSource!.get(url: "coins/$assetPlatform/contract/$contractAddress",queryParameters:{});
      TokenModel tokenModel = TokenModel.fromJson(response.data);
      Map<String,dynamic> data = response.data;


      return Right(tokenModel);
    } on ServerException catch (e) {
      return Left(
          ServerFailure(errorCode: e.errorCode, errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, BigInt>> getTokenBalance(String contractAddress, String apiUrl) async{
    try {
      Either response = await getEthAddress();
      if(response.isRight){

      }else if(response.isLeft){

      }
      final EthereumAddress ethAddress = EthereumAddress.fromHex(response.right);
      String abiCode = await rootBundle.loadString('assets/files/erc20.abi.json');
      // Token token = Token(address: cAddress,client: Client().web3(apiUrl));
      // final sq = await token.getBalance(cAddress);
      final contract = DeployedContract(ContractAbi.fromJson(abiCode, 'MetaCoin'), EthereumAddress.fromHex(contractAddress));
      final balanceFunction = contract.function('balanceOf');
      final balance = await Client().web3(apiUrl).call(contract: contract, function: balanceFunction,params: [
        ethAddress
      ]);
      return Right(balance[0]);
    }catch (e) {
      return Left(
          ServerFailure(errorMessage: e.toString()));
    }
  }
  @override
  Future<Either<Failure, String>> getEthAddress() async{
    try {
      String response = localDataSource!.getEthereumAddress();
      return Right(response);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> saveEthAddress(String address) async{
    try {
      bool response = localDataSource!.saveEthereumAddress(address);
      return Right(response);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CoinModel>>> getCoinsFromLocal()async {
    try {
      var response = localDataSource!.getCoins();
      return Right(response);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> saveCoinsToLocal(String coins) async{
    try {
      var response = localDataSource!.saveCoins(coins);
      return Right(response);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CoinInfoModel>> getTokenMarketInfo(Map<String,dynamic> parameters,String id) async{
    try {
      Response response = await remoteDataSource!.get(url: 'coins/$id',queryParameters: parameters);
      CoinInfoModel coinInfo = CoinInfoModel.fromJson(response.data);
      return Right(coinInfo);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, EtherAmount>> getGas(String url) async{
    try {
      EtherAmount gas =await Client().web3(url).getGasPrice();
      return Right(gas);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

}

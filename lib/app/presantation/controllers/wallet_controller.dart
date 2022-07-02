import 'dart:io';

import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/use_case.dart';
import 'package:dwallet/app/data/data_sources/remote/client.dart';
import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/domain/use_cases/home/get_balance_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_coins_info_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_eth_address_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_historical_data_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_token_balance_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_token_decimal_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_token_info_by_contract_address_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_token_name_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_token_symbol_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/send_transaction_usecase.dart';
import 'package:dwallet/app/domain/use_cases/private_key/get_private_key_usecase.dart';
import 'package:dwallet/app/domain/use_cases/private_key/save_private_key_usecase.dart';
import 'package:dwallet/app/presantation/pages/secret_phrase_page/widget/secret_phrase_item_widget.dart';
import 'package:dwallet/app/presantation/routes/app_routes.dart';
import 'package:dwallet/app/presantation/utils/state_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/use_cases/home/save_eth_address_usecase.dart';
import '../../web3/src/crypto/formatting.dart';
import '../../web3/web3dart.dart';

class WalletController extends GetxController{
  RxList secretPhraseList=[].obs;
  RxList shuffledSecretPhraseList=[].obs;
  RxList selectedPhrasesList=[].obs;
  RxList selectedPhrasesItems=[].obs;
  RxList phraseItems=[].obs;
  Wallet? wallet;
  RxString secretPhrase="".obs;
  RxBool isWrong = false.obs;
  String? privateKey;
  bool searchVisibility = false;
  RxBool visibility = true.obs;
  RxBool isLoading = false.obs;
  StateStatus getCoinsInfoStatus = StateStatus.INITIAL;
  double totalBalance = 0.0;
  List<CoinModel> coins=[];
  RxString network = 'Ethereum'.obs;
  RxString tokenName = "".obs;
  RxString tokenSymbol = "".obs;
  RxString tokenDecimal = "".obs;

  TextEditingController contractAddressController = TextEditingController();
  TextEditingController tokenNameController = TextEditingController();
  TextEditingController tokenSymbolController = TextEditingController();
  TextEditingController tokenDecimalController = TextEditingController();

  visibleSearchBar(){
    searchVisibility = true;
    update();
  }
  invisibleSearchBar(){
    searchVisibility = false;
    update();
  }
  getHistoricalData({CoinModel? coin,String? id,String? currency,int? days,String? interval}){
    GetHistoricalDataUseCase getHistoricalDataUseCase = Get.find();
    Map<String,dynamic> parameters={
      'vs_currency':currency,
      'days':days,
      'interval':interval,
      'id':id,
    };
    getHistoricalDataUseCase.call(Params(body: parameters)).then((response){
      if(response.isRight){
        // final List<charts.Series<dynamic, num>> seriesList;
        // charts.Series<response.right.prices, int>(
        //   id: 'Sales',
        //   colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        //   domainFn: (LinearSales sales, _) => sales.year,
        //   measureFn: (LinearSales sales, _) => sales.sales,
        //   data: data,
        // )
        coin!.historicalData = response.right;
        update();
      }else if(response.isLeft){

      }
    });
  }
  onNetworkChange(String net){
    network.value = net;
  }
  getTokenInfoByContractAddress(String contractAddress){
    String? assetPlatform;
    switch(network.value){
      case "Ethereum":
        assetPlatform = "ethereum";
        break;
      case "Polygan":
        assetPlatform = "polygon-pos";
        break;
      case "BNB Smart Chain":
        assetPlatform = "binance-smart-chain";
        break;
      case "Fantom":
        assetPlatform = "fantom";
        break;
    }
    Map<String,dynamic> parameters = {
      'contract_addresses':contractAddress,
      'vs_currencies':'usd',
      'include_market_cap':true,
      'include_24hr_vol':true,
      'include_24hr_change':true,
      'include_last_updated_at':true
    };
    GetTokenInfoByContractAddressUseCase getTokenInfoByContractAddress = Get.find();
    getTokenInfoByContractAddress.call(Params(body: parameters,assetPlatform: assetPlatform!)).then((response) {
      if(response.isRight){
        getTokenBalance(contractAddress);

      }else if(response.isLeft){

      }
    });
  }
  getTokenBalance(String contractAddress){
    String? apiUrl;
    switch(network.value){
      case "Ethereum":
        apiUrl = "https://eth-mainnet.nodereal.io/v1/1659dfb40aa24bbb8153a677b98064d7";
        break;
      case "Polygan":
        apiUrl = "https://rpc-mainnet.matic.quiknode.pro";
        break;
      case "BNB Smart Chain":
        apiUrl = "https://binance.nodereal.io";
        break;
      case "Fantom":
        apiUrl = "https://rpcapi.fantom.network";
        break;
    }

    GetTokenBalanceUseCase getTokenBalanceUseCase = Get.find();
    getTokenBalanceUseCase.call(Params(
      contractAddress: contractAddress,
      apiUrl: apiUrl
    )).then((response) {
      if(response.isRight){
        Get.snackbar("Result", getValueInUnit(response.right, int.parse(tokenDecimal.value)).toString());
      }else if(response.isLeft){

      }
    });
  }
  getTokenName(String contractAddress){
    String? apiUrl;
    switch(network.value){
      case "Ethereum":
        apiUrl = "https://eth-mainnet.nodereal.io/v1/1659dfb40aa24bbb8153a677b98064d7";
        break;
      case "Polygan":
        apiUrl = "https://rpc-mainnet.matic.quiknode.pro";
        break;
      case "BNB Smart Chain":
        apiUrl = "https://binance.nodereal.io";
        break;
      case "Fantom":
        apiUrl = "https://rpcapi.fantom.network";
        break;
    }
    GetTokenNameUseCase getTokenNameUseCase = Get.find();
    getTokenNameUseCase.call(Params(apiUrl: apiUrl,contractAddress: contractAddress)).then((response) {
      if(response.isRight){
        print(response.right);
        tokenName.value = response.right;
        tokenNameController.text = response.right;
      }else if(response.isLeft){

      }
    });
  }
  getTokenSymbol(String contractAddress){
    String? apiUrl;
    switch(network.value){
      case "Ethereum":
        apiUrl = "https://eth-mainnet.nodereal.io/v1/1659dfb40aa24bbb8153a677b98064d7";
        break;
      case "Polygan":
        apiUrl = "https://rpc-mainnet.matic.quiknode.pro";
        break;
      case "BNB Smart Chain":
        apiUrl = "https://binance.nodereal.io";
        break;
      case "Fantom":
        apiUrl = "https://rpcapi.fantom.network";
        break;
    }
    GetTokenSymbolUseCase getTokenSymbolUseCase = Get.find();
    getTokenSymbolUseCase.call(Params(apiUrl: apiUrl,contractAddress: contractAddress)).then((response) {
      if(response.isRight){
        print(response.right);
        tokenSymbol.value = response.right;
        tokenSymbolController.text = response.right;
      }else if(response.isLeft){

      }
    });
  }
  getTokenDecimal(String contractAddress){
    String? apiUrl;
    switch(network.value){
      case "Ethereum":
        apiUrl = "https://eth-mainnet.nodereal.io/v1/1659dfb40aa24bbb8153a677b98064d7";
        break;
      case "Polygan":
        apiUrl = "https://rpc-mainnet.matic.quiknode.pro";
        break;
      case "BNB Smart Chain":
        apiUrl = "https://binance.nodereal.io";
        break;
      case "Fantom":
        apiUrl = "https://rpcapi.fantom.network";
        break;
    }
    GetTokenDecimalUseCase getTokenDecimalUseCase = Get.find();
    getTokenDecimalUseCase.call(Params(apiUrl: apiUrl,contractAddress: contractAddress)).then((response) {
      if(response.isRight){
        print(response.right);
        tokenDecimal.value = response.right;
        tokenDecimalController.text = response.right;
      }else if(response.isLeft){

      }
    });
  }
  getDefaultCoins(){
    coins.add(CoinModel(name: 'Ethereum',symbol: 'ETH',chainId: '18',coingeckoId: 'ethereum',imageUrl: 'https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880',jrpcApi: [
      'https://rinkeby.infura.io/v3/c8694e395984403b99cdef8e8182da43',
      'wss://rinkeby.infura.io/ws/v3/c8694e395984403b99cdef8e8182da43',
      'https://ropsten.infura.io/v3/c8694e395984403b99cdef8e8182da43',
      'wss://ropsten.infura.io/ws/v3/c8694e395984403b99cdef8e8182da43'
    ]));
    coins.add(CoinModel(name: 'BNB Smart Chain',symbol: 'BNB',chainId: '97',coingeckoId: 'binance-smart-chain',imageUrl: 'https://assets.coingecko.com/coins/images/17271/large/icon_200px_16bit.png',jrpcApi: [
      'https://data-seed-prebsc-1-s2.binance.org:8545',
      'https://data-seed-prebsc-2-s2.binance.org:8545',
      'https://data-seed-prebsc-2-s3.binance.org:8545'
    ]));
    coins.add(CoinModel(name: 'Polygon',symbol: 'MATIC',chainId: '80001',coingeckoId: 'matic-network',imageUrl: 'https://assets.coingecko.com/coins/images/4713/large/matic-token-icon.png',jrpcApi: [
      'https://matic-mumbai.chainstacklabs.com',
      'https://matic-testnet-archive-rpc.bwarelabs.com',
      'https://rpc-mumbai.maticvigil.com',
    ]));
    coins.add(CoinModel(name: 'Fantom',symbol: 'FTM',chainId: '4002',coingeckoId: 'fantom',imageUrl: 'https://assets.coingecko.com/coins/images/4001/large/Fantom.png?1558015016',jrpcApi: [
      'https://rpc.testnet.fantom.network'
    ]));
  }
  createNewWallet()async{
    secretPhraseList.clear();
    shuffledSecretPhraseList.clear();
    secretPhrase.value = bip39.generateMnemonic();
    secretPhraseList.addAll(secretPhrase.split(' '));
    shuffledSecretPhraseList.addAll(secretPhraseList);
    shuffledSecretPhraseList.shuffle();
    createPhraseItems(secretPhraseList);
    wallet= await compute(Wallet.fromMnemonic,secretPhrase.value);
    savePrivateKey();
    saveEthereumAddress();

  }
  double getValueInUnit(BigInt value,int decimal) {
    final factor = BigInt.from(10).pow(decimal);
    final result = value ~/ factor;
    final remainder = value.remainder(factor);

    return result.toInt() + (remainder.toInt() / factor.toInt());
  }
  importWallet(String secretPhrase)async{
    try{
      wallet= await compute(Wallet.fromMnemonic,secretPhrase);
      Get.offAllNamed(AppRoutes.homePage);
    }catch (e) {
      print("error");

    }
    savePrivateKey();
    saveEthereumAddress();
  }
   Future<double> getBalance(String url)async{
     GetBalanceUseCase getBalanceUseCase  = Get.find();
     Either response= await getBalanceUseCase.call(Params(value: url));
     if(response.isRight){
        return response.right;
     }
     return 0;
  }

  add(SecretItem item){
    selectedPhrasesList.add(item.title!);
  }
  remove(SecretItem item){
    selectedPhrasesList.remove(item.title!);
  }
  createPhraseItems(var secretPhraseList,
      {ValueChanged<SecretItem>? add, ValueChanged<SecretItem>? remove}){
    phraseItems.clear();
    List<Widget> widgets=[];
    List<Widget> rows=[];
    for(int i=0; i<secretPhraseList.length;i++){
      if(i==0)
      {
        widgets.add(SecretPhraseItemWidget(secretItem: SecretItem(index: i+1,title: secretPhraseList[i]),add: add,remove: remove,));
      }
      else
      if((i)%3 != 0) {
        widgets.add(SecretPhraseItemWidget(secretItem: SecretItem(index: i+1,title: secretPhraseList[i]),add: add,remove: remove));
      }
      else{
        rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...widgets],));
        widgets = [];
        widgets.add(SecretPhraseItemWidget(secretItem: SecretItem(index: i+1,title: secretPhraseList[i]),add: add,remove: remove));
      }

    }
    if(secretPhraseList.length > 0){
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [...widgets],));
      phraseItems.addAll(rows);
    }

  }
  getCoinsInfo() async{
    totalBalance = 0;
    Map<String,dynamic> parameters = {
      'ids':'matic-network,fantom,ethereum,binancecoin',
      'vs_currencies':'usd',
      'include_market_cap':true,
      'include_24hr_vol':true,
      'include_24hr_change':true,
      'include_last_updated_at':true
    };
    GetCoinInfoUseCase getCoinsInfoUseCase  = Get.find();
    getCoinsInfoStatus = StateStatus.LOADING;
    update();
    getCoinsInfoUseCase.call(Params(body: parameters)).then((response) {
      if(response.isRight){
        getCoinsInfoStatus = StateStatus.SUCCESS;
        for(CoinModel coin in response.right){

          switch (coin.name){
            case 'ethereum':
              coin.name = 'Ethereum';
              coin.network = 'Ethereum';
              coin.symbol= 'ETH';
              coin.coingeckoId= 'ethereum';
              coin.chainId= '4002';

              coin.jrpcApi = [
                'https://ropsten.infura.io/v3/c8694e395984403b99cdef8e8182da43',
                'wss://ropsten.infura.io/ws/v3/c8694e395984403b99cdef8e8182da43',
                'https://rinkeby.infura.io/v3/c8694e395984403b99cdef8e8182da43',
                'wss://rinkeby.infura.io/ws/v3/c8694e395984403b99cdef8e8182da43',

              ];
              coin.imageUrl = 'https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880';
              getBalance(coin.jrpcApi![0]).then((balance) {
                coin.balance = balance;
                totalBalance += (coin.usd! * coin.balance!);
                update();
              });
              break;
            case 'binancecoin':
              coin.name = 'BNB';
              coin.symbol= 'BNB';
              coin.coingeckoId= 'binancecoin';
              coin.chainId= '97';
              coin.network = 'BNB Smart Chain';
              coin.jrpcApi = [
                'https://data-seed-prebsc-1-s2.binance.org:8545',
                'https://data-seed-prebsc-2-s2.binance.org:8545',
                'https://data-seed-prebsc-2-s3.binance.org:8545'];
              coin.imageUrl = 'https://assets.coingecko.com/coins/images/17271/large/icon_200px_16bit.png';
              getBalance(coin.jrpcApi![0]).then((balance) {
                coin.balance = balance;
                print("BNB Price ${coin.usd!}");
                totalBalance += (coin.usd! * coin.balance!);
                update();
              });
              break;
            case 'fantom':
              coin.name = 'Fantom';
              coin.symbol= 'FTM';
              coin.network = 'Fantom';
              coin.coingeckoId= 'fantom';
              coin.chainId= '4002';
              coin.jrpcApi = [
                'https://rpc.testnet.fantom.network'];
              coin.imageUrl = 'https://assets.coingecko.com/coins/images/4001/large/Fantom.png?1558015016';
              getBalance(coin.jrpcApi![0]).then((balance) {
                coin.balance = balance;
                totalBalance += (coin.usd! * coin.balance!);
                update();
              });
              break;
            case 'matic-network':
              coin.name = 'Matic';
              coin.symbol= 'MATIC';
              coin.network = 'Polygan';
              coin.coingeckoId= 'matic-network';
              coin.chainId= '80001';
              coin.jrpcApi = [
                'https://matic-testnet-archive-rpc.bwarelabs.com',
                'https://rpc-mumbai.maticvigil.com',
                'https://matic-mumbai.chainstacklabs.com',

              ];
              coin.imageUrl = 'https://assets.coingecko.com/coins/images/4713/large/matic-token-icon.png';
              getBalance(coin.jrpcApi![0]).then((balance) {
                coin.balance = balance;
                totalBalance += (coin.usd! * coin.balance!);
                update();
              });
              break;

          }
          getHistoricalData(coin: coin,id: coin.coingeckoId,currency: 'usd',days: 256,interval: 'daily');
        }
        coins.clear();
        coins.addAll(response.right);
      }else if(response.isLeft){
        getCoinsInfoStatus = StateStatus.ERROR;
      }
      update();
    });
  }
  List<Widget> createSelectedPhraseItems(var secretPhraseList){
    selectedPhrasesItems.clear();
    List<Widget> widgets=[];
    List<Widget> rows=[];
    for(int i=0; i<secretPhraseList.length;i++){
      if(i==0)
      {
        widgets.add(SecretPhraseItemWidget(secretItem: SecretItem(index: i+1,title: secretPhraseList[i])));
      }
      else
      if((i)%3 != 0) {
        widgets.add(SecretPhraseItemWidget(secretItem: SecretItem(index: i+1,title: secretPhraseList[i])));
      }
      else{
        rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...widgets],));
        widgets = [];
        widgets.add(SecretPhraseItemWidget(secretItem: SecretItem(index: i+1,title: secretPhraseList[i])));
      }

    }
    if(secretPhraseList.length > 0){
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [...widgets],));
      selectedPhrasesItems.addAll(rows);
    }
    return rows;
  }
  savePrivateKey(){
    SavePrivateKeyUseCase savePrivateKeyUseCase = Get.find();
    savePrivateKeyUseCase.call(Params(value: bytesToHex(wallet!.privateKey.privateKey))).then((response){
      if(response.isRight){
        getPrivateKey();
      }else if(response.isLeft){

      }
    });
  }
  saveEthereumAddress()async{
    EthereumAddress ethAddress = await wallet!.privateKey.extractAddress();
    SaveEthAddressUseCase saveEthAddress = Get.find();
    saveEthAddress.call(Params(contractAddress: ethAddress.toString())).then((response){
      if(response.isRight){
        getPrivateKey();
      }else if(response.isLeft){

      }
    });
  }
  Future<String> getEthereumAddress()async{
    GetEthAddressUseCase getEthAddress = Get.find();
    Either response = await getEthAddress.call(NoParams());
    if(response.isRight){
      return response.right;
    }else if(response.isLeft){
      return "";
    }
    return "";
  }
  getPrivateKey(){
    GetPrivateKeyUseCase getPrivateKeyUseCase = Get.find();
    getPrivateKeyUseCase.call(NoParams()).then((response){
      if(response.isRight){
        privateKey = response.right;
      }else if(response.isLeft){
        return "";
      }
    });
  }

  bool verifySecretPhrase(){
    String selectedPhrase = selectedPhrasesList.join(" ");
    String secretPhrase = secretPhraseList.join(" ");
    print(secretPhrase);
    if(secretPhrase == selectedPhrase) {
      isWrong.value = false;
      return true;
    }
    else{
      isWrong.value = true;
    }
    return false;
  }

  sendTransaction({String? receiveAddress, double? amount, String? apiUrl}){
   SendTransactionUseCase sendTransaction = Get.find();
   Map<String,dynamic> body = {
     'receiveAddress':receiveAddress,
     'amount':amount,
     'apiUrl':apiUrl
   };
   sendTransaction.call(Params(body: body)).then((response){
     if(response.isRight){
       print('TxHash ${response.right}');
     }else if(response.isLeft){

     }
   });

  }

}
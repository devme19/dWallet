import 'dart:typed_data';

import 'package:dwallet/app/core/use_case.dart';
import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/domain/use_cases/home/get_coins_info_usecase.dart';
import 'package:dwallet/app/domain/use_cases/private_key/get_private_key_usecase.dart';
import 'package:dwallet/app/domain/use_cases/private_key/save_private_key_usecase.dart';
import 'package:dwallet/app/presantation/pages/secret_phrase_page/widget/secret_phrase_item_widget.dart';
import 'package:dwallet/app/presantation/routes/app_routes.dart';
import 'package:dwallet/app/presantation/utils/state_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:http/http.dart';

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

  @override
  void onInit() {
    super.onInit();
    getCoinsInfo();
  }
  visibleSearchBar(){
    searchVisibility = true;
    update();
  }
  invisibleSearchBar(){
    searchVisibility = false;
    update();
  }
  getCoinsInfo() {
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
              coin.symbol= 'ETH';
              coin.coingeckoId= 'ethereum';
              coin.chainId= '4002';

              coin.jrpcApi = [
                'https://rinkeby.infura.io/v3/c8694e395984403b99cdef8e8182da43',
                'wss://rinkeby.infura.io/ws/v3/c8694e395984403b99cdef8e8182da43',
                'https://ropsten.infura.io/v3/c8694e395984403b99cdef8e8182da43',
                'wss://ropsten.infura.io/ws/v3/c8694e395984403b99cdef8e8182da43'];
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
              coin.coingeckoId= 'matic-network';
              coin.chainId= '80001';
              coin.jrpcApi = [
                'https://matic-mumbai.chainstacklabs.com',
                'https://matic-testnet-archive-rpc.bwarelabs.com',
                'https://rpc-mumbai.maticvigil.com'];
              coin.imageUrl = 'https://assets.coingecko.com/coins/images/4713/large/matic-token-icon.png';
              getBalance(coin.jrpcApi![0]).then((balance) {
                coin.balance = balance;
                totalBalance += (coin.usd! * coin.balance!);
                update();
              });
              break;
          }
        }
        coins.clear();
        coins.addAll(response.right);
      }else if(response.isLeft){
        getCoinsInfoStatus = StateStatus.ERROR;
      }
      update();
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
  }
  importWallet(String secretPhrase)async{
    try{
      wallet= await compute(Wallet.fromMnemonic,secretPhrase);
      Get.offAllNamed(AppRoutes.homePage);
    }catch (e) {
      print("error");

    }
    savePrivateKey();
  }
   Future<double> getBalance(String url)async{
    // var apiUrl = "https://data-seed-prebsc-1-s3.binance.org:8545"; //Replace with your API
     await getPrivateKey();
     var httpClient = Client();
    var ethClient = Web3Client(url, httpClient);
    var credentials = EthPrivateKey.fromHex(privateKey!);
    EtherAmount balance = await ethClient.getBalance(credentials.address);
    print(credentials.address);
    print(balance.getValueInUnit(EtherUnit.ether));
    return balance.getValueInUnit(EtherUnit.ether);
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


}
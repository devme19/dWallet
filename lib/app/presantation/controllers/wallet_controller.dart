import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/core/use_case.dart';
import 'package:dwallet/app/data/models/coin_historical_data_model.dart';
import 'package:dwallet/app/data/models/coin_info_model.dart';
import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/data/models/network_model.dart';
import 'package:dwallet/app/data/models/token_model.dart';
import 'package:dwallet/app/data/models/transaction_date_model.dart';
import 'package:dwallet/app/data/models/transaction_model.dart';
import 'package:dwallet/app/domain/use_cases/home/get_balance_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_coins_from_local_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_coins_info_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_eth_address_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_gas_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_historical_data_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_token_balance_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_token_decimal_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_token_info_by_contract_address_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_token_market_info.dart';
import 'package:dwallet/app/domain/use_cases/home/get_token_name_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/get_token_symbol_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/save_coin_to_local_usecase.dart';
import 'package:dwallet/app/domain/use_cases/home/send_transaction_usecase.dart';
import 'package:dwallet/app/domain/use_cases/private_key/get_private_key_usecase.dart';
import 'package:dwallet/app/domain/use_cases/private_key/save_private_key_usecase.dart';
import 'package:dwallet/app/presantation/pages/coin_page/widgets/transaction_widget_item.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/success_dialog.dart';
import 'package:dwallet/app/presantation/pages/secret_phrase_page/widget/secret_phrase_item_widget.dart';
import 'package:dwallet/app/presantation/routes/app_routes.dart';
import 'package:dwallet/app/presantation/utils/state_status.dart';
import 'package:dwallet/app/web3/src/token.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:intl/intl.dart';
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
  List<CoinModel> filteredCoins=[];
  RxString tokenName = "".obs;
  RxString tokenSymbol = "".obs;
  RxString tokenDecimal = "".obs;
  List<NetworkModel> networks=[];
  TextEditingController contractAddressController = TextEditingController();
  TextEditingController tokenNameController = TextEditingController();
  TextEditingController tokenSymbolController = TextEditingController();
  TextEditingController tokenDecimalController = TextEditingController();
  NetworkModel? selectedNetwork;
  CoinModel? tokenToAdd;
  RxString usdValue = "".obs;
  RxInt chartInterval = 0.obs;
  Rx<CoinInfoModel> coinInfo = CoinInfoModel().obs;
  CoinHistoricalDataModel coinHistoricalData = CoinHistoricalDataModel();
  RxString ethAddress = ''.obs;
  RxList transactions=[].obs;
  int retryCount=0;
  RxString gas = ''.obs;
  CoinModel selectedCoin =CoinModel();
  @override
  void onInit() {
    super.onInit();
    createNetworksList();
  }
  searchCoin(String searchTerm) {
    filteredCoins =getEnabledCoins(coins)
        .where(
            (element) =>
            element.name!.toLowerCase().contains(searchTerm))
        .toList();
    update();
  }
  clearSearch(){
    invisibleSearchBar();
    filteredCoins = getEnabledCoins(coins);
    update();
  }
  createNetworksList(){
    networks.clear();
    networks.add(NetworkModel(name: "Ethereum",apiUrls: [
      'https://kovan.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161',
      'https://goerli.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161',
      'https://ethereumnodelight.app.runonflux.io',
      'https://eth-rpc.gateway.pokt.network',
      'https://main-rpc.linkpool.io',
    ],
        assetPlatform: "ethereum",
        imageUrl: 'https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880'
    ));
    networks.add(NetworkModel(name: "BNB Smart Chain",apiUrls: [
      'https://bscrpc.com',
      'wss://bsc-mainnet.nodereal.io/ws/v1/64a9df0874fb4a93b9d0a3849de012d3',
      'https://bsc-dataseed3.defibit.io'
    ],
        assetPlatform: "binance-smart-chain",
        imageUrl: 'https://assets.coingecko.com/coins/images/825/large/bnb-icon2_2x.png'
    ));
    networks.add(NetworkModel(name: "Polygan",apiUrls: [
      'https://rpc-mainnet.matic.quiknode.pro',
      'https://poly-rpc.gateway.pokt.network',
      'https://matic-mainnet-full-rpc.bwarelabs.com',
    ],
        assetPlatform: "polygon-pos",
        imageUrl: 'https://assets.coingecko.com/coins/images/4713/large/matic-token-icon.png'
    ));

    networks.add(NetworkModel(name: "Fantom",apiUrls: [
      'https://rpc2.fantom.network'
    ],
        assetPlatform: "fantom",
        imageUrl: 'https://assets.coingecko.com/coins/images/4001/large/Fantom.png?1558015016'
    ));
    selectedNetwork = networks[0];
  }
  visibleSearchBar(){
    searchVisibility = true;
    update();
  }
  invisibleSearchBar(){
    searchVisibility = false;
    update();
  }
  getHistoricalData({CoinModel? coin,String? id,String? currency,int? days,String? interval}){
    coinHistoricalData = CoinHistoricalDataModel();
    update();
    GetHistoricalDataUseCase getHistoricalDataUseCase = Get.find();
    Map<String,dynamic> parameters={
      'vs_currency':currency,
      'days':days,
      'interval':interval,
      'id':id,
    };
    getHistoricalDataUseCase.call(Params(body: parameters)).then((response){
      if(response.isRight){
        coin!.historicalData = response.right;
        List<Point> points=[];
        for (int i = 0; i < coin.historicalData!.prices!.length; i++) {
          points.add(Point(date: i+1, price: coin.historicalData!.prices![i][1]));
        }
        coinHistoricalData.points.addAll(points);
        coin.historicalData!.points.clear();
        coin.historicalData!.points.addAll(points);
        update();
      }else if(response.isLeft){

      }
    });
  }
  onNetworkChange(NetworkModel net){
    selectedNetwork = net;
    contractAddressController.clear();
    tokenNameController.clear();
    tokenSymbolController.clear();
    tokenDecimalController.clear();
    update();
  }
  saveCoins(){
    SaveCoinsToLocalUseCase saveCoinsToLocal = Get.find();
    String coinsStr = CoinModel.encode(coins);
    saveCoinsToLocal.call(Params(value: coinsStr)).then((response) {
      if(response.isRight){

      }else if(response.isLeft){

      }
    });
  }
  List<CoinModel> getEnabledCoins(List<CoinModel> coins){
    return coins.where((element) => element.enable!).toList();
  }
  loadCoins(){
    totalBalance = 0;
    update();
    GetCoinsFromLocalUseCase loadCoins = Get.find();
    loadCoins.call(NoParams()).then((response) {
      if(response.isRight){
        coins.clear();
        coins.addAll(response.right);
        filteredCoins.clear();
        filteredCoins.addAll(getEnabledCoins(coins));
        String ids ='';
        for(CoinModel coin in filteredCoins){
          ids += '${coin.coingeckoId!},';
          if(coin.coingeckoId == ""){
            getTokenBalance(coin.contractAddress!, coin, coin.jrpcApi![0]);
          }
        }
        ids= ids.substring(0,ids.length-1);
        getCoinsPrice(ids);
        update();
      }else if(response.isLeft){

      }
    });
  }
  getTokenMarketInfo(String id){
    coinInfo.value = CoinInfoModel();
    GetTokenMarketInfoUseCase getTokenMarketInfo = Get.find();
    Map<String,dynamic> parameters={
      'market_data':true,
      'community_data':false,
      'developer_data':false,
      'sparkline':false
    };
    getTokenMarketInfo.call(Params(body: parameters,id: id)).then((response){
      if(response.isRight){
        coinInfo.value = response.right;
      }else if(response.isLeft){

      }
    });
  }
  getTokenInfoByContractAddress(String contractAddress){
    GetTokenInfoByContractAddressUseCase getTokenInfoByContractAddress = Get.find();
    getTokenInfoByContractAddress.call(Params(contractAddress: contractAddress,assetPlatform: selectedNetwork!.assetPlatform)).then((response) {
      if(response.isRight){
        TokenModel token = response.right;
        String? imageUrl;
        tokenNameController.text = token.name!;
        tokenSymbolController.text = token.symbol!;
        if(token.image!= null){
          if(token.image!.small!= null) {
            imageUrl = token.image!.small!;
          }
          else if(token.image!.thumb!= null){
            imageUrl = token.image!.thumb!;
          }
          else if(token.image!.large!= null) {
            imageUrl = token.image!.large!;
          }
        }
        tokenToAdd = CoinModel(
            name: token.name,
            decimal: int.parse(tokenDecimal.value),
            symbol: token.symbol,
            imageUrl: imageUrl,
            jrpcApi: selectedNetwork!.apiUrls,
            coingeckoId: token.id,
            usd: token.marketData!.currentPrice!.usd,
            contractAddress: contractAddress);
        coins.add(tokenToAdd!);
        getTokenBalance(tokenToAdd!.contractAddress!,coins.last,coins.last.jrpcApi![0]);
        getHistoricalData(coin: coins.last,id: tokenToAdd!.coingeckoId,currency: 'usd',days: 256,interval: 'daily');
        saveCoins();
        update();
        // contractAddressController.clear();
        // tokenDecimalController.clear();
        // tokenSymbolController.clear();
        // tokenNameController.clear();
      }else if(response.isLeft){
        if(tokenName.value.isNotEmpty && tokenSymbol.value.isNotEmpty && tokenDecimal.value.isNotEmpty){
          tokenToAdd = CoinModel(
              name: tokenName.value,
              symbol: tokenSymbol.value,
              imageUrl: "",
              jrpcApi: selectedNetwork!.apiUrls,
              coingeckoId: "",
              decimal: int.parse(tokenDecimal.value),
              contractAddress: contractAddress);
          coins.add(tokenToAdd!);
          getTokenBalance(tokenToAdd!.contractAddress!,coins.last,coins.last.jrpcApi![0]);
          saveCoins();
          update();
        }
      }
    });
  }
  getTokenBalance(String contractAddress,CoinModel token,String url){
    GetTokenBalanceUseCase getTokenBalanceUseCase = Get.find();
    getTokenBalanceUseCase.call(Params(
        contractAddress: contractAddress,
        apiUrl: url
    )).then((response) {
      if(response.isRight){
        token.balance = getValueInUnit(response.right, int.parse(token.decimal.toString()));
        // Get.snackbar("Result", token.balance.toString());
        update();
      }else if(response.isLeft){

      }
    });
  }
  getTokenName(String contractAddress){
    GetTokenNameUseCase getTokenNameUseCase = Get.find();
    getTokenNameUseCase.call(Params(apiUrl: selectedNetwork!.apiUrls![0],contractAddress: contractAddress)).then((response) {
      if(response.isRight){
        print(response.right);
        tokenName.value = response.right;
        tokenNameController.text = response.right;
      }else if(response.isLeft){

      }
    });
  }
  getTokenSymbol(String contractAddress){
    GetTokenSymbolUseCase getTokenSymbolUseCase = Get.find();
    getTokenSymbolUseCase.call(Params(apiUrl: selectedNetwork!.apiUrls![0],contractAddress: contractAddress)).then((response) {
      if(response.isRight){
        print(response.right);
        tokenSymbol.value = response.right;
        tokenSymbolController.text = response.right;
      }else if(response.isLeft){

      }
    });
  }
  getTokenDecimal(String contractAddress){
    GetTokenDecimalUseCase getTokenDecimalUseCase = Get.find();
    getTokenDecimalUseCase.call(Params(apiUrl: selectedNetwork!.apiUrls![0],contractAddress: contractAddress)).then((response) {
      if(response.isRight){
        print(response.right);
        tokenDecimal.value = response.right;
        tokenDecimalController.text = response.right;
      }else if(response.isLeft){

      }
    });
  }
  updateBalance(){
    double tBalance = 0.0;
    for(CoinModel coin in coins){
      if(coin.enable!)
      {
        tBalance+=coin.usd!*coin.balance!;
      }
    }
    totalBalance = tBalance;
    update();
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
      showDialog("Initializing wallet ...");
      wallet= await compute(Wallet.fromMnemonic,secretPhrase);
      savePrivateKey();
      saveEthereumAddress();
      await getDefaultCoinsInfo();
      saveCoins();
      Get.offAllNamed(AppRoutes.homePage);
      Get.dialog(SuccessDialog(dialogAlert: 'Your wallet was successfully imported.',onDone: (value)=>Get.back(),));
    }catch (e) {
      print("error");

    }

  }
  showDialog(String title){
    Get.dialog(
        Scaffold(
          backgroundColor: Colors.grey.withOpacity(0.2),
          body: Container(

            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitFadingCube(color: Get.theme.primaryColor),
                  SizedBox(height: 40.0,),
                  SizedBox(
                    height: 40,
                    child:AnimatedTextKit(

                      animatedTexts: [
                        WavyAnimatedText(title,textStyle: TextStyle(fontWeight: FontWeight.bold,color: Get.theme.primaryColor)),
                      ],
                      isRepeatingAnimation: true,
                    ),
                    // child: TextLiquidFill(
                    //   text: 'Initializing wallet ...',
                    //   loadDuration: Duration(seconds: 2),
                    //   waveColor: Get.theme.primaryColor,
                    //   // boxBackgroundColor: Colors.redAccent,
                    //   textStyle: TextStyle(
                    //     fontSize: 15.0,
                    //     fontWeight: FontWeight.bold,
                    //   ),),
                  )]
            ),
          ),
        )
    );
  }
  getBalance(String url,CoinModel coin)async{
    GetBalanceUseCase getBalanceUseCase  = Get.find();
    Either response= await getBalanceUseCase.call(Params(value: url));
    if(response.isRight){
      coin.balance = response.right;
      // totalBalance += (coin.usd! * coin.balance!);
      double tBalance = 0.0;
      for(CoinModel coin in coins){
        if(coin.enable!)
        {
          tBalance+=coin.usd!*coin.balance!;
        }
      }
      totalBalance = tBalance;
      update();
    }
  }

  add(SecretItem item){
    selectedPhrasesList.add(item.title!);
  }
  remove(SecretItem item){
    selectedPhrasesList.remove(item.title!);
  }
  createPhraseItems(var secretPhraseList, {ValueChanged<SecretItem>? add, ValueChanged<SecretItem>? remove}){
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

  getCoinsPrice(String ids)async{
    GetCoinInfoUseCase getCoinsInfoUseCase  = Get.find();
    Map<String,dynamic> parameters = {
      'ids':ids,
      'vs_currencies':'usd',
      'include_market_cap':true,
      'include_24hr_vol':true,
      'include_24hr_change':true,
      'include_last_updated_at':true
    };
    Either response = await getCoinsInfoUseCase.call(Params(body: parameters));
    if(response.isRight){
      for(CoinModel coin in response.right)
      {
        CoinModel item =coins.firstWhere((element) => element.coingeckoId!.toLowerCase()== coin.name!.toLowerCase());
        item.usd = coin.usd;
        item.usdMarketCap = coin.usdMarketCap;
        item.usd24hVol = coin.usd24hVol;
        item.usd24hChange = coin.usd24hChange;
        item.lastUpdatedAt = coin.lastUpdatedAt;
        getHistoricalData(coin: item,id: item.coingeckoId,currency: 'usd',days: 256,interval: 'daily');
        if(item.contractAddress == null ) {
          getBalance(item.jrpcApi![0],item);
        }
        else{
          getTokenBalance(item.contractAddress!,item,item.jrpcApi![0]);
        }
      }
      update();

    }else if(response.isLeft){

    }
    update();
  }
  getDefaultCoinsInfo() async{
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
    Either response = await getCoinsInfoUseCase.call(Params(body: parameters));
    if(response.isRight){
      for(CoinModel coin in response.right)
      {
        switch (coin.name){
          case 'ethereum':
            coin.name = 'Ethereum';
            // coin.network = 'Ethereum';
            coin.symbol= 'ETH';
            coin.coingeckoId= 'ethereum';
            coin.chainId= '4002';
            coin.decimal = 18;

            coin.jrpcApi = [
              'https://kovan.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161',
              'https://ropsten.infura.io/v3/c8694e395984403b99cdef8e8182da43',
              'wss://ropsten.infura.io/ws/v3/c8694e395984403b99cdef8e8182da43',
              'https://rinkeby.infura.io/v3/c8694e395984403b99cdef8e8182da43',
              'wss://rinkeby.infura.io/ws/v3/c8694e395984403b99cdef8e8182da43',
            ];
            coin.imageUrl = 'https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880';
            break;
          case 'binancecoin':
            coin.decimal = 18;
            coin.name = 'BNB';
            coin.symbol= 'BNB';
            coin.coingeckoId= 'binancecoin';
            coin.chainId= '97';
            // coin.network = 'BNB Smart Chain';
            coin.jrpcApi = [
              // 'https://bscrpc.com',
              'https://data-seed-prebsc-1-s2.binance.org:8545',
              'https://data-seed-prebsc-2-s2.binance.org:8545',
              'https://data-seed-prebsc-2-s3.binance.org:8545'];
            coin.imageUrl = 'https://assets.coingecko.com/coins/images/825/large/bnb-icon2_2x.png';
            break;
          case 'fantom':
            coin.decimal = 18;
            coin.name = 'Fantom';
            coin.symbol= 'FTM';
            // coin.network = 'Fantom';
            coin.coingeckoId= 'fantom';
            coin.chainId= '4002';
            coin.jrpcApi = [
              'https://rpc.testnet.fantom.network'];
            coin.imageUrl = 'https://assets.coingecko.com/coins/images/4001/large/Fantom.png?1558015016';
            break;
          case 'matic-network':
            coin.decimal = 18;
            coin.name = 'Matic';
            coin.symbol= 'MATIC';
            // coin.network = 'Polygan';
            coin.coingeckoId= 'matic-network';
            coin.chainId= '80001';
            coin.jrpcApi = [
              'https://matic-testnet-archive-rpc.bwarelabs.com',
              'https://rpc-mumbai.maticvigil.com',
              'https://matic-mumbai.chainstacklabs.com',

            ];
            coin.imageUrl = 'https://assets.coingecko.com/coins/images/4713/large/matic-token-icon.png';
            break;

        }

        getHistoricalData(coin: coin,id: coin.coingeckoId,currency: 'usd',days: 256,interval: 'daily');
      }
      coins.clear();
      coins.addAll(response.right);
    }else if(response.isLeft){

    }
    update();
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
      ethAddress.value = response.right;
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

  sendTransaction({String? receiveAddress, double? amount,CoinModel? coin}){
    showDialog("Sending...");
    SendTransactionUseCase sendTransactionUseCase = Get.find();
    Map<String,dynamic> body;
    if(coin!.contractAddress!=null){
      body = {
        'receiveAddress':receiveAddress,
        'amount':amount,
        'apiUrl':coin.jrpcApi![retryCount],
        'decimal':coin.decimal==null?18:coin.decimal,
        'contractAddress':coin.contractAddress
      };
    }
    else {
        body = {
        'receiveAddress':receiveAddress,
        'amount':amount,
        'apiUrl':coin.jrpcApi![retryCount],
        'decimal':coin.decimal!,
      };
    }
    sendTransactionUseCase.call(Params(body: body)).then((response){
      if(response.isRight){
        Get.back();
        retryCount=0;
        TransactionInformation transaction = response.right;
        Fluttertoast.showToast(msg:'The transaction was completed successfully');
        if(coin.contractAddress==null){
          getBalance(coin.jrpcApi![0],coin);
        }
        else{
          getTokenBalance(coin.contractAddress!, coin, coin.jrpcApi![0]);
        }
        coin.transactions.add(
            TransactionModel(
                txHash: transaction.hash,
              amount: getValueInUnit(transaction.bigIntValue,coin.decimal!),
              isSend: true,
              symbol: coin.symbol,
              date: DateTime.now().toString()
            )
        );
        saveCoins();
        Get.back();
        print('TxHash ${response.right}');
      }else if(response.isLeft){
        Get.back();
        ServerFailure failure = response.left as ServerFailure;
        if(failure.errorMessage!.toLowerCase().contains("insufficient funds for gas")){
          Fluttertoast.showToast(msg: "insufficient funds for gas");
        }
        else{
          retryCount++;
          if(retryCount < coin.jrpcApi!.length-4){
            sendTransaction(receiveAddress: receiveAddress,amount: amount,coin: coin);
          }
          else {
            Fluttertoast.showToast(msg: 'failed to send transaction');
          }
        }

      }
    });
  }

  getTransactions(List<TransactionModel> tx){
    transactions.clear();
    List<TransactionModel> tx1=[];
    List<TransactionModel> tx2=[];
    List<TransactionModel> tx3=[];
    List<TransactionDateModel> tx4=[];
    tx2.addAll(tx);
    tx1.addAll(tx);
    int index=0;
    for(int i=0;i<tx1.length;i++){
      index = tx3.length;
      for(int j=i;j<tx2.length;j++){
        if(compareDate(date1: tx1[i].date,date2: tx2[j].date)){
          if(!tx3.contains(tx1[i])){
            tx3.add(tx1[i]);
          }
          if(!tx3.contains(tx2[j])){
            tx3.add(tx2[j]);
          }
        }

      }
      if(index<tx3.length){
        tx4.add(TransactionDateModel(date: tx3[index].date,transactions: tx3.sublist(index)));
      }
    }
    for(int i=0;i<tx4.length;i++){
      transactions.add(TransactionWidgetItem(tx: tx4[i],));
    }
    // tx4.map((e) => transactions.add(TransactionWidgetItem(tx: e,)));
    // transactions.addAll(TransactionWidgetItem(tx: transaction,));
    // for(TransactionModel transaction in tx){
    //   if(getDateTime(transaction.date!) == 0){
    //     tx1.add(transaction);
    //   }
    // }
    // for(TransactionModel transaction in tx){
    //   transactions.add(TransactionWidgetItem(tx: transaction,));
    // }
  }
  int getDateTime(String dateTime){
    DateTime now = DateTime.now();
    DateTime transactionDateTime = DateTime.parse(dateTime);
    return now.difference(transactionDateTime).inDays;
  }
  bool compareDate({String? date1, String? date2}){
    DateTime dateTime1 = DateTime.parse(date1!);
    DateTime dateTime2 = DateTime.parse(date2!);
    if(dateTime1.year == dateTime2.year){
      if(dateTime1.month == dateTime2.month){
        if(dateTime1.day == dateTime2.day){
          return true;
        }
        return false;
      }
    }
    return false;
  }
  getGas(String url,CoinModel coin){
    GetGasUseCase getGasUseCase = Get.find();
    getGasUseCase.call(Params(apiUrl: url)).then((response) {
      // if(response.isRight){
      //   EtherAmount.fromUnitAndValue(unit, amount)
      //   BigInt value = BigInt.from(10).pow(coin.decimal!)*response.right;
      //   getValueInUnit(transaction.bigIntValue,coin.decimal!);
      // }else if(response.isLeft){
      //
      // }
    });
  }

}
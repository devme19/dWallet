import 'dart:convert';

import 'package:dwallet/app/data/models/coin_historical_data_model.dart';
import 'package:dwallet/app/data/models/transaction_model.dart';
import 'package:dwallet/app/web3/web3dart.dart';

class CoinModel {
  String? name;
  String? symbol;
  String? coingeckoId;
  String? chainId;
  List<String>? jrpcApi;
  List<TransactionModel> transactions=[];
  // List<String>? jrpcApiTest;
  String? imageUrl;
  double? balance=0;
  CoinHistoricalDataModel? historicalData;
  String? contractAddress;
  bool? enable=true;

  double? usd = 0.0;
  double? usdMarketCap;
  double? usd24hVol;
  double? usd24hChange;
  int? lastUpdatedAt;
  int? decimal;

  CoinModel(
      {
        this.name,
        this.symbol,
        this.coingeckoId,
        this.contractAddress,
        this.chainId,
        this.jrpcApi,
        this.imageUrl,
        this.usd,
        this.usdMarketCap,
        this.usd24hVol,
        this.usd24hChange,
        this.lastUpdatedAt,
        this.enable = true,
        this.decimal
      });
  CoinModel.fromJson2(Map<String, dynamic> json) {
    usd = json['usd'];
    usdMarketCap = json['usd_market_cap'];
    usd24hVol = json['usd_24h_vol'];
    usd24hChange = json['usd_24h_change'];
    lastUpdatedAt = json['last_updated_at'];
  }
  CoinModel.fromJson(Map<String, dynamic> jsn) {
    var l = json.decode(jsn['transactions']);
    // var s = json.decode(jsn['transactions']).map<TransactionInformation>((e) => TransactionInformation.fromMap(e)).toList();
    name = jsn['name'];
    symbol = jsn['symbol'];
    coingeckoId = jsn['coingeckoId'];
    chainId = jsn['chainId'];
    jrpcApi = jsn['jrpcApi'].cast<String>();
    transactions =jsn["transactions"]!= null?decodeTransaction(jsn["transactions"]):[];
    // jrpcApiTest = json['jrpcApiTest'].cast<String>();
    imageUrl = jsn['imageUrl'];
    enable = jsn['enable'];
    decimal = jsn['decimal'];
    contractAddress = jsn['contractAddress'];
  }

  static Map<String, dynamic> toMap(CoinModel coin) =>{
    'name' : coin.name,
    'symbol' : coin.symbol,
    'coingeckoId' : coin.coingeckoId,
    'chainId' : coin.chainId,
    'jrpcApi' : coin.jrpcApi!.cast<String>(),
    'imageUrl' : coin.imageUrl,
    'usd' : coin.usd,
    'usd_market_cap' : coin.usdMarketCap,
    'usd_24h_vol' : coin.usd24hVol,
    'usd_24h_change' : coin.usd24hChange,
    'last_updated_at' : coin.lastUpdatedAt,
    'transactions' : encodeTransaction(coin.transactions),
    'enable':coin.enable,
    'decimal':coin.decimal,
    'contractAddress':coin.contractAddress
  };
  static String encode(List<CoinModel> coins) => json.encode(
    coins
        .map<Map<String, dynamic>>((coin) => CoinModel.toMap(coin))
        .toList(),
  );
  static List<CoinModel> decode(String coins) =>
      (json.decode(coins) as List<dynamic>)
          .map<CoinModel>((item) => CoinModel.fromJson(item))
          .toList();
  static String encodeTransaction(List<TransactionModel> transactions) => json.encode(
    transactions
        .map<Map<String, dynamic>>((transaction) => TransactionModel.toMap(transaction))
        .toList(),
  );
  static List<TransactionModel> decodeTransaction(String transactions) =>
      (json.decode(transactions) as List<dynamic>)
          .map<TransactionModel>((item) => TransactionModel.fromMap(item))
          .toList();
}

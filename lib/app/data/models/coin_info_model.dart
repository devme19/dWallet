class CoinInfoModel {
  String? id;
  String? symbol;
  String? name;
  Links? links;
  MarketData? marketData;

  CoinInfoModel({this.id, this.symbol, this.name, this.links, this.marketData,});

  CoinInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    marketData = json['market_data'] != null ? new MarketData.fromJson(json['market_data']) : null;
  }
}
class Links {
  List<String>? homepage;
  List<String>? blockChainSites;
  Links({this.homepage,this.blockChainSites});

  Links.fromJson(Map<String, dynamic> json) {
    homepage = json['homepage'].cast<String>();
    blockChainSites = json['blockchain_site'].cast<String>();
  }
}


class MarketData {


  double? totalSupply;
  double? circulatingSupply;

  MarketData({this.totalSupply,this.circulatingSupply, });

  MarketData.fromJson(Map<String, dynamic> json) {
    totalSupply = json['total_supply'];
    circulatingSupply = json['circulating_supply'];
  }
}
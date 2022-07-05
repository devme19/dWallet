class NetworkModel{
  List<String>? apiUrls;
  String? imageUrl;
  String? name;
  bool isSelected = false;
  String? assetPlatform;
  NetworkModel({this.apiUrls, this.imageUrl,this.name,this.isSelected = false,this.assetPlatform});
}
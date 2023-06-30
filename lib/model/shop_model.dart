class ShopModel {
  var id;
  var image;
  var longitude;
  var latitude;
  var maxOffers;
  var numberOfItems;
  var name;

  ShopModel({required this.id,
    required this.image,
    required this.longitude,
    required this.latitude,
    required this.maxOffers,
    required this.numberOfItems,
    required this.name});

  factory ShopModel.fromJson(Map<dynamic, dynamic> json){
    return ShopModel(id: json['Id'],
        image: json['Image'],
        longitude: json['Longitude'],
        latitude: json['Latitude'],
        maxOffers: json['MaxOffers'],
        numberOfItems: json['NumberOfItems'],
        name: json['Name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Image'] = this.image;
    data['Longitude'] = this.longitude;
    data['Latitude'] = this.latitude;
    data['MaxOffers'] = this.maxOffers;
    data['NumberOfItems'] = this.numberOfItems;
    data['Name'] = this.name;
    return data;
  }

}

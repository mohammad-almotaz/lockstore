class OffersHistroyModel {
  String id;
  String idShopes;
  String image;
  String longitude;
  String latitude;
  String maxOffers;
  String numberOfItems;
  String name;
  String date;

  OffersHistroyModel(
      {required this.id,
      required this.idShopes,
      required this.image,
      required this.longitude,
      required this.latitude,
      required this.maxOffers,
      required this.numberOfItems,
      required this.name,
      required this.date});

  factory OffersHistroyModel.fromJson(Map<dynamic, dynamic> json) {
    return OffersHistroyModel(
    id : json['Id'],
    idShopes : json['Id_shopes'],
    image : json['Image'],
    longitude : json['Longitude'],
    latitude : json['Latitude'],
    maxOffers : json['MaxOffers'],
    numberOfItems:  json['NumberOfItems'],
    name : json['Name'],
    date : json['Date'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Id_shopes'] = this.idShopes;
    data['Image'] = this.image;
    data['Longitude'] = this.longitude;
    data['Latitude'] = this.latitude;
    data['MaxOffers'] = this.maxOffers;
    data['NumberOfItems'] = this.numberOfItems;
    data['Name'] = this.name;
    data['Date'] = this.date;
    return data;
  }

}

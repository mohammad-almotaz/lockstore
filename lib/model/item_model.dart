class ItemModel {
  String id;
  String image;
  String name;
  String offer;

  ItemModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.offer});

  factory ItemModel.fromJson(Map<dynamic, dynamic> json) {
    return ItemModel(
        id: json['Id'],
        image: json['Image'],
        name: json['Name'],
        offer: json['Offer']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Image'] = this.image;
    data['Name'] = this.name;
    data['Offer'] = this.offer;
    return data;
  }
}

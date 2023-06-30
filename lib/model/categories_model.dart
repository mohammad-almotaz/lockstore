class CategoriesModel {
  String id;
  String image;
  String name;
  bool isChecked;

  CategoriesModel({
    required this.id,
    required this.image,
    required this.name,
    required this.isChecked,
  });

  factory CategoriesModel.fromJson(Map<dynamic, dynamic> json) {
    return CategoriesModel(
        id: json['Id'],
        image: json['Image'],
        name: json['Name'],
        isChecked: false);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Image'] = this.image;
    data['Name'] = this.name;
    data['isChecked'] = this.isChecked;
    return data;
  }
}

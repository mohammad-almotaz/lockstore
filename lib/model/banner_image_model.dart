class BannerImageModel {
  var Id;
  var ImageURL;
  var URL;

  BannerImageModel(
      {required this.Id, required this.ImageURL, required this.URL});

  factory BannerImageModel.fromJson(Map<dynamic, dynamic> json) {
    return BannerImageModel(
      Id: json['Id'],
      ImageURL: json['Image'],
      URL: json['URL'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.Id;
    data['Image'] = this.ImageURL;
    data['URL'] = this.URL;
    return data;
  }
}

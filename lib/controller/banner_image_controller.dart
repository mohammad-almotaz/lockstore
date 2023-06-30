import 'dart:convert';

import 'package:ecomerce/const/const_value.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/banner_image_model.dart';

class BannerImageController extends GetxController {
  List<BannerImageModel> listBannerImage = [];
  List<String> listBannerImageString = [];

  getBannerImage() async {
    listBannerImage = [];
    listBannerImageString = [];
    final response =
        await http.get(Uri.parse("${ConstValues.API_URL}get_bannar_images"));
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      for (Map i in jsonBody) {
        listBannerImageString.add(ConstValues.BASE_URL + i['Image']);
        listBannerImage.add(BannerImageModel.fromJson(i));
      }
      update();
    }
  }
}

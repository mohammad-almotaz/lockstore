import 'dart:convert';

import 'package:ecomerce/const/const_value.dart';
import 'package:ecomerce/const/language_const.dart';
import 'package:ecomerce/controller/shop_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/categories_model.dart';

class CategoriesController extends GetxController {
  List<CategoriesModel> listCategories = [];
  List<CategoriesModel> listCategoriesMain = [];
  ShopController shopController = Get.find();

  getCategories({required var from}) async {
    getLocale().then(
      (value) async {
        final response = await http.post(
          Uri.parse("${ConstValues.API_URL}get_categories"),
          body: {
            "lang": value.languageCode,
            "from": from,
          },
        );
        if (response.statusCode == 200) {
          var jsonBody = jsonDecode(response.body);
          for (Map i in jsonBody) {
            if (from == '1') {
              listCategoriesMain.add(CategoriesModel.fromJson(i));
            } else {
              listCategories.add(CategoriesModel.fromJson(i));
            }
          }
          listCategoriesMain[0].isChecked = true;
          shopController.getShop(Id_categories: listCategoriesMain[0].id);
          update();
        }
      },
    );
  }
}

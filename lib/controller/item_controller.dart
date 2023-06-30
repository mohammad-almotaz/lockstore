import 'dart:convert';

import 'package:ecomerce/const/const_value.dart';
import 'package:ecomerce/const/language_const.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/item_model.dart';

class ItemController extends GetxController {
  List<ItemModel> listItem = [];

  getItem({required var id_shop}) async {
    listItem = [];
    getLocale().then(
      (value) async {
        final response = await http.post(
          Uri.parse("${ConstValues.API_URL}get_offers"),
          body: {"lang": value.languageCode, "Id_shops": id_shop},
        );
        if (response.statusCode==200) {
          var jsonBody = jsonDecode(response.body);
          for(Map i in jsonBody){
            listItem.add(ItemModel.fromJson(i));
          }
          update();
        }
      },
    );
  }
}

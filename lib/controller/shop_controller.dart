import 'dart:convert';

import 'package:ecomerce/const/const_value.dart';
import 'package:ecomerce/const/language_const.dart';
import 'package:ecomerce/model/shop_model.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class ShopController extends GetxController {
  List<ShopModel> listShop = [];
  List<Marker> markers = [];
  LatLng? latLng;

  getShop({required var Id_categories}) async {
    listShop = [];
    markers = [];

    getLocale().then(
      (value) async {
        final response = await http.post(
          Uri.parse("${ConstValues.API_URL}get_shopes"),
          body: {
            "Id_categories": Id_categories,
            "lang": value.languageCode,
          },
        );
        if (response.statusCode == 200) {
          var jsonBody = jsonDecode(response.body);
          for (Map i in jsonBody) {
            listShop.add(ShopModel.fromJson(i));
            markers.add(
              Marker(
                markerId: MarkerId(i["Id"]),
                position: LatLng(
                  double.parse(i["Latitude"]),
                  double.parse(
                    i["Longitude"],
                  ),
                ),
                onTap: () {
                  latLng = LatLng(
                    double.parse(i["Latitude"]),
                    double.parse(
                      i["Longitude"],
                    ),
                  );
                },
              ),
            );
          }
          update();
        }
      },
    );
  }
}

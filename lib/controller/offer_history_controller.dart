import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../const/const_value.dart';
import '../const/language_const.dart';
import '../model/offer_history_model.dart';

class OfferHistoryController extends GetxController{
  List<OffersHistroyModel> listOfferHistory=[];

  getOffer({required var Id_users})async{
    listOfferHistory=[];
    getLocale().then(
          (value) async {
        final response = await http.post(
          Uri.parse("${ConstValues.API_URL}get_offers_history"),
          body: {"lang": value.languageCode, "Id_users": Id_users},
        );
        if (response.statusCode==200) {
          var jsonBody = jsonDecode(response.body);
          for(Map i in jsonBody){
            listOfferHistory.add(OffersHistroyModel.fromJson(i));
          }
          update();
        }
      },
    );

  }
}
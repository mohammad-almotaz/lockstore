import 'package:ecomerce/controller/offer_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../const/const_value.dart';
import '../general.dart';

class OfferHistoryScreen extends StatefulWidget {
  const OfferHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OfferHistoryScreen> createState() => _OfferHistoryScreenState();
}

class _OfferHistoryScreenState extends State<OfferHistoryScreen> {

  TextEditingController searchBarController = TextEditingController();
  OfferHistoryController offerHistoryController = Get.find();
  @override
  void initState() {
    super.initState();
    // offerHistoryController.getOffer(Id_users: General.getPrefString(ConstValues.Id, 'defaultValue'));
    General.getPrefString(ConstValues.Id, '').then((UserId) {
      offerHistoryController.getOffer(Id_users: UserId);
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          AppLocalizations.of(context)!.offer_history,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 50,
              child: TextField(
                controller: searchBarController,
                decoration: InputDecoration(
                  hintText: (AppLocalizations.of(context)!.search),
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<OfferHistoryController>(
              builder: (controller) {
                return ListView.builder(
                  itemCount: controller.listOfferHistory.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: ListTile(
                        trailing: Icon(Icons.arrow_forward),
                        leading: Image.network(
                          ConstValues.BASE_URL +
                              controller.listOfferHistory[index].image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.fill,
                        ),
                        title: Text(controller.listOfferHistory[index].name),
                        subtitle: Text(
                            controller.listOfferHistory[index].date +
                                " - " +
                                controller.listOfferHistory[index].maxOffers),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

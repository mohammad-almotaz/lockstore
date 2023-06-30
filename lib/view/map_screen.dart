import 'package:ecomerce/controller/categories_controller.dart';
import 'package:ecomerce/view/all_categories_screen.dart';
import 'package:ecomerce/view/all_shops_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../const/const_value.dart';
import '../controller/shop_controller.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  TextEditingController searchBarController = TextEditingController();
  ShopController shopController = Get.find();
  CategoriesController categoriesController = Get.find();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          AppLocalizations.of(context)!.all_shops,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GetBuilder<ShopController>(builder: (controller) {
              return GoogleMap(
                markers: controller.markers.toSet(),
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(31.985418381468598, 35.89800800221287),
                  zoom: 12,
                ),
              );
            }),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: TextField(
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: 'Search'),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(2, 400, 0, 0),
            // padding: EdgeInsets.all(10),
            child: GetBuilder<ShopController>(builder: (controller) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: controller.listShop.length,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .15,
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllShopsScreen(Id_categories: categoriesController.listCategories[index].id)));
                        },
                        minVerticalPadding: 10,
                        leading: Image.network(
                          width: MediaQuery.of(context).size.width * .20,
                          height: MediaQuery.of(context).size.width * .20,
                          fit: BoxFit.cover,
                          ConstValues.BASE_URL +
                              controller.listShop[index].image,
                        ),
                        title: Container(
                          width: (MediaQuery.of(context).size.width * .70) - 16,
                          child: Text(controller.listShop[index].name,
                              style: TextStyle(
                                fontSize: 25,
                              )),
                        ),
                        subtitle: Container(
                          width: (MediaQuery.of(context).size.width * .70) - 16,
                          child: Row(
                            children: [
                              Text(controller.listShop[index].numberOfItems,
                                  style: TextStyle(
                                    fontSize:
                                        (MediaQuery.of(context).size.width *
                                            0.03),
                                  )),
                              Text(controller.listShop[index].maxOffers,
                                  style: TextStyle(
                                      fontSize:
                                          (MediaQuery.of(context).size.width *
                                              .03),
                                      color: Colors.red)),
                            ],
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_outlined,
                          size: MediaQuery.of(context).size.width * .10,
                        ),
                      ),
                    );
                  });
            }),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton.extended(
            backgroundColor: Colors.deepOrange,
            onPressed: () => {
              openMap(shopController.latLng!.latitude,
                  shopController.latLng!.longitude)
            },
            icon: Icon(Icons.directions, semanticLabel: "Direction"),
            label: Text("Direction"),
          ),
          FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            onPressed: () => {},
            child: Icon(Icons.settings_outlined),
            // heroTag: "fab2",
          ),
        ],
      ),
    );
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    await launch(googleUrl);
  }
}

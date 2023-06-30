import 'package:ecomerce/view/item_view.dart';
import 'package:ecomerce/view/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../const/const_value.dart';
import '../controller/shop_controller.dart';

class AllShopsScreen extends StatefulWidget {
  var Id_categories;

  AllShopsScreen({required this.Id_categories});

  @override
  State<AllShopsScreen> createState() => _AllShopsScreenState();
}

class _AllShopsScreenState extends State<AllShopsScreen> {
  TextEditingController searchBarController = TextEditingController();
  ShopController shopController = Get.find();

  @override
  void initState() {
    shopController.getShop(Id_categories: widget.Id_categories);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapScreen(),
              ));
        },
        child: Icon(
          Icons.location_on_outlined,
        ),
        backgroundColor: Color(0xFFB60DFD),
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
            child: GetBuilder<ShopController>(
              builder: (controller) {
                return ListView.builder(
                  itemCount: controller.listShop.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemScreen(
                                  Id_shop: controller.listShop[index].id),
                            ));
                      },
                      child: ListTile(
                        trailing: Icon(Icons.arrow_forward),
                        leading: Image.network(
                          ConstValues.BASE_URL +
                              controller.listShop[index].image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.fill,
                        ),
                        title: Text(controller.listShop[index].name),
                        subtitle: Text(
                            controller.listShop[index].numberOfItems +
                                " - " +
                                controller.listShop[index].maxOffers),
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

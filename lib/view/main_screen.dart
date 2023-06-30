import 'package:ecomerce/controller/banner_image_controller.dart';
import 'package:ecomerce/controller/categories_controller.dart';
import 'package:ecomerce/controller/shop_controller.dart';
import 'package:ecomerce/model/categories_model.dart';
import 'package:ecomerce/view/all_categories_screen.dart';
import 'package:ecomerce/view/profile_view.dart';
import 'package:ecomerce/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:banner_image/banner_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../const/const_value.dart';
import '../const/language_const.dart';
import '../main.dart';
import '../model/languages.dart';
import 'item_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  BannerImageController bannerImageController = Get.find();
  CategoriesController categoriesController = Get.find();
  ShopController shopController = Get.find();

  @override
  void initState() {
    super.initState();
    bannerImageController.getBannerImage();
    categoriesController.listCategoriesMain = [];

    categoriesController.getCategories(from: '1');

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Image.asset("assets/images/logolock.png"),
          backgroundColor: Colors.white,
          title: const Text(
            "Lock Store ",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              icon: Icon(
                Icons.person,
                color: Colors.black,
                size: 40,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .30,
              child: GetBuilder<BannerImageController>(
                builder: (controller) {
                  return controller.listBannerImage.isNotEmpty
                      ? BannerImage(
                          itemLength: controller.listBannerImageString.length,
                          imageUrlList: controller.listBannerImageString,
                          selectedIndicatorColor: Colors.red,
                          onTap: (index) async {
                            await launchUrl(Uri.parse(
                                controller.listBannerImage[index].URL));
                          },
                        )
                      : Text("");
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.categories,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllCategoriesScreen()),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.see_all,
                    style: TextStyle(
                      color: Color(0xFFB60DFD),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .05,
              child: GetBuilder<CategoriesController>(
                builder: (controller) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.listCategoriesMain.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Container(
                          width: 100,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: controller.listCategoriesMain[index].isChecked
                                ? Color(0xFFB60DFD)
                                : Colors.grey,
                          ),
                          child: Text(
                            controller.listCategoriesMain[index].name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        onTap: () {
                          for (CategoriesModel categoriesModel
                              in controller.listCategoriesMain) {
                            categoriesModel.isChecked = false;
                          }
                          controller.listCategoriesMain[index].isChecked = true;
                          setState(() {});
                          shopController.getShop(
                            Id_categories: controller.listCategoriesMain[index].id,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: GetBuilder<ShopController>(
                builder: (controller) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
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

                        // child: Container(
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Image.network(
                        //         fit: BoxFit.fill,
                        //         ConstValues.BASE_URL +
                        //             controller.listShop[index].image,
                        //         height: 100,
                        //         width: 100,
                        //       ),
                        //       SizedBox(
                        //         width: 10,
                        //       ),
                        //       Column(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Text(controller.listShop[index].name),
                        //           SizedBox(
                        //             height: 10,
                        //           ),
                        //           Text(
                        //               "${controller.listShop[index].numberOfItems} - ${controller.listShop[index].maxOffers}"),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

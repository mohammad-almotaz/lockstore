import 'package:ecomerce/const/const_value.dart';
import 'package:ecomerce/controller/item_controller.dart';
import 'package:ecomerce/view/qrcode_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ItemScreen extends StatefulWidget {
  var Id_shop;

  ItemScreen({required this.Id_shop});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  TextEditingController searchBarController = TextEditingController();
  ItemController itemController = Get.find();

  @override
  void initState() {
    super.initState();
    itemController.getItem(id_shop: widget.Id_shop);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () => {
           Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QRScreen(),
              )),
        },
        child: Image.asset(
          "assets/images/scanbarcode.png",
          fit: BoxFit.fill,
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          AppLocalizations.of(context)!.all_items,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: searchBarController,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: 'Search'),
            ),
            GetBuilder<ItemController>(
              builder: (controller) {
                return GridView.builder(
                  padding: EdgeInsets.symmetric(vertical: 1),
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 8,
                    crossAxisCount: 2,
                  ),
                  itemCount: controller.listItem.length,
                  itemBuilder: (context, index) {
                    return InkWell(

                      child: Column(
                        children: [
                          Image.network(
                            ConstValues.BASE_URL +
                                controller.listItem[index].image,
                            height: 143,
                            width: 143,
                            fit: BoxFit.fill,
                          ),
                          Text(
                            controller.listItem[index].name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            controller.listItem[index].offer,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

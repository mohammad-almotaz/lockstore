import 'package:ecomerce/const/const_value.dart';
import 'package:ecomerce/view/all_shops_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import '../controller/categories_controller.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  TextEditingController searchBarController = TextEditingController();
  CategoriesController categoriesController = Get.find();

  @override
  void initState() {
    categoriesController.listCategories = [];
    categoriesController.getCategories(from: '2');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          AppLocalizations.of(context)!.all_categories,
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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: InkWell(
                child: GetBuilder<CategoriesController>(
                  builder: (controller) {
                    return GridView.builder(
                      itemCount: controller.listCategories.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            (MediaQuery.of(context).size.width / 2) - 32,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllShopsScreen(
                                    Id_categories:
                                        controller.listCategories[index].id),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Image.network(
                                  ConstValues.BASE_URL +
                                      controller.listCategories[index].image,
                                  height:
                                      (MediaQuery.of(context).size.width / 3) -
                                          52,
                                  fit: BoxFit.fill,
                                ),
                                Center(
                                  child: Text(
                                      controller.listCategories[index].name),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

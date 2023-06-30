import 'package:ecomerce/const/const_value.dart';
import 'package:ecomerce/const/language_const.dart';
import 'package:ecomerce/general.dart';
import 'package:ecomerce/main.dart';
import 'package:ecomerce/model/languages.dart';
import 'package:ecomerce/view/about_us_screen.dart';
import 'package:ecomerce/view/offer_history_screen.dart';
import 'package:ecomerce/view/personal_info_screen.dart';
import 'package:ecomerce/view/splash_view.dart';
import 'package:ecomerce/view/terms&privacy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Language> listLanguage = Language.languageList();
  Language? language;
  String langName = "english";
  String? userName;
  String? userImageUrl;
  bool notification = true;

  @override
  void initState() {
    super.initState();
    General.getPrefBool(ConstValues.NOTIFICATION, true).then(
      (value) {
        notification = value;
        setState(() {});
      },
    );

    General.getPrefString(ConstValues.langName, "english").then(
      (value) {
        langName = value;
      },
    );

    General.getPrefString(ConstValues.Name, "").then((value) {
      userName = value;
      setState(() {});
    });

    General.getPrefString(ConstValues.Image, "").then((value) {
      userImageUrl = value;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            AppLocalizations.of(context)!.my_profile,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.account,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      maxRadius: 40,
                      child: ClipOval(
                        child: userImageUrl == "null" ||
                                userImageUrl == "" ||
                                userImageUrl == null
                            ? Image.asset(
                                "assets/images/personal.png",
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              )
                            : Image.network(
                                ConstValues.BASE_URL + userImageUrl!,
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              ),
                      ),
                    ),
                    Column(
                      children: [
                        Text('$userName'),
                        SizedBox(
                          height: 20,
                        ),
                        Text(AppLocalizations.of(context)!.edit_my_info),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PersonalInfoScreen(),
                            ));
                      },
                      icon: Icon(
                        Icons.arrow_circle_right,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.other,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/images/otherhistorylogo.png"),
                    Text(
                      AppLocalizations.of(context)!.offer_history,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OfferHistoryScreen(),
                            ));
                      },
                      icon: Icon(
                        Icons.arrow_circle_right,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/images/aboutuslogo.png"),
                    Text(
                      AppLocalizations.of(context)!.about_us,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutUsScreen(),
                            ));
                      },
                      icon: Icon(
                        Icons.arrow_circle_right,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/images/termsandprivacylogo.png"),
                    Text(
                      AppLocalizations.of(context)!.terms_and_privacy_policy,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TermsPrivacyScreen(),));
                      },
                      icon: Icon(
                        Icons.arrow_circle_right,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/images/languagelogo.png"),
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ),
                                  ),
                                  height: 500,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.deepPurple,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: ListTile(
                                                  title: Text(
                                                      listLanguage[1].name),
                                                  trailing: Radio<Language>(
                                                    activeColor:
                                                        Colors.deepPurple,
                                                    value: listLanguage[1],
                                                    groupValue: language,
                                                    onChanged: (Language? val) {
                                                      setState(() {
                                                        language = val!;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.deepPurple,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: ListTile(
                                                  title: Text(
                                                      listLanguage[0].name),
                                                  trailing: Radio<Language>(
                                                    activeColor:
                                                        Colors.deepPurple,
                                                    value: listLanguage[0],
                                                    groupValue: language,
                                                    onChanged: (Language? val) {
                                                      setState(() {
                                                        language = val!;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  MaterialButton(
                                                    minWidth: 150,
                                                    height: 50,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    color: Colors.grey,
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Cancel",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.black)),
                                                  ),
                                                  MaterialButton(
                                                    minWidth: 150,
                                                    height: 50,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    color: Colors.deepPurple,
                                                    onPressed: () async {
                                                      Locale _locale =
                                                          await setLocale(
                                                              language!
                                                                  .languageCode);
                                                      await General
                                                          .savePrefString(
                                                              ConstValues
                                                                  .langName,
                                                              language!.name);
                                                      MyApp.setLocale(
                                                          context, _locale);
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                SplashScreen(),
                                                          ));
                                                    },
                                                    child: Text("Confirm",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Text(
                        langName!,
                        style: TextStyle(
                          color: Color(0xFFB60DFD),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/images/notificationlogo.png"),
                    Text(
                      AppLocalizations.of(context)!.notification,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Switch(
                      value: notification,
                      activeColor: Colors.green,
                      onChanged: (value) async {
                        await General.savePrefBoll(
                            ConstValues.NOTIFICATION, value);
                        setState(() {
                          notification = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/images/signoutlogo.png"),
                    Text(
                      AppLocalizations.of(context)!.sign_out,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_circle_right,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

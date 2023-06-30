import 'dart:convert';
import 'dart:io';
import 'package:ecomerce/const/language_const.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../const/const_value.dart';
import '../general.dart';
import '../model/gender.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  String? userfile;
  String? userName;
  String? phone;
  String? dob;
  String? pass;
  Gender? dropdownValue;
  File? selectedImage;
  String? userImageUrl;
  String base64Image = "";
  List<Gender> listGender = [];

  final TextEditingController _controllerFullName = TextEditingController();

  // final TextEditingController _controllerBirthDay = TextEditingController();
  final TextEditingController _controllerGender = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  Gender? gender;

  Future<void> chooseImage(type) async {
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
    } else {
      image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
      });
    }
  }

  @override
  void initState() {
    super.initState();

    General.getPrefString(ConstValues.DOB, "").then((value) {
      dob = value;
      setState(() {});
    });

    General.getPrefString(ConstValues.Phone, "").then((value) {
      phone = value;
      setState(() {});
    });

    General.getPrefString(ConstValues.Image, "").then((value) {
      userImageUrl = value;
      setState(() {});
    });

    General.getPrefString(ConstValues.Id_gender, "").then((value) {
      _controllerGender.text = value;
      if (value == "1") {
        gender = listGender[0];
      } else {
        gender = listGender[1];
      }
      setState(() {});
    });
    General.getPrefString(ConstValues.DOB, "").then(
      (value) {
        dob = value;
        setState(() {});
      },
    );
    General.getPrefString(ConstValues.PASSWORD, "").then((value) {
      _controllerPassword.text = value;
      setState(() {});
    });

    General.getPrefString(ConstValues.Name, "").then((value) {
      userName = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    listGender = [
      Gender("1", AppLocalizations.of(context)!.male),
      Gender("2", AppLocalizations.of(context)!.female)
    ];

    return Scaffold(
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
          children: [
            Text(AppLocalizations.of(context)!.account_info),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Container(
                            height: MediaQuery.of(context).size.height * .3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            )),
                            child: Container(
                              color: Colors.white,
                              margin: EdgeInsets.only(top: 15),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  MaterialButton(
                                    minWidth: 140,
                                    height: 65,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    color: Colors.deepPurple,
                                    onPressed: () {
                                      chooseImage("camera");
                                      editUserImage(Id_users: "Id_users");
                                      setState(() {});
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!
                                            .image_from_camera,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  MaterialButton(
                                    minWidth: 140,
                                    height: 65,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    color: Colors.deepPurple,
                                    onPressed: () {
                                      chooseImage("Gallery");
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!
                                            .image_from_gallery,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    });
              },
              child: CircleAvatar(
                maxRadius: 40,
                child: ClipOval(
                  child: selectedImage != null
                      ? Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        )
                      : userImageUrl == "null" ||
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
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.full_name),
              subtitle: Text('$userName'),
              trailing: TextButton(
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .change_full_name,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
                                  child: Column(
                                    children: [
                                      TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple)),
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .enter_your_name),
                                        controller: _controllerFullName,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          MaterialButton(
                                            minWidth: 140,
                                            height: 50,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            color: Colors.grey,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .cancel,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black)),
                                          ),
                                          MaterialButton(
                                            minWidth: 140,
                                            height: 50,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            color: Colors.deepPurple,
                                            onPressed: () async {
                                              await General.savePrefString(
                                                  ConstValues.Name,
                                                  _controllerFullName.text);
                                              editUserName(
                                                  Id_users: await General
                                                      .getPrefString(
                                                          ConstValues.Id, ""));
                                              userName =
                                                  _controllerFullName.text;

                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .confirm,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white)),
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
                      });
                },
                child: Text(
                  AppLocalizations.of(context)!.change,
                  style: TextStyle(color: Colors.deepPurple),
                ),
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.phone_number),
              subtitle: Text("$phone"),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.dob),
              subtitle: Text("$dob"),
              trailing: TextButton(
                onPressed: () async {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime(2000, 01, 1),
                          firstDate: DateTime(1950, 01, 01),
                          lastDate: DateTime(2023, 12, 12))
                      .then(
                    (value) {
                      dob = "${value!.year}/${value.month}/${value.day}";
                      setState(() {});
                    },
                  );
                  await General.savePrefString(ConstValues.DOB, dob!);
                  General.getPrefString(ConstValues.Id, "").then(
                    (value) {
                      editUserBirthday(Id_users: value);
                    },
                  );
                  setState(() {});
                },
                child: Text(
                  AppLocalizations.of(context)!.change,
                  style: TextStyle(color: Colors.deepPurple),
                ),
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.gender),
              subtitle: Text("${gender!.name}"),
              trailing: TextButton(
                onPressed: () async {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return Container(
                            height: MediaQuery.of(context).size.height * .46,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                            ),
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
                                    Text(
                                      AppLocalizations.of(context)!.gender,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
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
                                              leading: Icon(Icons.female),
                                              title: Text(listGender[1].name),
                                              trailing: Radio<Gender>(
                                                activeColor: Colors.deepPurple,
                                                value: listGender[1],
                                                groupValue: gender,
                                                onChanged: (Gender? val) {
                                                  setState(() {
                                                    gender = val!;
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
                                              leading: Icon(Icons.male),
                                              title: Text(listGender[0].name),
                                              trailing: Radio<Gender>(
                                                activeColor: Colors.deepPurple,
                                                value: listGender[0],
                                                groupValue: gender,
                                                onChanged: (Gender? val) {
                                                  setState(() {
                                                    gender = val!;
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
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              MaterialButton(
                                                minWidth: 150,
                                                height: 50,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                color: Colors.grey,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .cancel,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black)),
                                              ),
                                              MaterialButton(
                                                minWidth: 150,
                                                height: 50,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                color: Colors.deepPurple,
                                                onPressed: () async {
                                                  editUserGender(
                                                      Id_users: await General
                                                          .getPrefString(
                                                              ConstValues.Id,
                                                              ""));
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .confirm,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )));
                      });
                    },
                  );

                  setState(() {});
                },
                child: Text(
                  AppLocalizations.of(context)!.change,
                  style: TextStyle(color: Colors.deepPurple),
                ),
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.password),
              trailing: TextButton(
                onPressed: () async {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.change_password,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
                                  child: Column(
                                    children: [
                                      TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple)),
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .enter_your_password),
                                        controller: _controllerPassword,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          MaterialButton(
                                            minWidth: 140,
                                            height: 50,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            color: Colors.grey,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .cancel,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black)),
                                          ),
                                          MaterialButton(
                                            minWidth: 140,
                                            height: 50,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            color: Colors.deepPurple,
                                            onPressed: () async {
                                              await General.savePrefString(
                                                  ConstValues.PASSWORD,
                                                  _controllerPassword.text);
                                              editUserPassword(
                                                  Id_users: await General
                                                      .getPrefString(
                                                          ConstValues.PASSWORD,
                                                          ""));

                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .confirm,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white)),
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
                      });

                  setState(() {});
                },
                child: Text(
                  AppLocalizations.of(context)!.change,
                  style: TextStyle(color: Colors.deepPurple),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  editUserName({required var Id_users}) async {
    getLocale().then(
      (value) async {
        final response = await http.post(
          Uri.parse("${ConstValues.API_URL}update_user_fullname"),
          body: {
            "Name": _controllerFullName.text,
            "Id_users": Id_users,
            "lang": value.languageCode,
          },
        );
        if (response.statusCode == 200) {
          var jsonBody = jsonDecode(response.body);
          setState(() {});
          print(jsonBody);
        }
      },
    );
  }

  editUserImage({required var Id_users}) async {
    getLocale().then(
      (value) async {
        final response = await http.post(
          Uri.parse("${ConstValues.BASE_URL}update_user_image"),
          body: {
            "userfile": userfile,
            "Id_users": Id_users,
            "lang": value.languageCode,
          },
        );
        if (response.statusCode == 200) {
          var jsonBody = jsonDecode(response.body);
          print(jsonBody);
        }
      },
    );
  }

  editUserBirthday({required var Id_users}) async {
    getLocale().then(
      (value) async {
        final response = await http.post(
          Uri.parse("${ConstValues.API_URL}update_user_birthday_date"),
          body: {
            "DOB": dob,
            "Id_users": Id_users,
            "lang": value.languageCode,
          },
        );
        if (response.statusCode == 200) {
          var jsonBody = jsonDecode(response.body);
          print(jsonBody);
        }
      },
    );
  }

  editUserPassword({required var Id_users}) async {
    final response = await http.post(
      Uri.parse("${ConstValues.API_URL}update_user_password"),
      body: {
        "Password": _controllerPassword.text,
        "Id_users": Id_users,
        "lang": "en",
      },
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      print(jsonBody);
      setState(() {});
    }
  }

  editUserGender({required var Id_users}) async {
    getLocale().then(
      (value) async {
        final response = await http.post(
          Uri.parse("${ConstValues.API_URL}update_user_gender"),
          body: {
            "gender": gender!.id,
            "Id_users": Id_users,
            "lang": value.languageCode,
          },
        );
        if (response.statusCode == 200) {
          var jsonBody = jsonDecode(response.body);
          print(jsonBody);
          setState(() {});
        }
      },
    );
  }
}

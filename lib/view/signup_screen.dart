import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:country_picker/country_picker.dart';
import 'package:ecomerce/view/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../const/const_value.dart';
import '../const/language_const.dart';
import '../main.dart';
import '../model/gender.dart';
import '../model/languages.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  List<Gender>? list;
  Gender? dropdownValue;
  String countrycode = "962";
  bool isChecked = false;

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController genderTextEditingController = TextEditingController();
  TextEditingController dobTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool showErrorPassword = false;
  bool showErrorName = false;
  bool showErrorPhone = false;
  var isSecure;

  @override
  void initState() {
    isSecure = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    list = [
      Gender("1", AppLocalizations.of(context)!.male),
      Gender("2", AppLocalizations.of(context)!.female)
    ];
    dropdownValue = list![0];

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Color(0xFF1F0055)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Stack(children: [
                    Image.asset(
                      'assets/images/splachscreen.png',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.fill,
                    ),
                  ]),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 58,
                        right: 20,
                        bottom: 58,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.create_new_account,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF292D32),
                                ),
                              ),
                              DropdownButton<Language>(
                                underline: const SizedBox(),
                                icon: const Icon(
                                  Icons.language,
                                  color: Colors.black,
                                ),
                                onChanged: (Language? language) async {
                                  if (language != null) {
                                    Locale _locale =
                                    await setLocale(language.languageCode);
                                    MyApp.setLocale(context, _locale);
                                  }
                                },
                                items: Language.languageList()
                                    .map<DropdownMenuItem<Language>>(
                                      (e) => DropdownMenuItem<Language>(
                                    value: e,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: <Widget>[Text(e.name)],
                                    ),
                                  ),
                                )
                                    .toList(),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            AppLocalizations.of(context)!
                                .hello_we_glad_you_have_joined_our_family,
                            style: TextStyle(
                              color: Color(0xFF292d3ab3),
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: nameTextEditingController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              label:
                                  Text(AppLocalizations.of(context)!.full_name),
                              hintText: (AppLocalizations.of(context)!
                                  .enter_your_name),
                              errorText: showErrorName
                                  ? AppLocalizations.of(context)!.required
                                  : null,
                            ),
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: phoneTextEditingController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              label: Text(
                                  AppLocalizations.of(context)!.phone_number),
                              prefix: InkWell(
                                child: Text("$countrycode   "),
                                onTap: () {
                                  showCountryPicker(
                                    context: context,
                                    showPhoneCode: true,
                                    // optional. Shows phone code before the country name.
                                    onSelect: (Country country) {
                                      countrycode = country.phoneCode;
                                    },
                                  );
                                },
                              ),
                              hintText: ('797525139'),
                              errorText: showErrorPhone
                                  ? AppLocalizations.of(context)!.required
                                  : null,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime(2000, 01, 01),
                                      firstDate: DateTime(1950, 01, 01),
                                      lastDate: DateTime(2006, 01, 01))
                                  .then(
                                (value) {
                                  dobTextEditingController.text =
                                      "${value!.year}/${value.month}/${value.day}";
                                },
                              );
                            },
                            controller: dobTextEditingController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              label: Text(AppLocalizations.of(context)!.dob),
                              errorText: showErrorPhone
                                  ? AppLocalizations.of(context)!.required
                                  : null,
                            ),
                            readOnly: true,
                          ),
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black),
                            ),
                            child: DropdownButton(
                              value: dropdownValue,
                              isExpanded: true,
                              hint: Text('Select'),
                              items: list!.map<DropdownMenuItem<Gender>>(
                                  (Gender value) {
                                return DropdownMenuItem<Gender>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(value.name),
                                  ),
                                );
                              }).toList(),
                              onChanged: (Gender? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            obscureText: isSecure,
                            controller: passwordTextEditingController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: isSecure
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    isSecure =! isSecure;
                                  });
                                },
                              ),
                              hintText: AppLocalizations.of(context)!
                                  .enter_your_password,
                              label:
                                  Text(AppLocalizations.of(context)!.password),
                              errorText: showErrorPassword
                                  ? AppLocalizations.of(context)!.required
                                  : null,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                onChanged: (value) {
                                  isChecked = value!;
                                  setState(() {});
                                },
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .i_agree_to,
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "  ${AppLocalizations.of(context)!.terms_of_service_and_privacy_policy}",
                                      style: TextStyle(color: Colors.blue),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              showErrorPassword =
                                  passwordTextEditingController.text.isEmpty;
                              showErrorPhone =
                                  phoneTextEditingController.text.isEmpty;
                              showErrorName =
                                  nameTextEditingController.text.isEmpty;
                              setState(() {
                                if (!showErrorPassword &&
                                    !showErrorName &&
                                    !showErrorPhone &&
                                    isChecked) {
                                  signUp();
                                }
                              });
                            },
                            child: Container(
                              width: 388,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.topLeft,
                                    colors: [
                                      Color(0xFFA501FF),
                                      Color(0xFFC518FC),
                                    ]),
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.proceed,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .already_have_an_account,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "  ${AppLocalizations.of(context)!.login}",
                                    style: TextStyle(color: Color(0xFFB60DFD)),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signUp() async {
    final response =
        await http.post(Uri.parse("${ConstValues.API_URL}signup"), body: {
      "name": nameTextEditingController.text,
      "DOB": dobTextEditingController.text,
      "phone": phoneTextEditingController.text,
      "password": passwordTextEditingController.text,
      "countryCode": countrycode,
      "gender": dropdownValue!.id,
      "lang": "en",
      "plans": "1",
    });

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                jsonBody['response'] ? jsonBody['data'] : jsonBody['error']),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (jsonBody['response']) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Ok"))
            ],
          );
        },
      );
    }
  }
}

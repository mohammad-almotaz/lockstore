import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:country_picker/country_picker.dart';
import 'package:ecomerce/const/const_value.dart';
import 'package:ecomerce/view/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../const/language_const.dart';
import '../model/languages.dart';
import '../main.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPhoneError = false;
  bool showPasswordError = false;
  String countrycode = "962";
  var isSecure;

  @override
  void initState() {
    isSecure = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Color(0xFF1F0055)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Stack(children: [
                    Image.asset(
                      'assets/images/splachscreen.png',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.fill,
                    ),
                    Center(child: Image.asset('assets/images/logoone.png')),
                  ]),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
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
                                translation(context).login,
                                style: TextStyle(
                                  fontSize: 32,
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
                                .welcome_log_in_with_your_phone_number,
                            style: TextStyle(
                              color: Color(0xFF292d32b3),
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: phoneController,
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
                              errorText: showPhoneError
                                  ? AppLocalizations.of(context)!.required
                                  : null,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 20),
                          TextField(
                            obscureText: isSecure,
                            controller: passwordController,
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
                              errorText: showPasswordError
                                  ? AppLocalizations.of(context)!.required
                                  : null,
                              hintText: '******',
                              label:
                                  Text(AppLocalizations.of(context)!.password),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            AppLocalizations.of(context)!.forget_password,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xFF292D32),
                            ),
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              showPhoneError = phoneController.text.isEmpty;
                              showPasswordError =
                                  passwordController.text.isEmpty;
                              setState(() {
                                if (!showPhoneError && !showPasswordError) {
                                  login();
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
                                  AppLocalizations.of(context)!.login,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:"${AppLocalizations.of(context)!.dont_have_an_account}  ",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .register_now,
                                  style: TextStyle(color: Color(0xFFB60DFD)),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpScreen()),
                                      );
                                    },
                                ),
                              ],
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

  login() async {
    final response = await http.post(
      Uri.parse("${ConstValues.API_URL}login_mobile_users"),
      body: {
        "countryCode": countrycode,
        "phone": phoneController.text,
        "password": passwordController.text,
        "lang": "en",
      },
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var result = jsonBody['response'];
      if (result) {

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(ConstValues.Id, jsonBody['Id']);
        await prefs.setString(ConstValues.Name, jsonBody['Name']);
        await prefs.setString(ConstValues.Id_gender, jsonBody['Id_gender']);
        await prefs.setString(ConstValues.Phone, jsonBody['Phone']);
        await prefs.setString(ConstValues.Image, jsonBody['Image'].toString());
        await prefs.setString(ConstValues.CountryCode, jsonBody['CountryCode']);
        await prefs.setString(ConstValues.DOB, jsonBody['DOB']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              icon: Icon(Icons.login),
              title: Text("Wrong"),
              content: Text(jsonBody['error']),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
  }
}

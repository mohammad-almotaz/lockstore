import 'dart:async';

import 'package:ecomerce/const/const_value.dart';
import 'package:ecomerce/general.dart';
import 'package:ecomerce/view/main_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    General.getPrefString(ConstValues.Id, "").then(
      (idUser) {
        if(idUser == "") {
          Timer(
            const Duration(seconds: 3),
                () =>
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen(),
                  ),
                ),
          );
        }else{
          Timer(
            const Duration(seconds: 3),
                () =>
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => MainScreen(),
                  ),
                ),
          );
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/splachscreen.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ),
          Center(child: Image.asset('assets/images/logoone.png')),
        ],
      ),
    );
  }
}

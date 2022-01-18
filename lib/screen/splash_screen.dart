import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:grocery/screen/home.dart';
import 'package:grocery/screen/home_screen.dar.dart';
import 'package:grocery/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

String Id;

class SplashScreenPage extends StatefulWidget {
  // final bool isSignedIn;
  // final VerifyOtpResponse verifyOtpResponse;
  // SplashScreenPage(this.isSignedIn ,this.verifyOtpResponse,);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Future getvalidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var id = sharedPreferences.getString('user_id');
    setState(() {
      Id = id;
    });
  }

  bool isSplashTimeout=false;
  startTime() async {
    return new Timer(
        new Duration(
          milliseconds: 4200,
        ), () {
      setState(() {
        isSplashTimeout = true;
      });
    }); // duration of splash to show
  }

  @override
  void initState() {
    getvalidationData().whenComplete(() async {
      isSplashTimeout = false;
      startTime();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isSplashTimeout
        ? Id != null
            ? home()
            : LoginScreen()
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: AnimatedSplashScreen(
              splashIconSize: 1500,
              duration: 4000,
              splash: Image(
                height: 1500,
                image: AssetImage('assets/logo/gs_logo1.jpg'),
              ),
              // nextScreen:home(),  //getvalidationData().whenComplete(),
              backgroundColor: Colors.white,
              splashTransition: SplashTransition.fadeTransition,
            ),
          );
  }
}

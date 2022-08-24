import 'dart:async';

import'package:flutter/material.dart';
import 'package:hirfati/layout/homelayout.dart';
import 'package:hirfati/shared/theme.dart';


class SplashScreen extends StatefulWidget {
  
static final String routeName='SplashScreen';
  @override
   _SplashScreen createState() => _SplashScreen();
}
class _SplashScreen extends State<SplashScreen> {
  //const OnboardingPages({Key? key}) : super(key: key);
  static final String routeName='SplashScreen';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  Timer(Duration(seconds: 3),()=>Navigator.popAndPushNamed(context,HomeLayout.routeName ) );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:Text('Hirfati',style: TextStyle(fontSize:h1_txt, color: color_3 ),) ,)
    );
  }
}
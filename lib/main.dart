import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import'package:flutter/material.dart';
import 'package:hirfati/layout/homelayout.dart';
import 'package:hirfati/modules/login/loginpage.dart';
import 'package:hirfati/modules/splashscreen/splashscreen.dart';
import'package:hirfati/modules/homepage/homepage.dart';
import'package:hirfati/modules/RegisterPage/RegisterPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'modules/homepage/explore.dart';
import 'modules/searchpage/searchpage.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    runApp(Hirfati());
}
class Hirfati extends StatelessWidget {
  //const Hirfati({Key? key}) : super(key: key);
  static final FirebaseAuth myAuth=FirebaseAuth.instance;
  static final FirebaseFirestore myFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    
    
    return MaterialApp(
      
       theme: ThemeData( 
       ),initialRoute: SplashScreen.routeName,
       routes: {
        SplashScreen.routeName:(context)=>SplashScreen(),
        HomeLayout.routeName:(context)=>HomeLayout(),
        LoginPage.routeName:(context)=>LoginPage(),
        HomePage.routeName:(context)=>HomePage(),
        RegisterPage.routeName:(context)=>RegisterPage(),
        Explore.routeName:(context)=>Explore(),
        SearchPage.routeName:(context)=>SearchPage(),
        
       },debugShowCheckedModeBanner: false,
       
    );
  }
}
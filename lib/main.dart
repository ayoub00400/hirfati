import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hirfati/layout/homelayout.dart';
import 'package:hirfati/modules/integratedsearch/searchhome.dart';
import 'package:hirfati/modules/login/loginpage.dart';
import 'package:hirfati/modules/massanger/massanger.dart';
import'package:hirfati/modules/homepage/homepage.dart';
import'package:hirfati/modules/RegisterPage/RegisterPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hirfati/modules/registerpage/emailregistrationcheck..dart';
import 'package:hirfati/modules/workerprofile/workerprofile.dart';
import 'package:hirfati/modules/seemorepage/seemorepage.dart';
import 'modules/category/category.dart';
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
   //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    
    return MaterialApp(
      
       theme: ThemeData( 
       ),initialRoute:  HomeLayout.routeName,
       routes: {
        //SplashScreen.routeName:(context)=>SplashScreen(),
        EmailCkeckPage.routeName:(context)=>EmailCkeckPage(),
        HomeLayout.routeName:(context)=>HomeLayout(),
        MassangerPage.routeName:(context)=>MassangerPage(),
        LoginPage.routeName:(context)=>LoginPage(),
        HomePage.routeName:(context)=>HomePage(),
        RegisterPage.routeName:(context)=>RegisterPage(),
        Explore.routeName:(context)=>Explore(),
        SearchPage.routeName:(context)=>SearchPage(),
        FilterSearchPage.routeName:(context) => FilterSearchPage(),
        WorkerProfile.routeName:(context) =>WorkerProfile(),
        Seemore.routeName:(context) =>Seemore(),
        CategoryResultPage.routeName:(context)=>CategoryResultPage(),
        
       },debugShowCheckedModeBanner: false,
       
    );
  }
}
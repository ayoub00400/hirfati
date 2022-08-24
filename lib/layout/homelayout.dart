import'package:flutter/material.dart';
import 'package:hirfati/modules/homepage/homepage.dart';
import 'package:hirfati/modules/login/loginpage.dart';
import 'package:hirfati/shared/storege_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeLayout extends StatelessWidget {
  //const OnboardingPages({Key? key}) : super(key: key);
  static final String routeName='HomeLayout';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: FutureBuilder(future:MyStorageHelper.Storageiniate() , builder:(context,AsyncSnapshot<SharedPreferences>  snapshot){
        if(snapshot.hasData){
          if(MyStorageHelper.obj.getString('auth_id')==null){
            return  LoginPage();
          }else{
            return HomePage();
          }        
        }else{
          return Center(child:Text('Somthing Wrong happend'));
        }
       } ),
    ));
  }
}
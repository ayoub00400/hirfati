import'package:flutter/material.dart';
import 'package:hirfati/modules/login/loginpage.dart';

import '../../shared/storege_helper.dart';
class ProfilePage extends StatelessWidget{

@override
Widget build(BuildContext context) {
    return Container(child:Center(child:ElevatedButton(onPressed: (){
      MyStorageHelper.obj.clear().then((value){
        if(value){
          Navigator.popAndPushNamed(context,LoginPage.routeName );
        }
      } );
    }, child: Text('log out'))));
  
}

  
}
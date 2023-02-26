import 'dart:convert';

import'package:flutter/material.dart';
import 'package:hirfati/main.dart';
import 'package:hirfati/modules/login/loginpage.dart';
import 'package:hirfati/shared/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../shared/storege_helper.dart';
class ProfilePage extends StatelessWidget{
  Map obj=jsonDecode(MyStorageHelper.obj.getString('user_data')!);
@override
Widget build(BuildContext context) {
  
  print(MyStorageHelper.obj.getString('user_data'));
    return SafeArea(
      child: Container(child:Column(crossAxisAlignment: CrossAxisAlignment.center, children:[
        SizedBox(height: 24),
        Text('Profile',style:TextStyle(fontSize: 23,fontWeight: FontWeight.w600)),SizedBox(height: 32,),
        CircleAvatar(backgroundColor: color_2.withOpacity(.4), minRadius: 65,child: Text(obj['name'][0].toUpperCase() ,style:TextStyle(color: Colors.black.withOpacity(.6), fontSize: 40,fontWeight: FontWeight.w500))),SizedBox(height: 10,),Text(obj['name'],style:TextStyle(color: Colors.black.withOpacity(.6), fontSize: 20,fontWeight: FontWeight.w500)),SizedBox(height: 36,),
        Container(margin: EdgeInsets.symmetric(horizontal: 18),width: double.infinity, decoration: BoxDecoration(color: Colors.grey.withOpacity(.1) , borderRadius: BorderRadius.circular(20)),child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(onTap: () async {
                Hirfati.myAuth.verifyPhoneNumber(phoneNumber:'+213658756955',timeout: Duration(seconds: 60),verificationCompleted: (phoneAuthCredential) {
                },verificationFailed: ((error) {
                  //print('error happend =====>'+error.message.toString());
                }),codeSent: (verificationId, forceResendingToken) {
                  
                  //PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
                },codeAutoRetrievalTimeout:(verificationId) {
                  
                }, );
              }, dense: true, leading: Container(height: 50,width: 50,decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),child: Icon(Icons.settings)), title: Text('Edit profile',style: TextStyle(fontSize:16),), trailing:Icon(Icons.arrow_forward_ios_rounded) ,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(onTap: (){}, dense: true, leading: Container(height: 50,width: 50,decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),child: Icon(Icons.heart_broken)), title: Text('Liked profiles',style: TextStyle(fontSize:16),), trailing:Icon(Icons.arrow_forward_ios_rounded) ,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(onTap: (){}, dense: true, leading: Container(height: 50,width: 50,decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),child: Icon(Icons.save)), title: Text('Saved profiles',style: TextStyle(fontSize:16),), trailing:Icon(Icons.arrow_forward_ios_rounded) ,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(onTap: (){}, dense: true, leading: Container(height: 50,width: 50,decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),child: Icon(Icons.info)), title: Text('About',style: TextStyle(fontSize:16),), trailing:Icon(Icons.arrow_forward_ios_rounded) ,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(onTap: (){}, dense: true, leading: Container(height: 50,width: 50,decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),child: Icon(Icons.question_mark)), title: Text('Q&A',style: TextStyle(fontSize:16),), trailing:Icon(Icons.arrow_forward_ios_rounded) ,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(onTap: (){
                MyStorageHelper.obj.clear().then((value){
        if(value){
          Navigator.popAndPushNamed(context,LoginPage.routeName );
        }
      } );
              }, dense: true, leading: Container(height: 50,width: 50,decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),child: Icon(Icons.logout_rounded)), title: Text('Logout',style: TextStyle(fontSize:16),), trailing:Icon(Icons.arrow_forward_ios_rounded) ,),
            ),
            
          ],
        ))
      ])),
    );
    
    /*Container(child:Center(child:ElevatedButton(onPressed: (){
      MyStorageHelper.obj.clear().then((value){
        if(value){
          Navigator.popAndPushNamed(context,LoginPage.routeName );
        }
      } );
    }, child: Text('log out'))))*/;
  
}

  
}
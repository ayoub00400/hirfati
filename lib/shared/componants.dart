import 'dart:convert';
import 'dart:ui';

import'package:flutter/material.dart';
import '../../shared/theme.dart';
import '../main.dart';
import '../modules/category/category.dart';
import '../modules/registerpage/registerpage.dart';



Widget workerListTileBuilder(Map<String,dynamic> workerData){
return Container(height: 100, child:Text(workerData['name']),);
}


Widget CategorieBuilder(String catIcon,String catTitle,BuildContext context){

return GestureDetector(onTap:(){
Navigator.of(context).pushNamed(CategoryResultPage.routeName,arguments:catTitle);
},child:Container(
  child:   Stack(children:[Container(margin:EdgeInsets.only(right:8,),height: 100,width: 100, decoration:BoxDecoration( color:Colors.purple[100], borderRadius: BorderRadius.circular(20)),)
    
    ,
  Container(margin:EdgeInsets.only(right:8,),height: 100,width: 100, decoration:BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end:  Alignment.bottomCenter, colors:[
    Colors.white.withOpacity(.06),Colors.white.withOpacity(.1),Colors.white.withOpacity(.2),Colors.white.withOpacity(.3)
  ]), borderRadius: BorderRadius.circular(20)), child:Column(
  
                mainAxisAlignment: MainAxisAlignment.center,
  
                children:[
  
                Image.asset('assets/icons/${catIcon}',height: 40,width:40,),
  
                SizedBox(height:6,),
  
                Flexible(fit:FlexFit.loose, child: Text(catTitle,softWrap: true,maxLines: 2,textAlign: TextAlign.center,overflow: TextOverflow.clip,style:TextStyle(fontSize:h3_txt-4 )))
  
              ]))]),
));
}



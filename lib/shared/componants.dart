import 'dart:convert';
import 'dart:ui';

import'package:flutter/material.dart';
import '../../shared/theme.dart';
import '../main.dart';
import '../modules/category/category.dart';
import '../modules/registerpage/registerpage.dart';



Widget workerListTileBuilder(Map<String,dynamic> workerData){
return GestureDetector(onTap: (){
  
},
  child:   Container(margin:EdgeInsets.symmetric(horizontal:10,vertical: 8),decoration:BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),  height: 100, child:Row(
  
    children: [
  
      Padding(
  
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
  
        child: CircleAvatar(backgroundColor: Colors.amber,radius: 40,child: Center(child:Text(workerData['name'].toString()[0],style: TextStyle(fontSize:40,)))),
  
      ),
  
          Expanded(
  
            child: Container(padding: EdgeInsets.only(top: 8,bottom: 8,left: 8),
  
              //color:Colors.red,
  
              child: Column(mainAxisAlignment:MainAxisAlignment.center , crossAxisAlignment: CrossAxisAlignment.start,
  
                children: [
  
                  Row(
  
                    children: [
  
                      Text(workerData['name'],style: TextStyle(fontSize:22,fontWeight: FontWeight.bold)),Spacer(),
  
                      Text('5',style: TextStyle(fontSize:18)),
  
                      Padding(
  
                        padding: const EdgeInsets.only(right:8.0),
  
                        child: Icon(Icons.star,color: Color.fromARGB(255, 235, 220, 85)),
  
                      ),
  
                    ],
  
                  ),SizedBox(height:10),
  
                Row(children: [Icon(Icons.pin),SizedBox(width: 5,), Text(workerData['daira'].toString().split(' ').last+','+workerData['wilaya'].toString().split(' ').last,style: TextStyle(fontSize:16))])
  
                ],
  
              ),
  
            ),
  
          ),
  
    ],
  
  ),),
);
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



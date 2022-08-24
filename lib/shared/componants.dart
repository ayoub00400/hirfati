import 'dart:ui';

import'package:flutter/material.dart';
import '../../shared/theme.dart';


Widget CategorieBuilder(String catIcon,String catTitle,Function catOnPressed){

return GestureDetector(onTap:(){},child:Container(
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




/*Widget TextFieldBuilder(TextEditingController Controller, String? Function(String?) validatorFunc,String hintTxt ){
  return Container(
                              height: 50,
                              child: TextFormField(
                                  //autovalidateMode:AutovalidateMode.always ,
                                  controller: Controller,
                                  validator:validatorFunc ,
                                  cursorColor: Colors.amber,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      hintText:hintTxt ,
                                      focusColor: Colors.amber,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  131, 243, 8, 231))),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)))),
                            );
}*/
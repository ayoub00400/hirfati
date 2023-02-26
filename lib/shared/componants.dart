import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import'package:flutter/material.dart';
import 'package:hirfati/modules/massanger/massanger.dart';
import 'package:hirfati/shared/storege_helper.dart';
import '../../shared/theme.dart';
import '../main.dart';
import '../modules/category/category.dart';
import '../modules/registerpage/registerpage.dart';
import '../modules/workerprofile/workerprofile.dart';



Widget workerListTileBuilder(BuildContext context,Map<String,dynamic> workerData){
return GestureDetector(onTap: (){
  Navigator.of(context).pushNamed(WorkerProfile.routeName,arguments:workerData );
},
  child:   Container(margin:EdgeInsets.symmetric(horizontal:10,vertical: 8),decoration:BoxDecoration(color: Colors.deepPurple.withOpacity(.2), borderRadius: BorderRadius.circular(20)),  height: 100, child:Row(
  
    children: [
  
      Padding(
  
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
  
        child: CircleAvatar(backgroundColor: Colors.deepPurple.withOpacity(.4),radius: 40,child: Center(child:Text(workerData['name'].toString()[0],style: TextStyle(fontSize:40,)))),
  
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


Widget workerListTileBuilder1(BuildContext context,Map<String,dynamic> workerData){
return GestureDetector(onTap: (){
  Navigator.of(context).pushNamed(WorkerProfile.routeName,arguments:workerData );
},
  child:   Container(margin:EdgeInsets.symmetric(horizontal:10,vertical: 8),decoration:BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),  height: 100, child:Row(
  
    children: [
  
      Padding(
  
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
  
        child: CircleAvatar(backgroundColor: Colors.deepPurple.withOpacity(.4),radius: 40,child: Center(child:Text(workerData['name'].toString()[0],style: TextStyle(fontSize:40,)))),
  
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
Navigator.of(context).pushNamed(CategoryResultPage.routeName,arguments:{"job":catTitle,"icon":catIcon});
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
  
                Flexible(fit:FlexFit.loose, child: Text(catTitle[0].toUpperCase()+catTitle.substring(1,catTitle.length),softWrap: true,maxLines: 2,textAlign: TextAlign.center,overflow: TextOverflow.clip,style:TextStyle(fontSize:h3_txt-4 )))
  
              ]))]),
));
}
Widget  MassageBuilder(Map<String,dynamic> data){
if(data['from']==MyStorageHelper.obj.getString('auth_id')){
  return  Container(
    child: Row(
      children: [
        ConstrainedBox(constraints: BoxConstraints(maxWidth:300), child: Container( margin: EdgeInsets.symmetric(vertical: 8,horizontal:8),decoration:BoxDecoration( color:color_5.withOpacity(.5),borderRadius: BorderRadius.only(bottomRight:Radius.circular(20),topLeft:Radius.circular( 20),topRight:Radius.circular( 20))),child:Padding(padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8), child: Text(data['content'].toString(),style: TextStyle(fontSize:18),)))),
      Spacer()
      ],
    ),
  );
}else{
 return Container(
    child: Row(
      children: [Spacer(),
        ConstrainedBox(constraints: BoxConstraints(maxWidth:300), child: Container( margin: EdgeInsets.symmetric(vertical: 8,horizontal:8),decoration:BoxDecoration( color:Colors.grey.withOpacity(.5),borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20),topLeft:Radius.circular( 20),topRight:Radius.circular( 20))),child:Padding(padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8), child: Text(data['content'].toString(),style: TextStyle(fontSize:18),)))),
      
      ],
    ),
  );
}
}
 Widget chatBuider(BuildContext context,String chatId){
    return  FutureBuilder(future: Hirfati.myFirestore.collection('users').doc(chatId).get() , builder: (context,AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
      if(snapshot.hasData&&snapshot.data!.data()!=null){
        
        
        return GestureDetector(onTap: (){
  Navigator.of(context).pushNamed(MassangerPage.routeName,arguments:{'user_infos':snapshot.data!.data()} );
},
  child:   Container(margin:EdgeInsets.symmetric(horizontal:10,vertical: 8),decoration:BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),  height: 100, child:Row(
  
    children: [
  
      Padding(
  
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
  
        child: CircleAvatar(backgroundColor: Colors.deepPurple.withOpacity(.4),radius: 40,child: Center(child:Text(snapshot.data!.data()!['name'].toString()[0],style: TextStyle(fontSize:40,)))),
  
      ),
  
          Expanded(
  
            child: Container(padding: EdgeInsets.only(top: 8,bottom: 8,left: 8),
  
              //color:Colors.red,
  
              child: Column(mainAxisAlignment:MainAxisAlignment.center , crossAxisAlignment: CrossAxisAlignment.start,
  
                children: [
  
                  Row(
  
                    children: [
  
                      Text(snapshot.data!.data()!['name'],style: TextStyle(fontSize:22,fontWeight: FontWeight.bold)),Spacer(),
  
                      
                      
                    ],
  
                  ),SizedBox(height:10),
  
                
  
                ],
  
              ),
  
            ),
  
          ),
  
    ],
  
  ),),
);

      }else{
        return Container(child:null);
      }
    },);






}
Widget profileSettingsItemBuilder(BuildContext context,String itemName ,IconData icon,Function myFunc){
return Container( child: Row(children: [
  Container(),
  Text(itemName), 
]),);
}



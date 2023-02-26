import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hirfati/main.dart';
import 'package:hirfati/modules/homepage/cubit/chat_cubit.dart';
import 'package:hirfati/modules/homepage/cubit/chat_state.dart';
import 'package:hirfati/shared/componants.dart';
import 'package:hirfati/shared/storege_helper.dart';

class MassagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatsCubit()..loadChats(),
      child: BlocBuilder<ChatsCubit, ChatsState>(
        builder: (context, state) {
          if(BlocProvider.of<ChatsCubit>(context).chats==null||state is ChatsLoading){
             return 
               Container(
                  child: 
                            Center(child:CircularProgressIndicator(color: Color.fromARGB(255,41, 38, 128).withOpacity(.8),)));
             
          }
         
                         else {

                          if(state is ChatsLoadingDone  ){
return 
              Container(
                  child:ListView(children: BlocProvider.of<ChatsCubit>(context).chats!.map((e) => chatBuider(context,e)).toList() as List<Widget>,)
                        ,
             );
                          }else{
                            return Container(
                  child: 
                            Center(child:Text('error ')));
                          }
                         
                        }
                      
        
  })
    );
  }
}

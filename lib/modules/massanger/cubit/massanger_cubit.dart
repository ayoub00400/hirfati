import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hirfati/main.dart';
import 'package:hirfati/shared/storege_helper.dart';
import 'package:meta/meta.dart';

part 'massanger_state.dart';

class MassangerCubit extends Cubit<MassangerState> {
  List<Map<String,dynamic>>messages=[];
  MassangerCubit() : super(MassangerInitial());
  getMassages(String chatId){
    emit(MassagesLoading());
    Hirfati.myFirestore.collection('users').doc(MyStorageHelper.obj.getString('auth_id')).collection('chats').doc(chatId).collection('messages').get().then((value){
value.docs.forEach((element) {messages.add(element.data());});

    }).then((value) =>emit(MassagesLoadingDone())).catchError((onError)=>emit(MassagesLoadingFailed()));
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages1(String chatId){
   return Hirfati.myFirestore.collection('users').doc(MyStorageHelper.obj.getString('auth_id')).collection('chats').doc(chatId).collection('messages').orderBy('time').snapshots();

  }
  sendMessage(String chatId,String msg,DateTime msgTiming){
    
     Hirfati.myFirestore.collection('users').doc(chatId).collection('chats').doc(MyStorageHelper.obj.getString('auth_id')).collection('messages').add({
      'from':MyStorageHelper.obj.get('auth_id'),
      'content':msg,
      'time':msgTiming.toString()
    }).then((value) {
      Hirfati.myFirestore.collection('users').doc(chatId).collection('chats').doc(MyStorageHelper.obj.getString('auth_id')).set({'gg':1});
    });
    Hirfati.myFirestore.collection('users').doc(MyStorageHelper.obj.getString('auth_id')).collection('chats').doc(chatId).collection('messages').add({
      'from':MyStorageHelper.obj.get('auth_id'),
      'content':msg,
      'time':msgTiming
    }).then((value) {
      Hirfati.myFirestore.collection('users').doc(MyStorageHelper.obj.getString('auth_id')).collection('chats').doc(chatId).set({
        'gg':1
      });
    });
  }
}

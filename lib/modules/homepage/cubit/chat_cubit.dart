import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hirfati/main.dart';
import 'package:hirfati/modules/homepage/cubit/chat_state.dart';
import 'package:hirfati/shared/storege_helper.dart';

class ChatsCubit extends Cubit<ChatsState>{
  List<String>? chats;
  ChatsCubit() : super(initialState());
  loadChats(){
    emit(ChatsLoading());
    Hirfati.myFirestore
        .collection('users')
        .doc(MyStorageHelper.obj.getString('auth_id'))
        .collection('chats')
        .get().then((value) { 
          print("gggggggggggggggg"+value.docs[0].id.toString());
          chats=value.docs.map((e) =>e.id).toList();
          emit(ChatsLoadingDone());
          }).catchError((error) => emit(ChatsLoadingFailed()));
  }

  
}
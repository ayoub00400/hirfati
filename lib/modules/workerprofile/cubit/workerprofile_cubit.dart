import 'package:bloc/bloc.dart';
import 'package:hirfati/main.dart';
import 'package:hirfati/shared/storege_helper.dart';
import 'package:meta/meta.dart';
import'package:flutter/material.dart';
import'dart:convert';
part 'workerprofile_state.dart';

class WorkerprofileCubit extends Cubit<WorkerprofileState> {
  Color likeButtonColor=Colors.purple;
  int likes=0;
  Map storedUserData = json.decode(MyStorageHelper.obj.getString('user_data')!);
  WorkerprofileCubit() : super(WorkerprofileInitial());
   checkLikedOrNot(String workerUid){
    
    //emit(Workerprofile1());
    
        print("1111111111111111111111"+storedUserData['uid'].toString());
     Hirfati.myFirestore.collection('users').doc(workerUid).collection('likes').doc(storedUserData['uid'].toString()).get().then((value) {
      print("000000000000000"+value.data().toString());
      if(value.data()==null){
         Hirfati.myFirestore.collection('users').doc(workerUid).collection('likes').get().then((value){
          likes=value.docs.length;
            print(value.docs.length);
            emit(NotLiked());
         });
        
      }else{
        likeButtonColor=Colors.red;
         Hirfati.myFirestore.collection('users').doc(workerUid).collection('likes').get().then((value){
          likes=value.docs.length;
            print(value.docs.length);
            emit(AlreadyLiked());
         });
         
      }
      
     }).catchError((error)=>print('777777777777777777'+error.toString()));
  }
  changeLikeButtonColor(String workerUid){
    
      
      Hirfati.myFirestore.collection('users').doc(workerUid).collection('likes').doc(storedUserData['uid'].toString()).delete().then((value) { print('like deleted');
     likes-=1;
      emit(LikeRemouved());
      });}
    changeLikeButtonColor1(String workerUid){
      likes+=1;
      Hirfati.myFirestore.collection('users').doc(workerUid).collection('likes').doc(storedUserData['uid'].toString()).set({}).then((value) {
    
    emit(LikeAdded());
      });

    }
    //print('{{{{{{{{{{{{{{{{#########################################');
      //Hirfati.myFirestore.collection('users').doc(workerUid).collection('likes').get();
   
  }



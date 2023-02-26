import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hirfati/modules/login/loginpage.dart';
import 'package:hirfati/modules/registerpage/emailregistrationcheck..dart';
import 'package:meta/meta.dart';

import '../../../main.dart';
import '../../../shared/storege_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  loginUser({required String email, required String password}) {
    emit(LoginLoading());
    Hirfati.myAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value1) {
          if(value1.user!.emailVerified!=true){
            emit(LoginDoneUserNotVerified());
          }else{
            Hirfati.myFirestore.collection('users').doc(value1.user!.uid.toString()).get().then((value){
            
             MyStorageHelper.obj
              .setString('user_data',
                 jsonEncode(value.data())  )
              .then((value) {
                 emit(LoginDoneUserVerified());
              });
          });
      MyStorageHelper.obj.setString('auth_id', value1.user!.uid).then((value) {
        if (value) {
         
        } else {
          emit(LoginFailed('something wrong please try again !'));
        }
        ;
      });
          }
          

    }).catchError((e) => emit(LoginFailed("Wrong email or password.")));
  }

  signUpNewWorker(
      {required String email,
      required String password,
      required String name,required LatLng userLocationCord,
      required String phoneNumber,required String madina,required String daira,required String wilaya,required List<String>?jobs}) async {
    emit(RegisterLoading());
    Hirfati.myAuth
        .createUserWithEmailAndPassword( email: email, password: password)
        .then((value1) {
      
        Hirfati.myFirestore.collection('users').doc(value1.user!.uid.toString()).
            
            set({
              'uid':value1.user!.uid.toString(),
          'email': email,
          'password': password,
          'name': name,
          'phonenumber': phoneNumber,
          'user_type':'worker',
          'madina':madina,
          'daira':daira,
          'wilaya':wilaya,
          'jobs':jobs,'locationlant':userLocationCord.latitude,
          'locationlong':userLocationCord.longitude,
          
        }).then((value) {
         
                  emit(RegisterDone());
               
        }).catchError(
                (error) => emit(RegisterFailed('error happend ,try again')));
      });
    
  }

  signUpNewUser(
      {required String email,
      required BuildContext context,
      required String password,
      required String name,
      }) async {
    emit(RegisterLoading());
   
    Hirfati.myAuth
        .createUserWithEmailAndPassword( email: email, password: password)
        .then((value1) {
          print(Hirfati.myAuth.currentUser!.email.toString());
        value1.user!.sendEmailVerification().then((value){
          Navigator.of(context).popAndPushNamed(EmailCkeckPage.routeName,arguments: [LoginPage.routeName]);
        });
      
      }).catchError(
                ( error) {
                  var error1=error as FirebaseException;
                  emit(RegisterFailed(error1.message. toString()));});
    
  }
}

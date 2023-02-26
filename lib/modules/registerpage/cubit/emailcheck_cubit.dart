import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hirfati/main.dart';
import 'package:meta/meta.dart';

import '../emailregistrationcheck..dart';

part 'emailcheck_state.dart';

class EmailcheckCubit extends Cubit<EmailcheckState> {
bool isVerified=false;
  EmailcheckCubit() : super(EmailcheckInitial());
  checkEmailVerfication(){
    Timer.periodic(Duration(seconds:3 ),(timer) {
      EmailCkeckPage.myTimer=timer;
      Hirfati.myAuth.currentUser!.reload();
      print('Timer working'+Hirfati.myAuth.currentUser!.emailVerified.toString());
      if(Hirfati.myAuth.currentUser!. emailVerified){
        isVerified=Hirfati.myAuth.currentUser!.emailVerified;
        EmailCkeckPage.myTimer.cancel();
       /* Hirfati.myFirestore.collection('users').doc(Hirfati.myAuth.currentUser!.uid.toString()).set({
          'email': email,
          'password': password,
          'name': name,
          'user_type':'user',
         
        }).catchError(
               (error)=>null);*/
        emit(VerificationDone());
      }
    },);
    
    
  }
}

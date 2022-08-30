import 'package:bloc/bloc.dart';
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
          Hirfati.myFirestore.collection('users').doc(value1.user!.uid.toString()).get().then((value){
            
             MyStorageHelper.obj
              .setString('user_data',
                 value.data().toString() )
              .then((value) {
              });
          });
      MyStorageHelper.obj.setString('auth_id', value1.user!.uid).then((value) {
        if (value) {
          emit(LoginDone());
        } else {
          emit(LoginFailed('something wrong please try again !'));
        }
        ;
      });

    }).catchError((e) => emit(LoginFailed("Wrong email or password.")));
  }

  signUpNewWorker(
      {required String email,
      required String password,
      required String name,
      required String phoneNumber,required String madina,required String daira,required String wilaya,required List<String>?jobs}) async {
    emit(RegisterLoading());
    Hirfati.myAuth
        .createUserWithEmailAndPassword( email: email, password: password)
        .then((value1) {
      
        Hirfati.myFirestore.collection('users').doc(value1.user!.uid.toString()).
            
            set({
          'email': email,
          'password': password,
          'name': name,
          'phonenumber': phoneNumber,
          'user_type':'worker',
          'madina':madina,
          'daira':daira,
          'wilaya':wilaya,
        }).then((value) {
         
                  emit(RegisterDone());
               
        }).catchError(
                (error) => emit(RegisterFailed('error happend ,try again')));
      });
    
  }

  signUpNewUser(
      {required String email,
      required String password,
      required String name,
      }) async {
    emit(RegisterLoading());
    Hirfati.myAuth
        .createUserWithEmailAndPassword( email: email, password: password)
        .then((value1) {
      
        Hirfati.myFirestore.collection('users').doc(value1.user!.uid.toString()).set({
          'email': email,
          'password': password,
          'name': name,
          'user_type':'user',
         
        }).then((value) {
         
                  emit(RegisterDone());
               
        }).catchError(
                (error) => emit(RegisterFailed('error happend ,try again')));
      });
    
  }
}

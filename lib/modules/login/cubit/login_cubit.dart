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

  signInNewUser(
      {required String email,required int buttom_id,
      required String password,
      required String name,
      String phoneNumber = "",String madina="",String daira="",String wilaya="",List<String>?jobs=null}) async {
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
          
          'user_type':buttom_id==1?'normal_user':'worker',
        }).then((value) {
         
                  emit(RegisterDone());
               
        }).catchError(
                (error) => emit(RegisterFailed('error happend ,try again')));
      });
    
  }
}

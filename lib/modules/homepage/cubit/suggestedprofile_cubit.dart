import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:hirfati/main.dart';
import 'package:meta/meta.dart';
import'dart:math' as m;
part 'suggestedprofile_state.dart';

class SuggestedprofileCubit extends Cubit<SuggestedprofileState> {
List suggestedProfilesList=[];
  SuggestedprofileCubit() : super(SuggestedprofileInitial());
  GetSuggestedProfilesList(){
    print("0000000000000000000000");
   Hirfati.myFirestore.collection('users').where('user_type',isEqualTo: 'worker').limit(200).get().then((value) {
    value.docs.forEach((element) { suggestedProfilesList.add(element.data()); 
    }) ;
    /*.map((element) {
     print(element.data());*/
     /* 
       Hirfati.myFirestore.collection('users'). doc(element.data()['uid']).collection('likes').get().then((value){
          if(value.docs.length>=50 ){
            suggestedProfilesList.add(element.data());
          }
            
         });


    });*/
    
     
   

   
   
   emit(Done());
});}}

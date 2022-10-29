import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../main.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  List workersList=[];
  CategoryCubit() : super(CategoryInitial());
  loadWorkerList(String jobName){
    emit(CatSearchResultLoading());
    workersList.clear();
    Hirfati.myFirestore.collection('users').where("jobs",arrayContains:jobName ).get().then((value) {
      
  value.docs.forEach((element) {workersList.add(element.data());});
  //print(workersList);
  emit(CatSearchResultDone());
} ).catchError((error)=>emit(CatSearchResultFailed()));
  }
  loadFiltredWorkerList(String jobName,String wiayaValue){
    emit(CatSearchResultLoading());
    workersList.clear();
    
    Hirfati.myFirestore.collection('users').where("jobs",arrayContains:jobName ).where("wilaya",isEqualTo:wiayaValue).get().then((value) {
      
  value.docs.forEach((element) {workersList.add(element.data());});
  print("zzzzzzz Russia zzzzzzzz"+workersList.toString());
  emit(CatSearchResultDone());
} ).catchError((error)=>emit(CatSearchResultFailed()));
  }
}

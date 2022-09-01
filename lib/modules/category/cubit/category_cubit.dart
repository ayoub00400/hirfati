import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../main.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  List<Map<String,dynamic>> workersList=[];
  CategoryCubit() : super(CategoryInitial());
  loadWorkerList(String jobName){
    emit(CatSearchResultLoading());
    workersList.clear();
    Hirfati.myFirestore.collection('users').where("jobs",arrayContains:jobName ).get().then((value) {
  value.docs.map((e) =>workersList.add(e.data()));
  emit(CatSearchResultDone());
} ).catchError((error)=>emit(CatSearchResultFailed()));
  }
}

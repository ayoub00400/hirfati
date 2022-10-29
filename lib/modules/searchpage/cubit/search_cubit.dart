import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../main.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  List workersList=[];
  SearchCubit() : super(SearchInitial());
  loadSearchWorkerList(String chosenLocation){
    emit(SearchResultLoading());
    workersList.clear();
    Hirfati.myFirestore.collection('users').where("wilaya",isEqualTo :chosenLocation).get().then((value) {
  value.docs.forEach((element) {
    workersList.add(element.data());});
  //print(workersList);
  emit(SearchResultDone());
} ).catchError((error)=>emit(SearchResultFailed()));
  }
//////////////////
loadFiltredWorkerList(List<String>jobName,String wiayaValue){
    emit(SearchResultLoading());
    workersList.clear();
    
    Hirfati.myFirestore.collection('users').where("jobs",arrayContainsAny:jobName ).where("wilaya",isEqualTo:wiayaValue).get().then((value) {
      
  value.docs.forEach((element) {workersList.add(element.data());});
  print("zzzzzzz Russia zzzzzzzz"+workersList.toString());
  emit(SearchResultDone());
} ).catchError((error)=>emit(SearchResultFailed()));
  }




}

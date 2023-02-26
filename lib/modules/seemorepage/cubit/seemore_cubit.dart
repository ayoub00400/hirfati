import 'package:bloc/bloc.dart';
import 'package:hirfati/jobs.dart';
import 'package:meta/meta.dart';

part 'seemore_state.dart';

class SeemoreCubit extends Cubit<SeemoreState> {
  List<Map<String, String>> jobsList=jobData;
  SeemoreCubit() : super(SeemoreInitial());

  SearchForService(String serviceTitle){
    print(serviceTitle);
    print(jobsList);
    if(serviceTitle==''){
      jobsList=jobData;
      emit(SearchJobChanged());
    }else{
    jobsList=jobData.where((element) {
     return  element['jobtitle']!.startsWith(serviceTitle);
       
      
      
  }).toList();
  
  emit(SearchJobChanged());
  }
  }
}

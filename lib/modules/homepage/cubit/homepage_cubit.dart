import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  int navBarIndex=0;
  HomepageCubit() : super(HomepageInitial());
  changePage(int index){
    navBarIndex=index;
    emit(PageChanged());
    
  }
}

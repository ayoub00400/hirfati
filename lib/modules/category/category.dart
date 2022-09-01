import'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/componants.dart';
import 'cubit/category_cubit.dart';
class CategoryResultPage extends StatefulWidget{
  static String routeName='CategoryResultPage';

  @override
   _CategoryResultPageState createState() {
    return _CategoryResultPageState();
  }
}
class _CategoryResultPageState extends State<CategoryResultPage> {
String? paramPassed;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    paramPassed=ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (context) => CategoryCubit()..loadWorkerList(paramPassed!),
      child: Scaffold(appBar: AppBar(),body:SafeArea(child:BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if(state is CatSearchResultLoading){
            return Center(child:CircularProgressIndicator());
          }else{
            if(state is CatSearchResultDone ){
              if(BlocProvider.of<CategoryCubit>(context).workersList.isEmpty){
                return Center(child:Text('Ohhhhh no there is no results '));
              }else{
                return ListView.builder(itemCount:BlocProvider.of<CategoryCubit>(context).workersList.length , itemBuilder: ((context, index) {
                return workerListTileBuilder(BlocProvider.of<CategoryCubit>(context).workersList[index]);
                
              }),);
              }
              

            }else{
              return  Center(child:Text('Something Wrong try again '));
            }
          }
          
        },
      ))),
    );
  }
}
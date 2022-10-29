import'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/componants.dart';
import '../../shared/theme.dart';
import '../integratedsearch/searchhome.dart';
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
      child:BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {return Scaffold(appBar: AppBar(actions: [
        IconButton(onPressed: (){
          Navigator.of(context).pushNamed(FilterSearchPage.routeName,arguments: paramPassed).then((value) => BlocProvider.of<CategoryCubit>(context).loadFiltredWorkerList(paramPassed!, value.toString()));
        }, icon: Icon(Icons.filter_alt))
      ]), body:
          state is CatSearchResultLoading?
           Center(child: CircularProgressIndicator())
          :state is CatSearchResultFailed?Center(child: Text('There is somthing wrong')):
           SafeArea(child: 
            BlocProvider.of<CategoryCubit>(context).workersList.isEmpty?Center(child: Text('No Result found.',style: TextStyle(fontSize:20),)):
            
            ListView(children:
             
             BlocProvider.of<CategoryCubit>(context).workersList.map((e) =>workerListTileBuilder(e)).toList(),)
            )
        
      ); })

    );
  }
}
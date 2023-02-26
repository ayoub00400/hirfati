import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/componants.dart';
import '../../shared/theme.dart';
import '../integratedsearch/searchhome.dart';
import 'cubit/category_cubit.dart';

class CategoryResultPage extends StatefulWidget {
  static String routeName = 'CategoryResultPage';

  @override
  _CategoryResultPageState createState() {
    return _CategoryResultPageState();
  }
}

class _CategoryResultPageState extends State<CategoryResultPage> {
  Map<String, String> paramPassed = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    paramPassed =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return BlocProvider(
        create: (context) =>
            CategoryCubit()..loadWorkerList(paramPassed["job"]!.toString()),
        child: BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
          return Scaffold(
              body: SafeArea(
            child: Container(
              child: Stack(
                children: [
                  Center(
                      child: Image(
                    image: AssetImage('assets/icons/' + paramPassed["icon"]!),
                    width: 180,
                    height: 180,
                  )),
                  Column(children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Row(children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.arrow_back_ios_new)),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(FilterSearchPage.routeName,
                                      arguments: paramPassed["job"])
                                  .then((value) =>
                                      BlocProvider.of<CategoryCubit>(context)
                                          .loadFiltredWorkerList(
                                              paramPassed['job']!,
                                              value.toString()));
                            },
                            icon: Icon(Icons.filter_alt)),
                      ]),
                    ),
                    Flexible(
                      child: Container(
                        color: Colors.white.withOpacity(.92),
                        child: state is CatSearchResultLoading
                            ? Center(child: CircularProgressIndicator())
                            : state is CatSearchResultFailed
                                ? Center(child: Text('There is somthing wrong'))
                                : BlocProvider.of<CategoryCubit>(context)
                                        .workersList
                                        .isEmpty
                                    ? Center(
                                        child: Text(
                                        'No Result found.',
                                        style: TextStyle(fontSize: 20),
                                      ))
                                    : ListView(
                                        children: BlocProvider.of<
                                                CategoryCubit>(context)
                                            .workersList
                                            .map((e) => workerListTileBuilder(
                                                context, e))
                                            .toList(),
                                      ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ));
        }));
  }
}

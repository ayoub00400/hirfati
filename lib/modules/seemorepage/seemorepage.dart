import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hirfati/jobs.dart';
import 'package:hirfati/modules/seemorepage/cubit/seemore_cubit.dart';
import 'package:hirfati/shared/componants.dart';

class Seemore extends StatelessWidget {
  //const Seemore({Key? key}) : super(key: key);
  static String routeName = 'SeeMorePage';
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SeemoreCubit(),
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text('Services',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w800)),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ))),
        body: SafeArea(
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: BlocBuilder<SeemoreCubit, SeemoreState>(
                builder: (context, state) {
                  return TextFormField(
                      
                      onChanged: (value) {
                        BlocProvider.of<SeemoreCubit>(context)
                            .SearchForService(value);
                      },
                      cursorColor: Colors.purple,
                      decoration: InputDecoration(
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          isDense: true,
                          hintText: 'Search for Service',
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(131, 243, 8, 231))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))));
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: BlocBuilder<SeemoreCubit, SeemoreState>(
                builder: (context, state) {
                  return Container(
                      margin: EdgeInsets.only(left: 10),
                      child: GridView(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 1.1),
                        children: BlocProvider.of<SeemoreCubit>(context)
                            .jobsList
                            .map((e) => CategorieBuilder(
                                e['img_path']!, e['jobtitle']!, context))
                            .toList(),
                      ));
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

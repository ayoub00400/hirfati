import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hirfati/modules/massanger/cubit/massanger_cubit.dart';
import 'package:hirfati/shared/componants.dart';
import 'package:hirfati/shared/theme.dart';

class MassangerPage extends StatelessWidget {
  //const MassangerPage({Key? key}) : super(key: key);
  static final String routeName = '/massangerpage';
  TextEditingController massagesConttroller = TextEditingController();
  late Map<String, dynamic> userInfos;
  @override
  Widget build(BuildContext context) {
    userInfos =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        print(userInfos['user_infos']['uid'].toString());

    return BlocProvider(
      create: (context) =>
          MassangerCubit() /*..getMassages(userInfos['user_infos'])*/,
      child: Scaffold(
          body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [SizedBox(height: 70)
,                /*BlocBuilder<MassangerCubit, MassangerState>(
                  builder: (context, state) {
                    if(state is MassagesLoading){
                      return Expanded(
                        child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: CircularProgressIndicator(),
                    ));
                    }else{
                      if(state is  MassagesLoadingDone ){
                        if(BlocProvider.of<MassangerCubit>(context).messages.isEmpty){
                           return Expanded(
                        child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child:Center(child:Text('New chat here')) ,
                    ));
                        }else{
                           return Expanded(
                        child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child:ListView(children:) ,
                    ));
                        }
                      }else{
                      return Expanded(
                        child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child:Center(child:Text('Something wants Wrong ,try again later')) ,
                    ));}
                    }
                    
                  },
                )*/
                Expanded(
                  child: BlocBuilder<MassangerCubit, MassangerState>(
                    builder: (context, state) {
                      return Container(
                        child: StreamBuilder(
                            stream: BlocProvider.of<MassangerCubit>(context)
                                .getMessages1(userInfos['user_infos']['uid'].toString()),
                            builder: (context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (snapshot.hasData) {
                                if(snapshot.data!.docs.isNotEmpty){
                               
                                return ListView(children:snapshot.data!.docs.map((e) =>MassageBuilder(e.data())).toList());
                                 
                              }else{
                                 return Center(
                                  child: Text('Send message to worker'),
                                );
                              }} else {
                                return Center(
                                  child:CircularProgressIndicator(),
                                );
                              }
                            }),
                      );
                    },
                  ),
                ),
                Container(
                  height: 70,
                  width: double.maxFinite,
                  color: color_5.withOpacity(.02),
                  child: Row(children: [
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 50,
                        child: TextFormField(
                            controller: massagesConttroller,
                            cursorColor: color_5,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true,
                                hintText: 'Email:',
                                focusColor: color_5,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: color_5)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                      ),
                    ),
                    BlocBuilder<MassangerCubit, MassangerState>(
                      builder: (context, state) {
                        return IconButton(
                            onPressed: () {
                              if(massagesConttroller.text.isNotEmpty){
                              String msg=massagesConttroller.text;
                              massagesConttroller.text='';
                              BlocProvider.of<MassangerCubit>(context).sendMessage(userInfos['user_infos']['uid'].toString(),msg, DateTime.now());
                            }},
                            icon: Icon(
                              Icons.send,
                              color: color_4,
                            ));
                      },
                    )
                  ]),
                )
              ],
            ),
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    spreadRadius: 2,
                    blurRadius: 40,
                    offset: Offset(0, 10))
              ]),
              child: Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios)),
                  SizedBox(
                    width: 8,
                  ),
                  CircleAvatar(
                    minRadius: 25,
                    backgroundColor: Colors.blue,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    userInfos['user_infos']['name'].toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Icon(
                    Icons.info_outline,
                    size: 25,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

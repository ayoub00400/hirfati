import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hirfati/main.dart';
import 'package:hirfati/modules/login/loginpage.dart';
import 'package:hirfati/modules/registerpage/cubit/emailcheck_cubit.dart';

import '../../shared/theme.dart';
class EmailCkeckPage extends StatefulWidget {
  static late Timer myTimer; 
  static final String routeName = 'EmailCheckPage';
  @override
  _EmailCkeckPage createState() => _EmailCkeckPage();
}



class _EmailCkeckPage extends State<EmailCkeckPage> with WidgetsBindingObserver {
  //const EmailCkeckPage({Key? key}) : super(key: key);
  
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);}

    didChangeAppLifecycleState(AppLifecycleState state){
      if(state == AppLifecycleState.paused){
        print('App Paused ');
      }
      if(state == AppLifecycleState.resumed){
        print('App Resumed');
      }
      if(state == AppLifecycleState.detached){
        print('App Detached');
      }
    }

  @override
  Widget build(BuildContext context) {
    
    List args = ModalRoute.of(context)!.settings.arguments as List;

    return BlocProvider(
      create: (context) => EmailcheckCubit()..checkEmailVerfication(),
      child: BlocListener<EmailcheckCubit, EmailcheckState>(
        listener: (context, state) {
          if (state is VerificationDone) {
            Future.delayed(
              Duration(seconds: 3),
              () => Navigator.of(context).popAndPushNamed(args[0]),
            );
          }
        },
        child: WillPopScope(onWillPop: () async {
          return false;
        },
          child: Scaffold(
            body: SafeArea(
                child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding:EdgeInsets.all(8.0),child:Image(image:AssetImage('assets/images/verification.png'),height: 200,width: 200,)), SizedBox(
                    height: 18,
                  ),
                  Text('Email Verification:'
                        ,
                        style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),
                      )
                    ,
                  
                  SizedBox(
                    height: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                        'we send a verification link ,please check your email to complete the signup process...',
                        style: TextStyle(fontSize: 18,color: Colors.grey.withOpacity(.9)),textAlign: TextAlign.center,),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  BlocBuilder<EmailcheckCubit, EmailcheckState>(
                    builder: (context, state) {
                      if (state is VerificationDone) {
                        return Icon(
                          Icons.check,
                          color: Colors.green,
                        );
                      } else {
                        return Container(
                          child: Column(
                            children: [
                              CircularProgressIndicator(color:color_5),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Waiting for verification...')
                            ],
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    
    super.dispose();
    print('I"m disposed and i do what you order from me ');
    Hirfati.myAuth.currentUser!.delete();
    EmailCkeckPage.myTimer.cancel();
  }
}

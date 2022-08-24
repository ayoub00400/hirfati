import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/theme.dart';
import '../login/cubit/login_cubit.dart';

class RegisterPage extends StatefulWidget {
  static final String routeName = 'RegisterPage';
  @override
  _RegisterPageState createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  //const OnboardingPages({Key? key}) : super(key: key);

  TextEditingController nameFieldController = TextEditingController();

  TextEditingController emailFieldController = TextEditingController();

  TextEditingController passwordFieldController = TextEditingController();
  TextEditingController name1FieldController = TextEditingController();

  TextEditingController email1FieldController = TextEditingController();

  TextEditingController password1FieldController = TextEditingController();
  var myFormKey1 = GlobalKey<FormState>();
  var myFormKey2 = GlobalKey<FormState>();
  TextEditingController phoneFieldController = TextEditingController();
  late TabController myTabBarController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myTabBarController = TabController(length: 2, vsync: this,initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
      create: (context) => LoginCubit(),
      child:  BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is RegisterDone) {
              Navigator.of(context).pop(state);
            } else {
              if (state is LoginFailed) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Text(state.error),
                        ));
              } else {}
            }
          },
          child:Container(
            child: Column(
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color.fromARGB(106, 209, 209, 209)),
                child: TabBar(
                  
                  onTap:(value){

                  } ,
                  unselectedLabelColor:Colors.grey ,
                    labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),
                    controller: myTabBarController,
                    indicator: BoxDecoration(
                        color: Colors.amber[200],
                        borderRadius: BorderRadius.circular(25)),
                    labelColor: Colors.black,
                    tabs: [
                      Container(padding: EdgeInsets.all(10), child: Text('User')),
                      Container(
                          padding: EdgeInsets.all(10), child: Text('Worker')),
                    ]),
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(physics:BouncingScrollPhysics() ,   controller: myTabBarController, children: [
                     SingleChildScrollView(
                       child: Container(padding: EdgeInsets.symmetric(horizontal:10),
                         child: Form(
                          key: myFormKey1,
                          child: Column(children: [
                                         SizedBox(
                          height: 60,
                                         ),
                                         Image.asset(
                          "assets/images/person.png",
                          width: 180,
                                         ),
                                         SizedBox(
                          height: 30,
                                         ),
                                         Text('Register Panel',
                            style: TextStyle(
                                fontSize: h1_txt + 10,
                                fontWeight: FontWeight.bold)),
                                         SizedBox(
                          height: 40,
                                         ),
                                         Container(
                          height: 50,
                          child: TextFormField(
                              //autovalidateMode:AutovalidateMode.always ,
                              controller: nameFieldController,
                              validator: (_) {
                                if (nameFieldController.text == '') {
                                  return 'empty field';
                                }
                              },
                              cursorColor: Colors.amber,
                              decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Name,Lastname:',
                                  focusColor: Colors.amber,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(131, 243, 8, 231))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)))),
                                         ),
                                         SizedBox(
                          height: 20,
                                         ),
                                         Container(
                          height: 50,
                          child: TextFormField(
                              //autovalidateMode:AutovalidateMode.always ,
                              controller: emailFieldController,
                              validator: (_) {
                                if (emailFieldController.text == '') {
                                  return 'empty field';
                                } else {
                                  if (!RegExp('[a-z0-9]+@[a-z]+\.[a-z]{2,3}')
                                      .hasMatch(emailFieldController.text)) {
                                    return 'Wrong email format';
                                  } else {
                                    return null;
                                  }
                                }
                              },
                              cursorColor: Colors.amber,
                              decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Email:',
                                  focusColor: Colors.amber,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(131, 243, 8, 231))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)))),
                                         ),
                                         SizedBox(
                          height: 20,
                                         ),
                                         Container(
                            height: 50,
                            child: TextFormField(
                                //autovalidateMode:AutovalidateMode.always ,
                                controller: passwordFieldController,
                                validator: (_) {
                                  if (passwordFieldController.text.isEmpty) {
                                    return 'empty field';
                                  } else {
                                    if (passwordFieldController.text.length < 6) {
                                      return 'password must be at least 6 characters';
                                    } else {
                                      return null;
                                    }
                                  }
                                },
                                cursorColor: Colors.amber,
                                obscureText: true,
                                decoration: InputDecoration(
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    isDense: true,
                                    hintText: 'password:',
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(131, 243, 8, 231))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20))))),
                                         SizedBox(
                          height: 20,
                                         ), BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                           
                            return MaterialButton(
                              onPressed: () {
                                if (myFormKey1.currentState!.validate()) {
                                  BlocProvider.of<LoginCubit>(context).signInNewUser(buttom_id: 1, email: emailFieldController.text,name:nameFieldController.text  ,password: passwordFieldController.text);
                                } else {}
                              },
                              color: Colors.amber,
                              height: 46,
                              minWidth: 150,  
                              child: state is RegisterLoading?CircularProgressIndicator(color: Colors.white,) : Text('Sign Up'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            );
                          },
                        ),
                                         
                                         
                                         
                                         ])),
                       ),
                     ),PageView(),
                    SingleChildScrollView(
                       child: Container(
                      padding: EdgeInsets.symmetric(horizontal:10),
                      child: Form(
                        key: myFormKey2,
                        child: Column(children: [
                      SizedBox(
                        height: 60,
                      ),
                      Image.asset(
                        "assets/images/worker.png",
                        
                        width: 120,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Register Panel',
                          style: TextStyle(
                              fontSize: h1_txt + 10,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 50,
                        child: TextFormField(
                            //autovalidateMode:AutovalidateMode.always ,
                            controller: name1FieldController,
                            validator: (_) {
                              if (nameFieldController.text == '') {
                                return 'empty field';
                              }
                            },
                            cursorColor: Colors.amber,
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Name,Lastname:',
                                focusColor: Colors.amber,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(131, 243, 8, 231))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        child: TextFormField(
                            //autovalidateMode:AutovalidateMode.always ,
                            controller: email1FieldController,
                            validator: (_) {
                              if (emailFieldController.text == '') {
                                return 'empty field';
                              } else {
                                if (!RegExp('[a-z0-9]+@[a-z]+\.[a-z]{2,3}')
                                    .hasMatch(emailFieldController.text)) {
                                  return 'Wrong email format';
                                } else {
                                  return null;
                                }
                              }
                            },
                            cursorColor: Colors.amber,
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Email:',
                                focusColor: Colors.amber,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(131, 243, 8, 231))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: 50,
                          child: TextFormField(
                              //autovalidateMode:AutovalidateMode.always ,
                              controller: password1FieldController,
                              validator: (_) {
                                if (passwordFieldController.text.isEmpty) {
                                  return 'empty field';
                                } else {
                                  if (passwordFieldController.text.length < 6) {
                                    return 'password must be at least 6 characters';
                                  } else {
                                    return null;
                                  }
                                }
                              },
                              cursorColor: Colors.amber,
                              obscureText: true,
                              decoration: InputDecoration(
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  isDense: true,
                                  hintText: 'password:',
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(131, 243, 8, 231))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))))),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        child: TextFormField(
                            //autovalidateMode:AutovalidateMode.always ,
                            controller: phoneFieldController,
                            validator: (_) {
                              if (phoneFieldController.text == '') {
                                return 'empty field';
                              }
                            },
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: '+21365675467',
                                errorBorder: InputBorder.none,
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                      ),SizedBox(
                      height: 20,
                                         ), BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                           
                            return MaterialButton(
                              onPressed: () {
                                if (myFormKey2.currentState!.validate()) {
                                  BlocProvider.of<LoginCubit>(context).signInNewUser(buttom_id: 2, email: emailFieldController.text,name:nameFieldController.text  ,password: passwordFieldController.text);
                                } else {}
                              },
                              color: Colors.amber,
                              height: 46,
                              minWidth: 150,
                              child: state is RegisterLoading?CircularProgressIndicator(color: Colors.white,) : Text('Sign Up'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            );
                          },
                        ),
                                         
                  
                  ])),
                    )),
                    
                
                
              ]),
            ),
                ),
            
                      ],
        )),
      ),
    )));
  }
}

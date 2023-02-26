import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hirfati/modules/homepage/explore.dart';
import 'package:hirfati/modules/homepage/homepage.dart';
import 'package:hirfati/modules/login/cubit/login_cubit.dart';
import 'package:hirfati/modules/registerpage/emailregistrationcheck..dart';
import 'package:hirfati/shared/theme.dart';
import'package:hirfati/modules/RegisterPage/RegisterPage.dart';

class LoginPage extends StatelessWidget {
  //const OnboardingPages({Key? key}) : super(key: key);
  static final String routeName = 'LoginPage';
  var myFormKey = GlobalKey<FormState>();
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocProvider(
      create: (context) => LoginCubit(),
      child:  BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is  LoginDoneUserVerified) {
              Navigator.of(context).popAndPushNamed(HomePage.routeName);
            } else {

              if (state is LoginFailed) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Login Failed'),
                          content: Text(state.error),
                        ));
              } ;
               if (state is  LoginDoneUserNotVerified) {
              Navigator.of(context).popAndPushNamed(EmailCkeckPage.routeName,arguments: [Explore.routeName]);
            };
            }
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                      ),CircleAvatar(minRadius: 70,backgroundColor: color_5,
                        child: Image(image:
                        AssetImage(
                          "assets/images/logo.png",
                          
                        ),width: 120,),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Login ',
                          style: TextStyle(
                              fontSize: h1_txt + 10,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        margin:EdgeInsets.symmetric(horizontal: 10),
                        child: Form(
                            key: myFormKey,
                            child: Column(children: [
                              Container(
                                height: 50,
                                child: TextFormField(
                                    //autovalidateMode:AutovalidateMode.always ,
                                    controller: emailFieldController,
                                    validator: (_) {
                                      if (emailFieldController.text == '') {
                                        return 'empty field';
                                      } else {
                                        if (!RegExp(
                                                '[a-z0-9]+@[a-z]+\.[a-z]{2,3}')
                                            .hasMatch(
                                                emailFieldController.text)) {
                                          return 'Wrong email format';
                                        } else {
                                          return null;
                                        }
                                      }
                                    },
                                    cursorColor: color_5,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        hintText: 'Email:',
                                        focusColor: Colors.amber,
                                        errorBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    131, 243, 8, 231))),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)))),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                  height: 50,
                                  child: TextFormField(
                                      //autovalidateMode:AutovalidateMode.always ,
                                      controller: passwordFieldController,
                                      validator: (_) {
                                        if (passwordFieldController
                                            .text.isEmpty) {
                                          return 'empty field';
                                        } else {
                                          if (passwordFieldController
                                                  .text.length <
                                              6) {
                                            return 'password must be at least 6 characters';
                                          } else {
                                            return null;
                                          }
                                        }
                                      },
                                      cursorColor: color_5,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          errorBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          isDense: true,
                                          hintText: 'password:',
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      131, 243, 8, 231))),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)))))
                            ])),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                         
                          return MaterialButton(
                            onPressed: () {
                              if (myFormKey.currentState!.validate()) {
                                BlocProvider.of<LoginCubit>(context).loginUser(email: emailFieldController.text, password: passwordFieldController.text);
                              } else {}
                            },
                            color: color_5.withOpacity(.8),
                            height: 46,
                            minWidth: 150,
                            child: state is LoginLoading ?CircularProgressIndicator(color: Colors.white,) : Text('Log in',style:TextStyle(color:Colors.white)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                          onTap: () {}, child: Text('Forget password ?')),
                      SizedBox(height: 35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('if you don\'t have account '),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(RegisterPage.routeName);
                              },
                              child: Text('Register.',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: color_5.withOpacity(.7),
                                      fontWeight: FontWeight.bold)))
                        ],
                      ),
                    ]),
              )),
        ),
      ))
    ;
  }
}

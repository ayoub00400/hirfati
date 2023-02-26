import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../jobs.dart';
import '../../shared/componants.dart';
import '../../shared/theme.dart';
import '../login/cubit/login_cubit.dart';

class RegisterPage extends StatefulWidget {
  static final String routeName = 'RegisterPage';
  List<String> userJobs = [];
  late LatLng userLocation;
  @override
  _RegisterPageState createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  //const OnboardingPages({Key? key}) : super(key: key);
  late GoogleMapController myMapController;
  Map<String, dynamic> response = {};

  Set<Marker> mapMarkers = Set();

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
  PageController myPage = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myTabBarController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      FocusScope.of(context).unfocus();
    },
      child: Scaffold(
          body: SafeArea(
              child: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            
            if (state is RegisterDone) {
              
            } else {
              if (state is RegisterFailed) {
    
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Text(state.error),
                        ));
              } else {
    
              }
            }
          },
          child: Container(
              child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color.fromARGB(106, 209, 209, 209)),
                  child: TabBar(
                      onTap: (value) {},
                      unselectedLabelColor: Colors.grey,
                      labelStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      controller: myTabBarController,
                      indicator: BoxDecoration(
                          color: color_5.withOpacity(.8),
                          borderRadius: BorderRadius.circular(25)),
                      labelColor: Colors.white,
                      tabs: [
                        Container(
                            padding: EdgeInsets.all(10), child: Text('User')),
                        Container(
                            padding: EdgeInsets.all(10), child: Text('Worker')),
                      ]),
                ),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: myTabBarController,
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
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
                                        cursorColor: Colors.amber,
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
                                    height: 20,
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
                                          cursorColor: Colors.amber,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                              errorBorder: InputBorder.none,
                                              focusedErrorBorder:
                                                  InputBorder.none,
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
                                                      BorderRadius.circular(
                                                          20))))),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  BlocBuilder<LoginCubit, LoginState>(
                                    builder: (context, state) {
                                      return MaterialButton(
                                        onPressed: () {
                                         try{ if (myFormKey1.currentState!
                                              .validate()) {
                                                
                                                FocusScope.of(context).unfocus();
                                            BlocProvider.of<LoginCubit>(context)
                                                .signUpNewUser( context: context,
                                                    email:
                                                        emailFieldController.text,
                                                    name:
                                                        nameFieldController.text,
                                                    password:
                                                        passwordFieldController
                                                            .text);
                                                            
                                          } else {}}
                                          
                                          
                                          catch(e){
                                            print("HHHHHHHHHHHH"+e.toString());
                                          }
                                        },
                                        color: color_5.withOpacity(.8),
                                        height: 46,
                                        minWidth: 150,
                                        child: state is RegisterLoading
                                            ? CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : Text('Sign Up',style: TextStyle(color: Colors.white),),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      );
                                    },
                                  ),
                                ])),
                          ),
                        ),
                        PageView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: myPage,
                            children: [
                              SingleChildScrollView(
                                  child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
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
                                              if (name1FieldController.text ==
                                                  '') {
                                                return 'empty field';
                                              }
                                            },
                                            cursorColor: Colors.amber,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintText: 'Name,Lastname:',
                                                focusColor: Colors.amber,
                                                errorBorder: InputBorder.none,
                                                focusedErrorBorder:
                                                    InputBorder.none,
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            131, 243, 8, 231))),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)))),
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
                                              if (email1FieldController.text ==
                                                  '') {
                                                return 'empty field';
                                              } else {
                                                if (!RegExp(
                                                        '[a-z0-9]+@[a-z]+\.[a-z]{2,3}')
                                                    .hasMatch(
                                                        email1FieldController
                                                            .text)) {
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
                                                focusedErrorBorder:
                                                    InputBorder.none,
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            131, 243, 8, 231))),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)))),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                          height: 50,
                                          child: TextFormField(
                                              //autovalidateMode:AutovalidateMode.always ,
                                              controller:
                                                  password1FieldController,
                                              validator: (_) {
                                                if (password1FieldController
                                                    .text.isEmpty) {
                                                  return 'empty field';
                                                } else {
                                                  if (password1FieldController
                                                          .text.length <
                                                      6) {
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
                                                  focusedErrorBorder: InputBorder
                                                      .none,
                                                  isDense: true,
                                                  hintText: 'password:',
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  Color
                                                                      .fromARGB(
                                                                          131,
                                                                          243,
                                                                          8,
                                                                          231))),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20))))),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 50,
                                        child: TextFormField(
                                            //autovalidateMode:AutovalidateMode.always ,
                                            controller: phoneFieldController,
                                            validator: (_) {
                                              if (phoneFieldController.text ==
                                                  '') {
                                                return 'empty field';
                                              }
                                            },
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintText: '+21365675467',
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20)))),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          if (myFormKey2.currentState!
                                              .validate()) {
                                            FocusManager.instance.primaryFocus!
                                                .unfocus();
                                            myPage.nextPage(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.linear);
                                          } else {}
                                        },
                                        color: color_5.withOpacity(.8),
                                        height: 46,
                                        minWidth: 150,
                                        child: Text('Next',style: TextStyle(color: Colors.white),),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      )
                                    ])),
                              )),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        alignment: Alignment.centerLeft,
                                        child: Text('Choose your Job(s):',
                                            style: TextStyle(fontSize: h1_txt))),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 220,
                                      child: SingleChildScrollView(
                                        child: Wrap(
                                            spacing: 4,
                                            runSpacing: 4,
                                            children: jobData.map((e) {
                                              return FilterChip(
                                                  label: Text(e["jobtitle"]!),
                                                  avatar: CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                        "assets/icons/${e["img_path"]}"),
                                                    radius: 20,
                                                  ),
                                                  selected: widget.userJobs
                                                      .contains(e["jobtitle"]),
                                                  showCheckmark: true,
                                                  onSelected: (onSelected) {
                                                    if (onSelected) {
                                                      widget.userJobs
                                                          .add(e["jobtitle"]!);
                                                      print(widget.userJobs);
                                                    } else {
                                                      widget.userJobs.removeWhere(
                                                          (element) =>
                                                              element ==
                                                              e["jobtitle"]!);
                                                      print(widget.userJobs);
                                                    }
                                                    setState(() {});
                                                  });
                                            }).toList() as List<Widget>),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        alignment: Alignment.centerLeft,
                                        child: Text('Choose your location',
                                            style: TextStyle(fontSize: h1_txt))),
                                    Container(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      height: 250,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 20),
                                      child: GoogleMap(
                                        markers: mapMarkers,
                                        initialCameraPosition: CameraPosition(
                                          zoom: 8,
                                          target: LatLng(36.37073149069495,
                                              3.89987681986862),
                                        ),
                                        onMapCreated: (mapController) {
                                          myMapController = mapController;
                                        },
                                        onTap: (locationCordinates) {
                                          widget.userLocation=locationCordinates;
                                          mapMarkers.clear();
                                          mapMarkers.add(Marker(
                                              markerId: MarkerId('location'),
                                              position: locationCordinates));
                                          myMapController
                                              .animateCamera(
                                                  CameraUpdate.newLatLng(
                                                      locationCordinates))
                                              .then((value) {
                                        
                                            http
                                                .post(Uri.parse(
                                                    'https://nominatim.openstreetmap.org/reverse?format=json&lat=${locationCordinates.latitude}&zoom=10&lon=${locationCordinates.longitude}&addressdetails=1&namedetails=1&email=ayoublarbaoui004@gmail.com'))
                                                .then((value) {
                                              if (value.body != null ||
                                                  value.body != "") {
                                                response = json.decode(value.body)
                                                    as Map<String, dynamic>;
    
                                                setState(() {});
                                              }
                                            });
                                          });
                                        },
                                      ),
                                    ),
                                    BlocBuilder<LoginCubit, LoginState>(
                                      builder: (context, state) {
                                        return MaterialButton(
                                          onPressed: response.isEmpty
                                              ? null
                                              : () {
                                                  BlocProvider.of<LoginCubit>(
                                                          context)
                                                      .signUpNewWorker(
                                                        userLocationCord: widget.userLocation,
                                                          daira:
                                                              response["address"]
                                                                  ['county'],
                                                          madina:
                                                              response["address"]
                                                                  ['town'],
                                                          wilaya:
                                                              response["address"]
                                                                  ['state'],
                                                          phoneNumber:
                                                              phoneFieldController
                                                                  .text,
                                                          jobs: widget.userJobs,
                                                          email:
                                                              email1FieldController
                                                                  .text,
                                                          name:
                                                              name1FieldController
                                                                  .text,
                                                          password:
                                                              password1FieldController
                                                                  .text);
                                                },
                                          color:
                                              color_5.withOpacity(.8),
                                          height: 46,
                                          minWidth: 150,
                                          child: state is RegisterLoading
                                              ? CircularProgressIndicator(
                                                  color: Colors.white,
                                                )
                                              : Text('Sign Up',style: TextStyle(color: Colors.white),),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ]),
                      ]),
                ),
              ),
            ],
          )),
        ),
      ))),
    );
  }
}

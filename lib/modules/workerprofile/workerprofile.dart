import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hirfati/main.dart';
import 'package:hirfati/modules/workerprofile/cubit/workerprofile_cubit.dart';
import 'package:hirfati/shared/storege_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkerProfile extends StatelessWidget {
  
  static final String routeName = 'WorkerProfilePage';
  GetLikes(Map userInfos){
    return Hirfati.myFirestore.collection('users').doc(userInfos['uid']).collection('likes').snapshots();
  }
  @override
  Widget build(BuildContext context) {
    var myCarouslController;
    Map<String, dynamic> userInfos =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    
    List jobs = userInfos["jobs"];
    return BlocProvider(
      create: (context) => WorkerprofileCubit()..checkLikedOrNot(userInfos['uid']),
      child: BlocBuilder<WorkerprofileCubit, WorkerprofileState>(
        builder: (context, state) {
          return Scaffold(
              body: SafeArea(
            child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 8, right: 29),
                        child: Row(children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.arrow_back_ios_new)),
                          Spacer(),
                          Container(
                              child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    
                                    if(BlocProvider.of<WorkerprofileCubit>(context).likeButtonColor==Colors.red){
                                      BlocProvider.of<WorkerprofileCubit>(context).likeButtonColor=Colors.purple;
                                      BlocProvider.of<WorkerprofileCubit>(context).changeLikeButtonColor(userInfos['uid']);
                                    }else{
                                      BlocProvider.of<WorkerprofileCubit>(context).likeButtonColor=Colors.red;
                                      BlocProvider.of<WorkerprofileCubit>(context).changeLikeButtonColor1(userInfos['uid']);
                                    }
                                    
                                  },
                                  child: Icon(Icons.heart_broken,
                                      color: BlocProvider.of<WorkerprofileCubit>(context).likeButtonColor, size: 30)),
                              SizedBox(
                                width: 4,
                              ),
                               Text(BlocProvider.of<WorkerprofileCubit>(context).likes.toString() , style: TextStyle(color: Colors.black54))
                              
                               
                                 
                               
                            ],
                          )),
                        ]),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: CircleAvatar(
                              backgroundColor:
                                  Colors.deepPurple.withOpacity(.3),
                              radius: 60,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(userInfos['name'],
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 24,
                          ),
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    await launchUrl(Uri(
                                        scheme: 'tel',
                                        path: userInfos['phonenumber']));
                                  },
                                  child: Icon(Icons.phone,
                                      color: Color.fromARGB(190, 104, 58, 183),
                                      size: 33)),
                              InkWell(onTap:(){
                                Navigator.of(context).pushNamed('/massangerpage',arguments: {'user_infos':userInfos});
                              },
                                child: Icon(Icons.message_outlined,
                                    color: Color.fromARGB(190, 104, 58, 183),
                                    size: 33),
                              ),
                              Icon(Icons.save,
                                  color: Color.fromARGB(190, 104, 58, 183),
                                  size: 33)
                            ],
                          )),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white54),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 24,
                                ),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    alignment: Alignment.centerLeft,
                                    child: Text('Description',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600))),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 32),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'hello my name is ayoub im painter hhhhhhhhhhhhhh hhhiohoi hjhjh hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh ',
                                        maxLines: 3,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 17))),
                                SizedBox(
                                  height: 24,
                                ),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    alignment: Alignment.centerLeft,
                                    child: Text('Racent Work',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600))),
                                SizedBox(
                                  height: 24,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  height: 200,
                                  color: Colors.pink,
                                  child: CarouselSlider(
                                      items: [
                                        Container(
                                            color: Colors.amber,
                                            width: double.infinity,
                                            child: Image.network(
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpOkUhZnyzmsc0lTvBHQGMbGlTGxRNeXwxmA&usqp=CAU',
                                              fit: BoxFit.cover,
                                            )),
                                      ],
                                      carouselController: myCarouslController,
                                      options: CarouselOptions(
                                        height: 200,
                                        viewportFraction: 1,
                                        enlargeStrategy:
                                            CenterPageEnlargeStrategy.height,
                                        autoPlay: true,
                                        autoPlayCurve: Curves.easeInOut,
                                        autoPlayAnimationDuration:
                                            Duration(seconds: 1),
                                        scrollDirection: Axis.horizontal,
                                      )),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    alignment: Alignment.centerLeft,
                                    child: Text('Skills',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600))),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    height: 70,
                                    alignment: Alignment.centerLeft,
                                    child: Wrap(
                                      spacing: 5,
                                      children: jobs
                                          .map((item) => FilterChip(
                                              label:
                                                  Text("#" + item.toString()),
                                              backgroundColor: Colors.deepPurple
                                                  .withOpacity(.1),
                                              onSelected: (_) {}))
                                          .toList() as List<Widget>,
                                      direction: Axis.horizontal,
                                    )),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24),
                                    alignment: Alignment.centerLeft,
                                    child: Text('Location',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600))),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 24),
                                    height: 200,
                                    child: GoogleMap(
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                            userInfos["locationlant"],
                                            userInfos["locationlong"]),
                                        zoom: 8,
                                      ),
                                      markers: [
                                        Marker(
                                            markerId:
                                                MarkerId("WorkerLocation"),
                                            position: LatLng(
                                                userInfos["locationlant"],
                                                userInfos["locationlong"]))
                                      ].toSet(),
                                    )),
                                SizedBox(
                                  height: 18,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          ));
        },
      ),
    );
  }
}

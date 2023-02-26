import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hirfati/modules/homepage/cubit/homepage_cubit.dart';
import 'package:hirfati/modules/homepage/cubit/suggestedprofile_cubit.dart';
import 'package:hirfati/modules/login/loginpage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hirfati/modules/seemorepage/seemorepage.dart';
import '../../shared/componants.dart';
import '../../shared/storege_helper.dart';
import '../../shared/theme.dart';
import '../../jobs.dart';
import '../searchpage/searchpage.dart';

class Explore extends StatelessWidget{
  static final String routeName = 'ExplorePage';
  CarouselController myCarouslController = CarouselController();
@override
Widget build(BuildContext context){
  return BlocProvider(
    create: (context) => SuggestedprofileCubit()..GetSuggestedProfilesList(),
    child: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                      child: Column(children: [
                              ///plasete l carousel hna for the ads,
                              Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(children: [
                      Text(
                        'Hi, Ayoub 👋 ',
                        style: TextStyle(fontSize: h2_txt + 3),
                      ),
                      Spacer(),
                      IconButton(onPressed: () {
                       
                      }, icon: Icon(Icons.notifications)),
                    
                      
                      IconButton(onPressed: () {
                        Navigator.pushNamed(context,SearchPage.routeName);
                      }, icon: Icon(Icons.search))
                    ])),
                              Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(left: 8, bottom: 8),
                    child: Text(
                      '  What service do you need today?',
                      style: TextStyle(
                          color: Color.fromARGB(82, 0, 0, 0), fontSize: h2_txt - 1),
                    )),
                              SizedBox(
                  height: 8,
                              ),
                              Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  width: double.infinity,
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
                        height: 180,
                        viewportFraction: 1,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        autoPlay: true,
                        autoPlayCurve: Curves.easeInOut,
                        autoPlayAnimationDuration: Duration(seconds: 1),
                        scrollDirection: Axis.horizontal,
                      )),
                              ),
                              Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(
                      top: 14,
                      left: 8,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Services',
                          style:
                              TextStyle(color: Colors.black, fontSize: h2_txt + 1),
                        ),
                        Spacer(),
                        GestureDetector( onTap:(){
                          Navigator.pushNamed(context,Seemore.routeName);
                        },child:Text(
                          'see more ',
                          style: TextStyle(
                              color: Colors.deepPurple.shade300.withOpacity(.8),
                              fontWeight: FontWeight.bold,
                              fontSize: h3_txt - 1),
                        ))
                      ],
                    )),
                              Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                    child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: jobData.getRange(0,7)
                                .map((e) => CategorieBuilder(
                                    e['img_path']!, e['jobtitle']!,context))
                                .toList()))),
                              Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(
                      top: 14,
                      left: 8,bottom: 10,
                    ),
                    child: Text(
                      'Popular Profile',
                      style: TextStyle(color: Colors.black, fontSize: h2_txt),
                    )),
                   BlocBuilder<SuggestedprofileCubit, SuggestedprofileState>(
                      builder: (context, state) {
                        return Container(constraints: BoxConstraints(maxHeight: 500,),  margin: EdgeInsets.symmetric(horizontal: 9), child: ListView(shrinkWrap: true, children: 
                      BlocProvider.of<SuggestedprofileCubit>(context).suggestedProfilesList.map((e) =>workerListTileBuilder( context,e) ).toList()
                                      ));
                      },
                    ) 
                  ,
                            ])),
                )),
  );
}
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hirfati/modules/homepage/cubit/homepage_cubit.dart';
import 'package:hirfati/modules/login/loginpage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../shared/componants.dart';
import '../../shared/storege_helper.dart';
import '../../shared/theme.dart';
import '../../jobs.dart';
import 'explore.dart';
import 'notificationpag.dart';
import 'profilepage.dart';

class HomePage extends StatelessWidget {
  //const OnboardingPages({Key? key}) : super(key: key);
  static final String routeName = 'HomePage';
  List<Widget> homePages=[Explore(),NotificationPage(),ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomepageCubit(),
      child: Scaffold(
          bottomNavigationBar:
              BlocBuilder<HomepageCubit, HomepageState>(
                builder: (context, state) {
                  return BottomNavigationBar(currentIndex: BlocProvider.of<HomepageCubit>(context).navBarIndex, onTap: (index) {
                    BlocProvider.of<HomepageCubit>(context).changePage(index);
                  },selectedIconTheme:IconThemeData(color: Colors.purple[300],size:30 ) , items: [
                          BottomNavigationBarItem(label: '', icon: Icon(Icons.home)),
                          BottomNavigationBarItem(label: '', icon: Icon(Icons.notifications)),
                          BottomNavigationBarItem(label: '', icon: Icon(Icons.person)),
                        ]);
                },
              ),
          body: BlocBuilder<HomepageCubit, HomepageState>(
            builder: (context, state) {
              return homePages[BlocProvider.of<HomepageCubit>(context).navBarIndex];
            },
          ),
    ));
  }
}

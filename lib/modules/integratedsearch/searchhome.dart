import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hirfati/modules/category/cubit/category_cubit.dart';
import 'package:hirfati/modules/searchpage/cubit/search_cubit.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../shared/componants.dart';

class FilterSearchPage extends StatefulWidget {
  //name({Key? key}) : super(key: key);

  static final String routeName = 'FilterSearchPage';
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<FilterSearchPage> {
  late GoogleMapController myMapController;
  Map<String, dynamic> response = {};
  Set<Marker> mapMarkers = Set();

  @override
  Widget build(BuildContext context) {
    String job=ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SearchCubit(),
            ),
            BlocProvider(
              create: (context) => CategoryCubit(),
            ),
          ],
          child: BlocConsumer<SearchCubit, SearchState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Stack(children: [
                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    return GoogleMap(
                      markers: mapMarkers,
                      initialCameraPosition: CameraPosition(
                        zoom: 8,
                        target: LatLng(36.37073149069495, 3.89987681986862),
                      ),
                      onMapCreated: (mapController) {
                        myMapController = mapController;
                      },
                      onTap: (locationCordinates) {
                        mapMarkers.clear();
                        mapMarkers.add(Marker(
                            markerId: MarkerId('location'),
                            position: locationCordinates));
                        myMapController
                            .animateCamera(
                                CameraUpdate.newLatLng(locationCordinates))
                            .then((value) {
                          //  print('£££££££££££££££££££££££££££££££££££££');
                          http
                              .post(Uri.parse(
                                  'https://nominatim.openstreetmap.org/reverse?format=json&lat=${locationCordinates.latitude}&zoom=10&lon=${locationCordinates.longitude}&addressdetails=1&namedetails=1&email=ayoublarbaoui004@gmail.com'))
                              .then((value) {
                            response =
                                json.decode(value.body) as Map<String, dynamic>;
                            setState(() {});
                          });
                        });
                      },
                    );
                  },
                ),
                Center(
                  child: Column(
                    children: [
                      Spacer(),
                       Padding(
                            padding: const EdgeInsets.only(bottom: 70),
                            child: ElevatedButton(
                                onPressed: () async{
                                  //await BlocProvider.of<CategoryCubit>(context).loadFiltredWorkerList(job, response['address']['state']);
                                  Navigator.pop(context,response['address']['state']);
                                  
                      
                                },
                                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    minimumSize: Size(170, 55), elevation: 4),
                                child: Text('Done',style: TextStyle(fontSize: 23),))),
                       
                    ],
                  ),
                ),
              ]);
            },
          ),
        )));
  }
}

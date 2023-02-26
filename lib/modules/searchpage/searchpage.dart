import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hirfati/jobs.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../shared/componants.dart';
import 'cubit/search_cubit.dart';
/*
hna rah fiha defaux lazemha update .........
*/
class SearchPage extends StatefulWidget {
  //name({Key? key}) : super(key: key);
  List<String> userJobs = [];
  LatLng? searchLocationCordinates;
  static final String routeName = 'SearchPage';
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late GoogleMapController myMapController;
  late Map<String, dynamic> response;
  TextEditingController searchZone = TextEditingController();
  Set<Marker> mapMarkers = Set();
  Future<dynamic> getLocationInfo() {
    return http.post(Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${widget.searchLocationCordinates!.latitude}&zoom=10&lon=${widget.searchLocationCordinates!.longitude}&addressdetails=1&namedetails=1&email=ayoublarbaoui004@gmail.com'));
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          //showModalBottomSheet(context: context,, builder: builder);
          if (state is SearchResultDone) {
            showBottomSheet(
                context: context,
                enableDrag: true,
                backgroundColor: Colors.transparent,
                builder: (_) => Container(
                    constraints:
                        BoxConstraints.loose(Size(double.infinity, 350)),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(61, 0, 0, 0),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: ListView(
                        shrinkWrap: true,
                        children: BlocProvider.of<SearchCubit>(context)
                            .workersList
                            .map((e) => workerListTileBuilder1(context,e))
                            .toList())));
          }
        },
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
                    widget.searchLocationCordinates = locationCordinates;
                    mapMarkers.clear();
                    mapMarkers.add(Marker(
                        markerId: MarkerId('location'),
                        position: locationCordinates));
                    if (widget.userJobs.isEmpty) {
                      myMapController
                          .animateCamera(
                              CameraUpdate.newLatLng(locationCordinates))
                          .then((value) {
                        //  print('£££££££££££££££££££££££££££££££££££££');
                        getLocationInfo().then((value) {
                          response =
                              json.decode(value.body) as Map<String, dynamic>;
                          BlocProvider.of<SearchCubit>(context)
                              .loadSearchWorkerList(
                                  response["address"]['state']);

                          setState(() {});
                        });
                      });
                    } else {
                      print(widget.userJobs);
                      myMapController
                          .animateCamera(
                              CameraUpdate.newLatLng(locationCordinates))
                          .then((value) {
                        //  print('£££££££££££££££££££££££££££££££££££££');
                        getLocationInfo().then((value) {
                          response =
                              json.decode(value.body) as Map<String, dynamic>;
                          BlocProvider.of<SearchCubit>(context)
                              .loadFiltredWorkerList(widget.userJobs,
                                  response["address"]['state']);
                          //searchZone.text = response["address"].toString();
                          setState(() {});
                        });
                      });
                    }
                  },
                );
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              color: Colors.white.withOpacity(.5),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: jobData.map((e) {
                      return FilterChip(
                          label: Text(e["jobtitle"]!),
                          avatar: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/icons/${e["img_path"]}"),
                            radius: 20,
                          ),
                          selected: widget.userJobs.contains(e["jobtitle"]),
                          showCheckmark: true,
                          onSelected: (onSelected) {
                            if (onSelected) {
                              widget.userJobs.add(e["jobtitle"]!);
                              print(widget.userJobs);
                            } else {
                              widget.userJobs.removeWhere(
                                  (element) => element == e["jobtitle"]!);
                              print(widget.userJobs);
                            }
                            if (widget.userJobs.isNotEmpty && widget.searchLocationCordinates==null ) {
                              BlocProvider.of<SearchCubit>(context)
                                  .loadSearchWorkerListByJob(widget.userJobs);
                            } else {
                              if (widget.userJobs.isNotEmpty && widget.searchLocationCordinates!=null ){
                                //val=getLocationInfo();
                                 BlocProvider.of<SearchCubit>(context)
                                  .loadFiltredWorkerList(widget.userJobs, response["address"]['state']);
                              }else{}

                            }

                            setState(() {});
                          });
                    }).toList() as List<Widget>),
              ),
            )
          ]);
        },
      ),
    )));
  }
}

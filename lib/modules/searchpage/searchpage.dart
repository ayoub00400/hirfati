import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import'package:google_maps_flutter/google_maps_flutter.dart';
import'package:http/http.dart' as http;
import'dart:convert';

class SearchPage extends StatefulWidget {
  //name({Key? key}) : super(key: key);

  static final String routeName = 'SearchPage';
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late GoogleMapController myMapController;
  late Map<String,dynamic> response;
  TextEditingController searchZone=TextEditingController();
  Set<Marker> mapMarkers=Set();
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        
        body: SafeArea(
          child: Stack(
            children:[ GoogleMap(markers:mapMarkers, initialCameraPosition: CameraPosition(zoom: 8,target:LatLng(36.37073149069495, 3.89987681986862) ,),onMapCreated: (mapController){
              myMapController=mapController;
            },onTap: (locationCordinates){
              mapMarkers.clear();
              mapMarkers.add(Marker(markerId: MarkerId('location'),position: locationCordinates));
              myMapController.animateCamera(CameraUpdate.newLatLng(locationCordinates)).then((value) {
                print('£££££££££££££££££££££££££££££££££££££');
                http.post(Uri.parse('https://nominatim.openstreetmap.org/reverse?format=json&lat=${locationCordinates.latitude}&zoom=10&lon=${locationCordinates.longitude}&addressdetails=1&namedetails=1&email=ayoublarbaoui004@gmail.com')).then((value){
                  response=json.decode(value.body) as Map<String,dynamic> ;
                  searchZone.text= response["address"].toString();
                  setState(() {
                    
                  });
                } );
              });
            },
          
            
                  ),Container(margin:EdgeInsets.all(8), color:Colors.white.withOpacity(.5), child: TextFormField(controller: searchZone,))
                  
                  ]
          )));
  }
}

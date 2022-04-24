import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';

class map extends StatefulWidget {
  @override
  _mapState createState() => _mapState();
}

class _mapState extends State<map> {
  String _currentAddress;


  Location location = new Location();
  String error;
  Location _location = new Location();
  Position currentpostion;
  var geolocator = Geolocator();
  Completer<GoogleMapController> _goglemapcontroller = Completer();
    GoogleMapController usermap;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
 void getCurrentlocation ()async{
   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy. bestForNavigation);
   print(position.longitude);
   print(position.latitude);
   currentpostion = position;
  //  LatLng lang = LatLng( position.latitude, position.longitude);
  // CameraPosition cameraPosition =  CameraPosition(target: lang,zoom: 14.0);
  // usermap.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

 }
  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentpostion.latitude,
          currentpostion.longitude
      );

      Placemark place = placemarks[0];

      setState(() {
         _currentAddress  = "${place.locality}, ${place.postalCode}, ${place.country}";
      });
      print(place);
    } catch (e) {
      print( e);
    }}
getaddressfromCordinates(Coordinates cords ) async{
  var addresses = await Geocoder.local.findAddressesFromCoordinates (cords);
  var first = addresses.first;
  print("${first.featureName} : ${first.coordinates}");
}
   getUserLocation() async {//call this async method from whereever you need


    final coordinates = new Coordinates(
        currentpostion.latitude, currentpostion.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    var first = addresses.first;
    print(' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
    return first;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(icon: Icon( Icons.arrow_back), onPressed: ()async{

            Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
            debugPrint('location: ${position.latitude}');
            final coordinates = new Coordinates(position.latitude, position.longitude);
            var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
            var first = addresses.first;
            print("${first.featureName} : ${first.addressLine}");

        } )],

      ),
      body:   GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        myLocationEnabled: true,

        onMapCreated: (GoogleMapController controller) {
          _goglemapcontroller.complete(controller);
          usermap = controller;
          getCurrentlocation();
          _getAddressFromLatLng();
          getUserLocation();
          getaddressfromCordinates( Coordinates(currentpostion.longitude,currentpostion.latitude)  );
        },
      ),

    );
  }}








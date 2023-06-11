import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class ServiceLoctionPage extends StatelessWidget{
  double latitude;
  double longitude;
  String title;
  ServiceLoctionPage(this.latitude, this.longitude,this.title);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(latitude, longitude),
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: MarkerId(title),
                  position: LatLng(latitude, longitude),
                  infoWindow: InfoWindow(title: title),
                  icon: BitmapDescriptor.defaultMarkerWithHue(120),
                  rotation: -20,
                ),
              },
        ),
    ) ;
  }
}
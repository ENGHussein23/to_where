import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:to_where/Controller/Getx_controllers/GetLocationController.dart';


class GetLocation extends StatelessWidget {
  final GetLocationController _LocationController = Get.put(GetLocationController());
  GoogleMapController? _mapController;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Obx((){
          if(_LocationController.currentPosition.value != null)
          {
            final position = _LocationController.currentPosition.value!;
            return Text(
              "خط العرض: ${position.latitude}\nخط الطول: ${position.longitude}",
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            );
          }
          else{
            return Text("حدد موقعي على الخريطة");
          }
        }
        ),
      ),
      body: Stack(
          children: [
            Obx(() {
              if (_LocationController.currentPosition.value == null) {
                return Center(child: CircularProgressIndicator(),);
              } else {
                final position = _LocationController.currentPosition.value!;
                return Container(
                  child:
                  Column(children: [

                    Container(
                      height: screenHeight-80,
                      child: GoogleMap(
                        onMapCreated: (GoogleMapController controller) {
                          _mapController = controller;
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(position.latitude, position.longitude),
                          zoom: 15,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId('my_location'),
                            position: LatLng(position.latitude, position.longitude),
                            infoWindow: InfoWindow(title: 'My Location'),
                          ),

                        },
                      ),
                    ),
                  ],),
                );
              }
            }),
          ]
      ),
      floatingActionButtonLocation:  FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){ _LocationController.getCurrentLocation();
        try{
          final position = _LocationController.currentPosition.value!;
          final cameraUpdate = CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude));
          _mapController!.animateCamera(cameraUpdate);
        }
        catch(e){
          print("this is why $e");
        }
        },
        child: Icon(Icons.location_on),
      ),
    );
  }
}
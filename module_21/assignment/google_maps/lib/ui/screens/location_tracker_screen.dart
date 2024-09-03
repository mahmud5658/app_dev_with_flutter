import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controller/location_controller.dart';
import '../widgets/app_bar.dart';

class LocationTrackerScreen extends StatefulWidget {
  const LocationTrackerScreen({super.key});

  @override
  State<LocationTrackerScreen> createState() => _LocationTRackerScreenState();
}

class _LocationTRackerScreenState extends State<LocationTrackerScreen> {
  late GoogleMapController _googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LocationTrackerAppBar(),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return controller.currentPosition == null
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _googleMapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                controller.currentPosition!.latitude,
                controller.currentPosition!.longitude,
              ),
              zoom: 15,
            ),
            onTap: (LatLng latLng) {
              //print(latLng);
            },
            polylines: <Polyline>{
              Polyline(
                polylineId: const PolylineId("user_polyline"),
                color: Colors.blue,
                width: 5,
                points: controller.polylineCoordinates,
              )
            },
            markers: <Marker>{
              Marker(
                markerId: const MarkerId("sample-marker-id"),
                infoWindow: InfoWindow(
                  title: "My current location",
                  snippet:
                  "${controller.currentPosition!.latitude}, ${controller.currentPosition!.longitude}",
                ),
                position: LatLng(
                  controller.currentPosition!.latitude,
                  controller.currentPosition!.longitude,
                ),
              )
            },
          );
        },
      ),
    );
  }
}
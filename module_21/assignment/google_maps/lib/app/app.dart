import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_maps/ui/screens/location_tracker_screen.dart';

import '../ui/controllerBinder/controller_binder.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinder(),
      home:  const LocationTrackerScreen(),
    );
  }
}




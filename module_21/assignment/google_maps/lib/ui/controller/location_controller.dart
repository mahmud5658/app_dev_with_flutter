import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  Position? _myPosition;
  Position? _currentPosition;
  final List<LatLng> _polylineCoordinates = [];

  Position? get myPosition => _myPosition;

  Position? get currentPosition => _currentPosition;

  List<LatLng> get polylineCoordinates => _polylineCoordinates;

  @override
  void onInit() {
    super.onInit();
    _locationPermissionHandler();
    _listenToPositionStream();
  }

  Future<void> _locationPermissionHandler() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      final bool isEnable = await Geolocator.isLocationServiceEnabled();

      if (isEnable) {
        _getCurrentLocation();
      } else {
        Geolocator.openLocationSettings();
      }
    } else {
      if (permission == LocationPermission.deniedForever) {
        Geolocator.openAppSettings();
        return;
      }

      LocationPermission requestPermission = await Geolocator.requestPermission();
      if (requestPermission == LocationPermission.always ||
          requestPermission == LocationPermission.whileInUse) {
        _locationPermissionHandler();
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
        timeLimit: Duration(seconds: 10),
      ),
    );
    _myPosition = _currentPosition;
    update();
  }

  void _listenToPositionStream() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      _currentPosition = position;
      _polylineCoordinates.add(LatLng(position.latitude, position.longitude));
      update();
    });
  }

}
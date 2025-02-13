import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenStreetMap Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  LatLng? _userLocation;
  String _address = 'Tap to get address';
  List<LatLng> _polylinePoints = [];
  List<LatLng> _polygonPoints = [];

  @override
  void initState() {
    super.initState();
    _fetchUserLocation();
  }

  Future<void> _fetchUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showSnackBar('Location services are disabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showSnackBar('Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showSnackBar('Location permissions are permanently denied.');
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
        _mapController.move(_userLocation!, 13.0);
      });
    } catch (e) {
      _showSnackBar('Failed to fetch location: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _reverseGeocode(LatLng point) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(point.latitude, point.longitude);
      setState(() {
        _address = placemarks.isNotEmpty
            ? placemarks.first.street ?? 'Unknown address'
            : 'No address found';
      });
    } catch (e) {
      setState(() {
        _address = 'Failed to fetch address';
      });
    }
  }

  void _addPolyline() {
    setState(() {
      _polylinePoints = [
        LatLng(51.509364, -0.128928),
        LatLng(51.511, -0.13),
        LatLng(51.51, -0.12),
      ];
    });
  }

  void _addPolygon() {
    setState(() {
      _polygonPoints = [
        LatLng(51.509364, -0.128928),
        LatLng(51.511, -0.13),
        LatLng(51.51, -0.12),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OpenStreetMap Example')),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _userLocation ?? LatLng(51.509364, -0.128928),
          initialZoom: 13.0,
          onTap: (_, LatLng point) {
            _reverseGeocode(point);
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              if (_userLocation != null)
                Marker(
                  point: _userLocation!,
                  child: Icon(Icons.location_on, color: Colors.green),
                ),
            ],
          ),
          if (_polylinePoints.isNotEmpty)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: _polylinePoints,
                  color: Colors.blue,
                  strokeWidth: 4.0,
                ),
              ],
            ),
          if (_polygonPoints.isNotEmpty)
            PolygonLayer(
              polygons: [
                Polygon(
                  points: _polygonPoints,
                  color: Colors.blue.withOpacity(0.5),
                  borderColor: Colors.blue,
                  borderStrokeWidth: 2.0,
                ),
              ],
            ),
          MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
              maxClusterRadius: 120,
              size: Size(40, 40),
              markers: [
                Marker(
                  point: LatLng(51.509364, -0.128928),
                  child: Icon(Icons.location_on, color: Colors.red),
                ),
                Marker(
                  point: LatLng(51.511, -0.13),
                  child: Icon(Icons.location_on, color: Colors.red),
                ),
              ],
              builder: (context, markers) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      markers.length.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _fetchUserLocation,
            child: Icon(Icons.gps_fixed),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _addPolyline,
            child: Icon(Icons.alt_route),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _addPolygon,
            child: Icon(Icons.crop_square),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        width: double.infinity,
        child: Text('Address: $_address', textAlign: TextAlign.center),
      ),
    );
  }
}

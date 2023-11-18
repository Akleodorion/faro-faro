import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen(
      {super.key, required this.markerLat, required this.markerLng});

  final double markerLat;
  final double markerLng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Location of the event'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          zoom: 16,
          target: LatLng(markerLat, markerLng),
        ),
        markers: {
          Marker(
            markerId: const MarkerId('mark1'),
            position: LatLng(markerLat, markerLng),
          ),
        },
      ),
    );
  }
}

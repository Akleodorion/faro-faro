import 'package:faro_clean_tdd/pages/ticket_page/constants/ticket_page_strings.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double markerLat = 37.4224428;
  double markerLng = -122.0842467;
  LatLng? _picketLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          TicketPageString.pickLocation,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop(
                _picketLocation,
              );
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: GoogleMap(
        onTap: (position) {
          setState(
            () {
              markerLat = position.latitude;
              markerLng = position.longitude;
              _picketLocation = position;
            },
          );
        },
        initialCameraPosition: const CameraPosition(
          zoom: 16,
          target: LatLng(37.4224428, -122.0842467),
        ),
        markers: {
          Marker(
            markerId: const MarkerId('mark1'),
            position: _picketLocation ?? LatLng(markerLat, markerLng),
          ),
        },
      ),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class LocationPickerScreen extends StatefulWidget {
  late GoogleMapController? mapController;

  LocationPickerScreen({Key? key}) : super(key: key);

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  LatLng? selectedLocation;
  LatLng? userLocation;
  MapType currentMapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    // Initialize the mapController
    widget.mapController =
        null; // Or initialize it to a default value if needed
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        userLocation = LatLng(position.latitude, position.longitude);
      });

      // Move the camera to the user's location
      if (widget.mapController != null && userLocation != null) {
        widget.mapController!.moveCamera(
          CameraUpdate.newLatLngZoom(userLocation!, 14.0),
        );
      }
    } catch (e) {
      print('Error getting user location: $e');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      widget.mapController = controller;
    });
    // Uncomment the following line if you want to move the camera to the user's location when the map is created
    // _getUserLocation();
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      if (currentMapType == MapType.normal) {
        currentMapType = MapType.satellite;
      } else if (currentMapType == MapType.satellite) {
        currentMapType = MapType.hybrid;
      } else if (currentMapType == MapType.hybrid) {
        currentMapType = MapType.terrain;
      } else {
        currentMapType = MapType.normal;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pick Location',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 80,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // Return the selected location to the previous screen
              Navigator.pop(context, selectedLocation);
            },
          ),
          IconButton(
            icon: const Icon(Icons.layers),
            onPressed: _onMapTypeButtonPressed,
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: userLocation ?? const LatLng(37.7749, -122.4194),
          zoom: 14.0,
        ),
        onTap: (LatLng position) {
          // Update the selected location and move the camera to it
          setState(() {
            selectedLocation = position;
            if (widget.mapController != null) {
              widget.mapController!.animateCamera(
                CameraUpdate.newLatLng(position),
              );
            }
          });
        },
        markers: userLocation != null
            ? {
                Marker(
                  markerId: const MarkerId('userLocation'),
                  position: userLocation!,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue,
                  ),
                ),
                // Add a custom marker for the selected location
                if (selectedLocation != null)
                  Marker(
                    markerId: const MarkerId('selectedLocation'),
                    position: selectedLocation!,
                    icon: BitmapDescriptor.defaultMarker,
                  ),
              }
            : {},
        mapType: currentMapType,
      ),
    );
  }
}

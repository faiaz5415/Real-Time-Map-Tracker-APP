import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? mapController;
  final Location location = Location();

  LatLng? currentLocation;
  final List<LatLng> polylinePoints = [];
  final Set<Polyline> polylines = {};
  final Set<Marker> markers = {};

  Timer? locationTimer;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    final hasPermission = await _requestLocationPermission();
    if (hasPermission) {
      await _getInitialLocation();
      _startLocationUpdates();
    }
  }

  Future<bool> _requestLocationPermission() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return false;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return false;
    }
    return true;
  }

  Future<void> _getInitialLocation() async {
    try {
      final userLocation = await location.getLocation();
      final newLocation = LatLng(userLocation.latitude!, userLocation.longitude!);

      if (mounted) {
        setState(() {
          currentLocation = newLocation;
          polylinePoints.add(newLocation);
          _updateMarker(newLocation);
        });
      }
    } catch (e) {
      debugPrint('Error getting initial location: $e');
    }
  }

  void _startLocationUpdates() {
    locationTimer = Timer.periodic(const Duration(seconds: 10), (_) async {
      try {
        final userLocation = await location.getLocation();
        final newLocation = LatLng(userLocation.latitude!, userLocation.longitude!);

        if (mounted) {
          setState(() {
            polylinePoints.add(newLocation);
            _updatePolyline();
            currentLocation = newLocation;
            _updateMarker(newLocation);
          });
          _animateToLocation(newLocation);
        }
      } catch (e) {
        debugPrint('Error updating location: $e');
      }
    });
  }

  void _updateMarker(LatLng position) {
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId('current_location'),
        position: position,
        infoWindow: InfoWindow(
          title: 'My current location',
          snippet: 'Lat: ${position.latitude}, Lng: ${position.longitude}',
        ),
      ),
    );
  }

  void _updatePolyline() {
    polylines.add(
      Polyline(
        polylineId: const PolylineId('location_track'),
        points: polylinePoints,
        color: Colors.blue,
        width: 5,
      ),
    );
  }

  void _animateToLocation(LatLng location) {
    mapController?.animateCamera(
      CameraUpdate.newLatLng(location),
    );
  }

  @override
  void dispose() {
    locationTimer?.cancel();
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Real-Time Tracker")),
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
        onMapCreated: (controller) => mapController = controller,
        initialCameraPosition: CameraPosition(
          target: currentLocation!,
          zoom: 16,
        ),
        markers: markers,
        polylines: polylines,
      ),
    );
  }
}
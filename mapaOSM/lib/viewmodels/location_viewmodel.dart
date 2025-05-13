import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/location_model.dart';
import '../services/location_service.dart';

class LocationViewModel extends ChangeNotifier {
  final LocationService _locationService = LocationService();

  LocationModel? _location;
  bool _isLoading = true;

  LocationModel? get location => _location;
  bool get isLoading => _isLoading;

  Future<void> fetchLocation() async {
    _isLoading = true;
    notifyListeners();

    Position? position = await _locationService.getCurrentPosition();

    if (position != null) {
      _location = LocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    }

    _isLoading = false;
    notifyListeners();
  }
}
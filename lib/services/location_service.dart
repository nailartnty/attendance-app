import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

// TEMPAT MENGOLAH LOKASI
Future<void> getGeoLocationPosition(BuildContext context, Function(Position) onPositionReceived) async {
  // ignore: deprecated_member_use
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low); // pke low karena biar dia hemat baterai
  onPositionReceived(position);
}

Future<void> getAddressFromLongLat(Position position, Function(String) onAddressReceived) async {
  // placemark bawaan dari geocoding untuk memberikan detail alamat dari posisi kita
  // lat = vertikal, long = horizontal
  List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
  Placemark place = placemark[0]; 
  String address = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";// kita ambil data latlong dari placemark
  onAddressReceived(address); // cara memanggil address
}

Future<bool> handleLocationPermission(BuildContext context) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.location_off_outlined,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "Location services are disable. Please enable the services",
              style: TextStyle(color: Colors.white),
            )
          ]
        ),
        backgroundColor: Colors.blueGrey,
        shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating, // biar kayak notificastion bisa hilang
      )
    ); 
    return false; // untuk memblokir user
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission =  await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.location_off_outlined,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                "Location permission denied",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          backgroundColor: Colors.blueGrey,
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating, // biar kayak notificastion bisa hilang
        )
      );
      return false; // untuk memblokir 
    }
  }

  if (permission == LocationPermission.deniedForever) { // proses penolakan permission secara permanen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.location_off_outlined,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "Location permission denied forever, we cannot access.",
              style: TextStyle(color: Colors.white),
            )
          ]
        ),
        backgroundColor: Colors.blueGrey,
        shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating, // biar kayak notificastion bisa hilang
      )
    );
    return false; // untuk memblokir user
  }

  // ini yg positifny (else)
  return true; // dimana user sudah mengizinkan semuanya
}
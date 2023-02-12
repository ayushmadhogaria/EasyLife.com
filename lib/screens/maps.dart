// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

// class LocationScreen extends StatefulWidget {
//   @override
//   _LocationScreenState createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   Position _currentPosition;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   _getCurrentLocation() async {
//     final position = await Geolocator()
//         .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       _currentPosition = position;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Current Location"),
//       ),
//       body: Center(
//         child: _currentPosition != null
//             ? Text("Latitude: ${_currentPosition.latitude}, Longitude: ${_currentPosition.longitude}")
//             : Text("Loading..."),
//       ),
//     );
//   }
// }

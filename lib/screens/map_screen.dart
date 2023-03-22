import 'package:easylifeapp/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = '/maps-screen';

  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String locationAddress = "Pick the location";

  double latitude = 27.7052, longitude = 85.3349;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: GlobalVariables.unselectednavbarcolor,
          title: const Padding(
            padding: EdgeInsets.only(left: 70.0),
            child: Text('Flutter Map'),
          ),
        ),
        body: InkWell(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: double.infinity,
                color: GlobalVariables.unselectednavbarcolor,
                child: Center(
                  child: Text(
                    locationAddress,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
          onTap: () {
            _showModel(context);
          },
        ));
  }

  void _showModel(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 800,
            child: Center(
              child: OpenStreetMapSearchAndPick(
                center: LatLong(latitude, longitude),
                buttonColor: GlobalVariables.unselectednavbarcolor,
                buttonText: 'Set Destination',
                onPicked: (pickedData) {
                  Navigator.pop(context);
                  setState(() {
                    locationAddress = pickedData.address;
                    latitude = pickedData.latLong.latitude;
                    longitude = pickedData.latLong.longitude;
                  });
                },
              ),
            ),
          );
        });
  }
}

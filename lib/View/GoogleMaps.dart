import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "نمایندگی های ما",
          style: TextStyle(fontFamily: 'vazir', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GoogleMap(
        markers: <Marker>{
          const Marker(
              position: LatLng(35.7218995, 51.3388785),
              markerId: MarkerId("1")),
          const Marker(
              position: LatLng(35.7282839, 51.3548966),
              markerId: MarkerId("2")),
          const Marker(
              position: LatLng(35.73954, 51.3689485), markerId: MarkerId("3"))
        },
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
            target: LatLng(
              35.7219,
              51.3347,
            ),
            zoom: 14),
      ),
    );
  }
}

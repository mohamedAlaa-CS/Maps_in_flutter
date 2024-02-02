import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //! intial camera position بتشوف انت عاوز تعرض اي اول ما جوجل ماب تفتح(تفتح علي اي )
  //? zoom بيحدد درجه الزوم اللي انت محتاجها
  /* 
  world view 0 -> 3
  country view 4 -> 6
  city view 10 -> 12
  street view 13 -> 17
  building view 18 -> 20
  */
  late CameraPosition initialCameraPosition;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      zoom: 10,
      target: LatLng(31.0399088096436, 31.38043737066807),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
      ),
    );
  }
}

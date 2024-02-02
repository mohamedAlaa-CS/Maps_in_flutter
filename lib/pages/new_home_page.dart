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
  //! bounds بتحدد الحدود بتاعتي في كاميرا مينفعش اتخطاها (مينفعش يعمل زووم اللي علي المكان اللي انا حديته)
  /*
  latLongBounds -
   southWest -> محدد مكان جنوب غرب
   northeast -> محدد مكان شمال شرق
  */

  //? Google map controller لو انا عاوز اتحكم في جوجل ماب محتاج اعمل كونترولر
  /*
  بس هنا مش هعمل هنشيلايز للكونترولر دا في انيت استست هيكون عندي فانكشن اسمها 
  on map create 
  دي اقدر استقبل منها كونترولر واسويها بالكونترولر اللي انا عملته 
  وبكدا اقدر اتحكم في 
  google map
  */
  //! controller.animatedCamera لو انا عاوز اعمل انيميت للكميرا
  /*
  اقدر اعمل انيميت لاكتر من حاجه زي
   camera 
   latlong
   latlongzoom
   علي حسب انا محتاج اعمل ابديت ل اي بالظبط
  */
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      zoom: 10,
      target: LatLng(31.0399088096436, 31.38043737066807),
    );
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              googleMapController = controller;
            },
            // cameraTargetBounds: CameraTargetBounds(
            //   LatLngBounds(
            //     southwest: const LatLng(31.01894681296261, 31.34570983189044),
            //     northeast: const LatLng(31.082838279807444, 31.420122594768927),
            //   ),
            // ),
            initialCameraPosition: initialCameraPosition,
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                CameraPosition newCamerPosition = const CameraPosition(
                  zoom: 12,
                  target: LatLng(
                    30.882163589907847,
                    31.457489329231365,
                  ),
                );
                googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition(newCamerPosition),
                );
              },
              child: const Text('change postion'),
            ),
          )
        ],
      ),
    );
  }
}

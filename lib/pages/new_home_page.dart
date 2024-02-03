import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map/models/place_model.dart';

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

  //? markers اننا احدد مركر او علامه علي الخريطه
  /*
   بيكون كم نوع set
   عشان مينفعش اكرر مكان 
   - كل مكان بيكون له مركر واحد مش شرط اكتر من مركر يشاور علي نفس المكان
  */
  //! infoWindow لو انا عاوز اضيف بيانات للمركر بتاعي
  //? size of marker لو انا عاوز اغير حجم الماركر
  /*
لو انا عاوز اغير حجم الماركر قدامي طريقتين 
١ -> ان احنا نكتب كود زي الميثود (getImageFormRawData)
٢ -> ان احنا نستخدم تول من علي النت زي مثلا (image resize)
ودي بحدد فيها الطول والعرض اللي انا عاوزه
  */
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  Set<Polyline> polyLines = {};
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      zoom: 10,
      target: LatLng(31.0399088096436, 31.38043737066807),
    );
    initMarker();
    initPolylines();
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

            // لو انا عاوز اخفي الزوم ان اللي بتكون مجوده علي اليمين
            zoomControlsEnabled: false,
            polylines: polyLines,
            markers: markers,
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

  Future<Uint8List> getImageFormRawData(String image, double width) async {
    var imageData = await rootBundle.load(image);
    var imageCodec = await ui.instantiateImageCodec(
      imageData.buffer.asUint8List(),
      targetWidth: width.round(),
    );
    var imageFrame = await imageCodec.getNextFrame();
    var imageBytData =
        await imageFrame.image.toByteData(format: ui.ImageByteFormat.png);
    return imageBytData!.buffer.asUint8List();
  }

  void initMarker() async {
    var customMarkerIcon = BitmapDescriptor.fromBytes(
        await getImageFormRawData('assets/mages/marker_icon.png', 100));

    var myMarkers = PlaceModel.places
        .map(
          (placeModel) => Marker(
            icon: customMarkerIcon,
            infoWindow: InfoWindow(title: placeModel.name),
            markerId: MarkerId(placeModel.id.toString()),
            position: placeModel.latLng,
          ),
        )
        .toSet();
    markers.addAll(myMarkers);
    setState(() {});
  }

  void initPolylines() {
    Polyline polyline = const Polyline(
      width: 5,
      startCap: Cap.roundCap,
      color: Colors.purple,
      patterns: [PatternItem.dot],
      endCap: Cap.roundCap,
      //لو في نقطتين بعاد جدا وعاوز اظهر ان في كيرف بينهم
      geodesic: true,
      // لو انا عاوز احدد خط فوق خط
      zIndex: 1,
      polylineId: PolylineId('1'),
      points: [
        LatLng(30.994302816374745, 31.357091423877332),
        LatLng(31.006368460199997, 31.411851402011493),
        LatLng(31.055056936726935, 31.379235741053844),
        LatLng(31.0826997277597, 31.420434470684558)
      ],
    );
    polyLines.add(polyline);
  }
}

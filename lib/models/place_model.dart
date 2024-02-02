import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel({
    required this.id,
    required this.name,
    required this.latLng,
  });

  static List<PlaceModel> places = [
    PlaceModel(
        id: 1,
        name: 'المصريه للاتصالات اولاد صقر',
        latLng: const LatLng(30.922301998021013, 31.693054430566388)),
    PlaceModel(
        id: 2,
        name: 'مشويات حسني',
        latLng: const LatLng(31.138226989855006, 31.244260907563444)),
    PlaceModel(
        id: 3,
        name: 'حضتنه الشافعي',
        latLng: const LatLng(31.022249753995286, 31.32030057071774)),
  ];
}

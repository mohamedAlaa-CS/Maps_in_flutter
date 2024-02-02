import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map/pages/new_home_page.dart';

Future<Position?> getCurrentLocation(context) async {
  LocationPermission permission;
  bool serviceEnabled;

  try {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Handle location service not enabled
      throw Exception('Location service is not enabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle location permission denied
        throw Exception('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      bool shouldOpenSettings = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('تصريح الوصول'),
          content: const Text(
              'تم رفض تصريح الوصول للموقع بشكل دائم. هل تود فتح إعدادات التطبيق لتمكينه؟'),
          actions: [
            TextButton(
              child: const Text('لا'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('نعم'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        ),
      );
      if (shouldOpenSettings) {
        await Geolocator.openLocationSettings();
        return getCurrentLocation(context); // Retry getting location
      } else {
        // Handle location permission denied forever
        throw Exception('Location permission denied forever');
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  } catch (e) {
    // Handle exceptions and errors here
    print('An error occurred: $e');
    return null;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'google maps',
      home: HomePage(),
    );
  }
}

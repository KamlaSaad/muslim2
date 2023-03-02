import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LoCation extends GetxController{
  var longitude=0.0.obs,
      latitude=0.0.obs;
  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('disabled');
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('denied');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // return 'deniedForever';
      print('deniedForever');
      // return 'denied';
      return null;
    }
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    longitude.value=position.longitude;
    latitude.value=position.latitude;
    // print(position.latitude);
    // print(position.longitude);
    return position;
  }
}
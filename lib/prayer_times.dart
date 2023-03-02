import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'location.dart';
import 'shared.dart';
import 'dart:async';

void updateTimes() {
  Timer.periodic(Duration(hours: 24), (timer) async {
    prayerTimes.value = await getPrayerTimes();
  });
}

getPrayerTimes() async {
  List times = [];
  LoCation loc=LoCation();
  Position position = await loc.getLocation();
  final myCoordinates = Coordinates(position.latitude,position.longitude); // Replace with your own location lat, lng.
  final params = CalculationMethod.egyptian.getParameters();
  params.madhab = Madhab.hanafi;
  final prayerTimes = PrayerTimes.today(myCoordinates, params);
  times.add(prayerTimes.fajr);
  times.add(prayerTimes.dhuhr);
  times.add(prayerTimes.asr);
  times.add(prayerTimes.maghrib);
  times.add(prayerTimes.isha);
  return times;
}

isPrayerTime() async {
  bool result = false;
  for (int x = 0; x < prayerTimes.length; x++) {
    if (prayerTimes[x].difference(DateTime.now()).inMinutes == 0) {
      result = true;
    }
  }
  return result;
}

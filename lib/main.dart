//import 'package:audioplayer/audioplayer.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:muslim/ahadees.dart';
import 'package:muslim/allah_names.dart';
import 'package:muslim/azkar_list.dart';
import 'package:muslim/location.dart';
import 'package:muslim/qiblah.dart';
import 'package:muslim/quran.dart';
import 'package:muslim/quran_list.dart';
import 'package:muslim/quran_page.dart';
import 'package:muslim/shared.dart';
import 'package:workmanager/workmanager.dart';
import 'package:cron/cron.dart';
import 'dart:async';
import 'azkar.dart';
import 'bearish.dart';
import 'home.dart';
import 'prayers.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
// import 'package:adhan_dart/adhan_dart.dart';

import 'prayer_times.dart';
import 'settings.dart';

Workmanager workmanager = Workmanager();

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print("Native called background task"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();
  await intializeVars();
  prayerTimes.value = await getPrayerTimes();
  //saly 3ly mhmd
  // Workmanager().initialize(azanCallback(),isInDebugMode:true );
  // Workmanager().registerPeriodicTask("periodic-task-identifier","simplePeriodicTask",
  //   initialDelay: Duration(minutes: 1),frequency: Duration(minutes: 1),
  // );
  Workmanager().initialize(mdmdCallback,isInDebugMode:true );
  Workmanager().registerPeriodicTask("periodic-task-identifier","simplePeriodicTask",
    initialDelay: Duration(minutes: 1),frequency: Duration(minutes: 3),
  );

  // tz.initializeTimeZones();
  // LoCation loc=LoCation();
  // final location =await loc.getLocation();

  // Definitions
  // DateTime date = tz.TZDateTime.from(DateTime.now(), location);
  // Coordinates coordinates = Coordinates(loc.latitude.value,loc.longitude.value);

  // Parameters
  // CalculationParameters params = CalculationMethod.MuslimWorldLeague();
  // CalculationParameters params = CalculationMethod.Egyptian();
  // params.madhab = Madhab.Hanafi;
  // PrayerTimes prayerTimes =
  // PrayerTimes(coordinates, DateTime.now(), params, precision: true);

  // Prayer times
  // DateTime fajrTime = tz.TZDateTime.from(prayerTimes.fajr!, location);
  // DateTime sunriseTime = tz.TZDateTime.from(prayerTimes.sunrise!, location);
  // DateTime dhuhrTime = tz.TZDateTime.from(prayerTimes.dhuhr!, location);
  // DateTime asrTime = tz.TZDateTime.from(prayerTimes.asr!, location);
  // DateTime maghribTime = tz.TZDateTime.from(prayerTimes.maghrib!, location);
  // DateTime ishaTime = tz.TZDateTime.from(prayerTimes.isha!, location);
  // print("fajrTime $fajrTime");

 final cron = Cron();
 cron.schedule(Schedule.parse('*/1 * * * *'), () async {
   bool isPrayerT = await isPrayerTime();
   if (isPrayerT) audioCache.play("azan.mp3");
 });
//  cron.schedule(Schedule.parse('*/120 * * * *'), () async {
//    audioCache.play("mhmd.mp3");
//  });

//  List database = await retreiveItems("MORNING");
//  if (database.isEmpty) {
//    List data = await fetchData();
//    print("=================database=================");
//    print(database);
//    if (data.isNotEmpty) {
//      await addAllData(data);
//    }
//    print(data);
//  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      getPages: [
        GetPage(name: '/home', page:() => MyHomePage()),
        GetPage(name: '/quran', page:() => QuranList()),
        GetPage(name: '/quranPage', page:() =>  QuranPage()),
        GetPage(name: '/azkarList', page:() => AzkarList()),
        GetPage(name: '/azkar', page:() => Azkar()),
        GetPage(name: '/surah', page:() => Surah()),
        GetPage(name: '/allahNames', page:() => AllahNames()),
        GetPage(name: '/ahadees', page:() => Ahadees()),
        GetPage(name: '/prayers', page:() => Prayers()),
        GetPage(name: '/bearish', page:() => Bearish()),
        GetPage(name: '/qiblah', page:() => QiblahCompass()),
        GetPage(name: '/qiblah', page:() => QiblahCompass()),

      ],
    );
//        });
  }
}

mdmdCallback() {
  Workmanager().executeTask((task, inputData) async {
    await audioCache.play('mhmd.mp3');
    return Future.value(true);
  });
}

azanCallback() {
  Workmanager().executeTask((task, inputData) async {
    bool azanTime = await isPrayerTime();
    if (!azanTime) {
      await audioCache.play('azan.mp3');
    }
    return Future.value(true);
  });
}


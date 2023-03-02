import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muslim/quran.dart';
import 'package:muslim/shared.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var flutterLN;
  @override
  void initState() {
//    super.initState();
//    db = DbHelper();
//    var androidSetting = AndroidInitializationSettings('logo');
//    var IOSSetting = IOSInitializationSettings();
//    var settings =
//        InitializationSettings(android: androidSetting, iOS: IOSSetting);
//    flutterLN = FlutterLocalNotificationsPlugin()..initialize(settings);
//    listenNotify();
  }

  Future notification(String msg) async {
//    var androidDetails = AndroidNotificationDetails("channelId", "channelName");
//    var iosDetails = IOSNotificationDetails();
//    var notDetails =
//        NotificationDetails(android: androidDetails, iOS: iosDetails);
//    flutterLN.show(0, "اذكار المسلم", msg, notDetails);
  }

  List pages = [
    {"img": "quran4.png", "page": "quran", "title": "القران الكريم"},
    {"img": "azkar1.png", "page": "azkarList", "title": "الاذكار"},
    {"img": "pray.png", "page": "prayers", "title": "جوامع الدعاء"},
    {"img": "ahadees.png", "page": "ahadees", "title": "احاديث"},
    {"img": "roqya.png", "page": "prayers", "title": "الرقية الشرعية"},
    {"img": "allah2.png", "page": "allahNames", "title": "الاسماء الحسني"},
    {"img": "kaba.jpg", "page": "qiblah", "title": "القبلة"},
    {"img": "bearish.png", "page": "bearish", "title": "المسبحة"},
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() => Scaffold(
              backgroundColor: bodyColor.value,
              appBar: AppBar(
                backgroundColor: boxColor.value,
                leading: CircleAvatar(
                  backgroundImage: AssetImage("imgs/azkar.png"),
                  backgroundColor: Colors.transparent,
                  radius: 14,
                ),
                title: Txt('مسلم', txtColor.value, FontWeight.w500, 25),
                actions: [
                  Obx(() =>
                  IconButton(
                    icon: Icon(
                      darkMode.value?Icons.nightlight:Icons.nightlight_outlined,
                      color: txtColor.value,
                    ),
                    onPressed: () {
                      darkMode.value != darkMode.value;
                      toggleTheme();
                      storageBox.write("darkMode", darkMode.value);
                    }
                  ))
                ],
              ),
              body: GridView.builder(
                itemCount: pages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 0, mainAxisSpacing: 0),
                itemBuilder: (BuildContext context, int i) {
                  return HomeBox(
                      pages[i]['img'], pages[i]['title'], pages[i]['page']);
                },
              ),
            )));
  }
}

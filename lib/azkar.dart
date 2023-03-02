// import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:muslim/data/azkar.dart';
import 'package:muslim/shared.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:audioplayers/audio_cache.dart';
import 'package:get/get.dart';

//
//AudioPlayer player = AudioPlayer();
//AudioCache audioCache = AudioCache(fixedPlayer: player);
//String item = "", count = "", audio = "";
bool playing = false;

class Azkar extends StatefulWidget {
  @override
  _AzkarState createState() => _AzkarState();
}

class _AzkarState extends State<Azkar> {
  String title = Get.arguments[0];
  int length = 0, listIndex = Get.arguments[1];
  List data = [];

  @override
  _AzkarState createState() => _AzkarState();

  int i = 0, dataLength = 1;

  @override
  Widget build(BuildContext context) {
    data = azkar[listIndex];
    length = data.length;
    double w = width * 0.9;
    double w2 = width * 0.42;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: bodyColor.value,
          appBar: Bar(title, false, 0),
          body: SingleChildScrollView(
//            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Box((i + 1).toString(), mainColor.value, Colors.white, 50, 6,
                    10, () {}),
                data[i]['when'] != null
                    ? Center(
                        child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: Txt(data[i]['when'], mainColor1,
                            FontWeight.w500, 18),
                      ))
                    : SizedBox(height: 0),
                Box(data[i]['item'], boxColor.value, txtColor.value, w, 6, 10,
                    () {}),
                Box(count(data[i]['count']), mainColor.value, Colors.white, w,
                    6, 10, () {}),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Box("الذكر السابق", boxColor.value, txtColor.value, w2, 6,
                        10, () => decrement()),
                    Box("الذكر التالي ", boxColor.value, txtColor.value, w2, 6,
                        10, () => increment()),
                  ],
                ),
                SizedBox(height: 10)
              ],
            ),
          )),
    );
  }

  decrement() {
    setState(() {
      if (i > 0) i--;
    });
  }

  increment() {
    setState(() {
      if (i < length - 1) i++;
    });
  }

  String count(num) {
    String txt = "";
    if (num == "1")
      txt = "مرة واحدة";
    else if (num == "2")
      txt = "مرتان";
    else
      txt = "$num مرات";
    return txt;
  }
}

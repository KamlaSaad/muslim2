//import 'package:audioplayer/audioplayer.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:audioplayers/audio_cache.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:muslim/prayer_times.dart';
import 'package:muslim/quran.dart';
import 'package:muslim/quran_list.dart';
import 'package:muslim/shared.dart';
import 'package:get/get.dart';
import 'dart:io';

class Bearish extends StatefulWidget {
  @override
  _BearishState createState() => _BearishState();
}

class _BearishState extends State<Bearish> {
  int zkrIndex=0,syghaNo=0;
  String zkr="سبحان الله ";
  List azkar = [
    'سبحان الله ',
    'سبحان الله وبحمده',
    'سبحان الله وبحمده سبحان الله العظيم ',
    'الحمد لله',
    'لا اله الا الله',
    'الله اكبر',
    'استغفر الله العظيم',
    'لاحول ولا قوة الا بالله',
    // 'لا اله الا الله وحده لاشريك له له الملك وله الحمد يحي ويميت وهو علي كل شئ قدير',
    'اللهم صلي علي سيدنا محمد',
    // 'اللهم صل وبارك على محمد وآل محمد كما صليت وباركت على إبراهيم وآل إبراهيم إنك حميد مجيد',
//    ''
  ];
  List sygh=[
    "عدد كمال الله وكما يليق بكماله",
    "عدد خلقه ورضا نفسه وزنة عرشة ومداد كلماته",
    "عدد ماخلق وملء ماخلق",
    "عدد مااخصي كتابه وملء مااحصي كتابه",
    " عدد مافي السموات والارض وملء مافي السموات والارض",
    " عدد كل شئ وملء كل شئ",
    "لاشئ"
  ];
  void startServiceInPlatform() async {
    if (Platform.isAndroid) {
      var methodChannel = MethodChannel("lightacademy/channel");
      String data = await methodChannel.invokeMethod("playMusic");
      debugPrint(data);
    }
  }

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bodyColor.value,
        appBar: Bar("السبحة", false, 0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Box("الذكر", mainColor.value, txtColor.value, width * 0.5, 6,
                      0, () {
                        menu(true, azkar);
                      }),
                  Box("الصيغة",  bodyColor.value,txtColor.value, width * 0.5, 6,
                      0, () {
                        menu(false, sygh);
                      })
                ],
              ),
              SizedBox(height: height * 0.03),
              Container(height: 100,
                  width: width,
                  padding:
                  EdgeInsets.symmetric(horizontal: width * 0.15),
                  child: Center(child: SingleChildScrollView(child: largeTxt(zkr)))),
              // CarouselSlider(
              //     options: CarouselOptions(
              //         viewportFraction: 1,
              //         height: height * 0.15,
              //         enableInfiniteScroll: false,
              //         onPageChanged: (int i, reason) =>
              //             setState(() => counter = 0)),
              //     items: zkr.map((i) {
              //       return Builder(builder: (BuildContext context) {
              //         return Container(
              //             width: width,
              //             padding:
              //                 EdgeInsets.symmetric(horizontal: width * 0.15),
              //             child: Center(child: largeTxt(i)));
              //       });
              //     }).toList()),
//              SizedBox(
//                  height: height * 0.15,
//                  width: width,
//                  child: ListView.builder(
//                      scrollDirection: Axis.horizontal,
//                      itemCount: data.length,
//                      itemBuilder: (context, i) {
//                        return SingleChildScrollView(
//                          child: Container(
//                              width: width,
//                              padding: EdgeInsets.symmetric(
//                                  horizontal: width * 0.15),
//                              child: Center(child: largeTxt(data[i]))),
//                        );
//                      })),
              SizedBox(height: height * 0.02),
              Txt(counter.toString(), txtColor.value, FontWeight.w600, 40),
              SizedBox(height: height * 0.03),
              CircleAvatar(
                  radius: height * 0.16,
                  backgroundColor: mainColor.value.withOpacity(0.8),
                  child: Button(
                    height * 0.18,
                    mainColor.value,
                    () async {
                      var data=await getPrayerTimes();
                      print(data);
//                      startServiceInPlatform();
                      setState(() => counter++);
                      // prayerTimes.value = await getPrayerTimes();
                    },
                  )),
              Spacer(),
              // Spacer(),
              TextButton(
                child: Txt("اعادة", mainColor.value,FontWeight.w500, 18),
                onPressed: () => setState(() => counter = 0)
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     //SizedBox(width: 6,),
              //     Button(26, Colors.red, () => setState(() => counter = 0)),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget Button(double size, Color color, press) {
    return Container(
      height: size,
      width: size,
      decoration: dec(size, color),
      child: GestureDetector(
        child: null,
        onTap: press,
      ),
    );
  }

  BoxDecoration dec(double size, Color color) {
    return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size / 2),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
          )
        ]);
  }

void menu(bool z,List data){
  Get.defaultDialog(
    radius: 0,
    backgroundColor: boxColor.value,
    title: z?"اختر ذكر":"",
    titleStyle: TxtStyle(mainColor.value, FontWeight.w500, 22),
    contentPadding: const EdgeInsets.all(0),
    content: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(padding:const EdgeInsets.all(2),
          height: height*0.5,
          width: width*0.75,
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context,i){
                return ListTile(title: Txt(data[i], txtColor.value,
                    FontWeight.w500, 16),onTap: (){
                  print(data[i]);
                  setState(() {
                    if(z) {
                            zkrIndex = i;
                          } else {
                            syghaNo = i;
                          }
                    String txt=syghaNo==6?"":sygh[syghaNo];
                    zkr=azkar[zkrIndex]+" "+ txt;
                  });
                  Get.back();
                });
              }),
        )),

  );
}
String longZkr(int syghaI){
    String result="عدد ماخلق وملء ماخلق  عدد مااخصي كتابه وملء مااحصي كتابه عدد مافي السموات والارض ";
    return result;
}
}
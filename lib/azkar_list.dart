import 'package:flutter/material.dart';
import 'package:muslim/data/azkar.dart';
import 'package:muslim/shared.dart';
import 'package:quran/quran.dart' as quran;
import 'package:get/get.dart';

class AzkarList extends StatelessWidget {
  var list = [
    "اذكار الصباح",
    "اذكار المساء",
    "اذكار الاستيقاظ",
    "اذكار النوم",
    "اذكار الصلاة",
    "اذكار الوضوء",
    "اذكار المسجد",
    "اذكار الطعام",
    "اذكار المنزل",
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bodyColor.value,
       appBar: AppBar(elevation: 0,
           centerTitle: true,backgroundColor: bodyColor.value,
           title: Txt("اذكار المسلم", mainColor.value, FontWeight.w600, 24)),
        body: SafeArea(
          // child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     SizedBox(height: 10),
          //     Center(
          //         child:
          //             Txt("اذكار المسلم", txtColor.value, FontWeight.w500, 22)),
          //     SizedBox(height: 10),
          //     SizedBox(
          //       height: height * 0.74,
          //       width: width,
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                          tileColor: boxColor.value,
                          leading: CircleAvatar(
                            radius: 23,
                            backgroundColor: mainColor.value,
                            child: Txt(
                                "${i + 1}", Colors.white, FontWeight.w500, 21),
                          ),
                          title:
                              Txt(list[i], txtColor.value, FontWeight.w600, 20),
                          onTap: () {
                            print(list[i]);
                            Get.toNamed("azkar", arguments: [list[i], i]);
                          },
                        ),
                      );
                    }),
              ),
      //       ],
      //     ),
      //   ),
      ),
    );
  }
}

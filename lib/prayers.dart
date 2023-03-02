import 'package:flutter/material.dart';
import 'package:muslim/data/prayers.dart';
import 'package:muslim/data/roqya.dart';
import 'package:muslim/shared.dart';
import 'package:get/get.dart';

class Prayers extends StatefulWidget {
  @override
  _PrayersState createState() => _PrayersState();
}

class _PrayersState extends State<Prayers> {
  String title = Get.arguments[0];
  bool prayer = false;
  String item = "";
  List data = [];
  @override
  Widget build(BuildContext context) {
    prayer = title == "جوامع الدعاء";
    data = prayer ? prayers : roqya;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bodyColor.value,
        appBar: Bar(title, false, 0),
        body: Padding(
          padding: EdgeInsets.only(top: 6),
          child: Body(),
        ),
      ),
    );
  }

  Widget Body() {
    return ListView.builder(
        itemCount: prayers.length,
        itemBuilder: (context, int index) {
          return Container(
            color: boxColor.value,
            padding: EdgeInsets.symmetric(vertical: 5),
            margin: EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: Box("${index + 1}", mainColor.value, Colors.white, 46, 0,
                  10, () => null),
//              Container(
//                  width: 28,
//                  height: 34,
//                  decoration: BoxDecoration(
//                    color: Colors.blueGrey,
//                    borderRadius: BorderRadius.circular(2),
//                  ),
//                  child: Center(
//                    child: Txt((index + 1).toString(), Colors.white,
//                        FontWeight.normal, 20),
//                  )),
              title: RichText(
                text: TextSpan(
                    text: data[index].toString(),
                    style: TextStyle(fontSize: 24, color: txtColor.value)),
              ),
            ),
          );
        });
  }
}

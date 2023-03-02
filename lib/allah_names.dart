import 'package:flutter/material.dart';
import 'package:muslim/data/god_names.dart';
import 'package:muslim/shared.dart';

class AllahNames extends StatefulWidget {
  @override
  _AllahNamesState createState() => _AllahNamesState();
}

class _AllahNamesState extends State<AllahNames> {
  int checkedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bodyColor.value,
        body: SafeArea(
            child:
//            Column(
//              children: [
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: [
//                    Box("الله", mainColor.value, Colors.white),
//                    Box("الرحمن", boxColor.value, txtColor.value),
//                    Box("الرحيم", boxColor.value, txtColor.value),
//                  ],
//                ),
//                SizedBox(height: 12),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: [
//                    Box("الله", boxColor.value, txtColor.value),
//                    Box("الرحمن", boxColor.value, txtColor.value),
//                    Box("الرحيم", boxColor.value, txtColor.value),
//                  ],
//                )
//              ],
//            ),
                Column(
          children: [
            SizedBox(height: height * 0.02),
            Center(
                child: Txt(
                    "اسماء الله الحسني", txtColor.value, FontWeight.w600, 22)),
            SizedBox(height: height * 0.02),
            SizedBox(
              height: height * 0.86,
              child: GridView.builder(
                itemCount: godNames.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemBuilder: (BuildContext context, int i) {
                  return Box(i);
                },
              ),
            )
          ],
        )),
      ),
    );
  }

  Widget Box(int index) {
    bool checked = index == checkedIndex;
    String name = godNames[index]['name'];
    return GestureDetector(
      child: Container(
        width: width * 0.3,
        height: 70,
        color: checked ? mainColor.value : boxColor.value,
        child: Center(
            child: Txt(name, checked ? Colors.white : txtColor.value,
                FontWeight.w600, 25)),
      ),
      onTap: () {
        print(name);
        print(index);
        setState(() => checkedIndex = index);
        godNameDesc(godNames[index]);
      },
    );
  }
}

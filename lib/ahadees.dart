import 'package:flutter/material.dart';
import 'package:muslim/shared.dart';

import 'data/ahadees.dart';

class Ahadees extends StatefulWidget {
  @override
  _AhadeesState createState() => _AhadeesState();
}

class _AhadeesState extends State<Ahadees> {
  Color btn1Color = mainColor.value, btn2Color = boxColor.value;
  int index = 0;
  List data = list1;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bodyColor.value,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
//              SizedBox(height: height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Box("احاديث قدسية", btn1Color, txtColor.value, width * 0.5, 6,
                      0, () {
                    setState(() {
                      btn1Color = mainColor.value;
                      btn2Color = boxColor.value;
                      index = 0;
                      data = list1;
                    });
                  }),
                  Box("احاديث نبوية", btn2Color, txtColor.value, width * 0.5, 6,
                      0, () {
                    setState(() {
                      btn1Color = boxColor.value;
                      btn2Color = mainColor.value;
                      index = 0;
                      data = list2;
                    });
                  })
                ],
              ),
              SizedBox(height: height * 0.02),
              Box("${index + 1}", mainColor.value, Colors.white, 55, 6, 10,
                  () {}),
              SizedBox(height: height * 0.02),
              Box(data[index], boxColor.value, txtColor.value, width * 0.86, 6,
                  10, () {}),
              SizedBox(height: height * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Box("السابق", boxColor.value, txtColor.value,
                      width * 0.40, 6, 10, () => decrement()),
                  Box("التالي", boxColor.value, txtColor.value,
                      width * 0.40, 6, 10, () => increment()),
                ],
              ),
              SizedBox(height: 10)
            ],
          ),
        )),
      ),
    );
  }

  Widget Btn(Color color, double w, double h, String txt, f) {
    return GestureDetector(
        child: Container(
            width: width * w,
            height: h,
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color,
//                border:Border.all(color: mainColor.value, width: 2)
            ),
            child: Center(
                child: Txt(
                    txt,
                    color == mainColor.value ? Colors.white : txtColor.value,
                    FontWeight.w600,
                    20))),
        onTap: f);
  }

  void increment() {
    setState(() {
      if (index < data.length - 1) index++;
    });
  }

  void decrement() {
    setState(() {
      if (index > 0) index--;
    });
  }
}

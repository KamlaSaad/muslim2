import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:muslim/prayer_times.dart';
import 'package:quran/surah_data.dart';
//import 'package:intl/intl.dart';

AudioPlayer player = AudioPlayer();
AudioCache audioCache = AudioCache();

double width = Get.width, height = Get.height;
final storageBox = GetStorage();
//storageBox.read("darkVal")

//colors
var mainColor1 = Colors.teal,
    mainColor2 = Color(0xff2ed3c3),
    mainColor3 = Color(0xffbcbcbc),
//    mainColor = Colors.teal.obs,
    mainColor = Color(0xff367c98).obs,
    // bodyColor = Color(0xffeeeeee).obs,
    bodyColor = Colors.white.obs,
    boxColor = Colors.white.obs,
    txtColor = Colors.black.obs,
    fontType = "حجم متوسط".obs,
    fontSize = 23.0.obs,
    shadowColor = Color(0x00000000),
    darkMode = false.obs,
    playing = false.obs,
    quranPageIndex = 0.obs,
    prayerTimes = [].obs;

intializeVars() async {
  darkMode.value = storageBox.read("darkMode") ?? false;
  fontSize.value = storageBox.read("fontSize") ?? 22;
  fontType.value = storageBox.read("fontType") ?? "حجم متوسط";
  quranPageIndex.value = storageBox.read("quranPageIndex") ?? 0;
  // if (prayerTimes.isEmpty) {
  //   prayerTimes.value = await getPrayerTimes();
  // }
}

toggleTheme() {
  if (darkMode.value) {
    boxColor.value = Colors.white;
    bodyColor.value = Colors.white;
    txtColor.value = Colors.black;
    darkMode.value = false;
  } else {
    boxColor.value = Color(0xff232323);
    bodyColor.value = Colors.black;
    txtColor.value = Colors.white;
    darkMode.value = true;
  }
}

AppBar Bar(String name, bool center, double shadow) {
  return AppBar(
    leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: txtColor.value,
        ),
        onPressed: () => Get.back()),
    backgroundColor: bodyColor.value,
    centerTitle: center,
    elevation: shadow,
    title: Txt(name, txtColor.value, FontWeight.w600, 22),
  );
}

bool Portrait(MediaQueryData media) {
  Orientation orientation = media.orientation;
  return orientation == Orientation.portrait ? true : false;
}

var TxtStyle = (Color color, FontWeight w, double size) =>
    TextStyle(color: color, fontSize: size, fontWeight: w, fontFamily: "Cairo");

Widget Txt(String text, Color color, FontWeight w, double size) {
  return Text(
    text,
    style: TextStyle(
        color: color, fontSize: size, fontWeight: w, fontFamily: "Cairo"),
  );
}

Widget largeTxt(String txt) {
//  RichText()
  return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: txt,
          style: TextStyle(
              color: txtColor.value,
              fontWeight: FontWeight.w600,
              fontSize: 20)));
}

String convertNum(int verseNumber) {
  var arabicNumeric = '';
  var digits = verseNumber.toString().split("").toList();

  for (var e in digits) {
    if (e == "0") {
      arabicNumeric += "٠";
    }
    if (e == "1") {
      arabicNumeric += "۱";
    }
    if (e == "2") {
      arabicNumeric += "۲";
    }
    if (e == "3") {
      arabicNumeric += "۳";
    }
    if (e == "4") {
      arabicNumeric += "٤";
    }
    if (e == "5") {
      arabicNumeric += "۵";
    }
    if (e == "6") {
      arabicNumeric += "٦";
    }
    if (e == "7") {
      arabicNumeric += "۷";
    }
    if (e == "8") {
      arabicNumeric += "۸";
    }
    if (e == "9") {
      arabicNumeric += "۹";
    }
  }

  return arabicNumeric.toString();
}

Widget HomeBox(String img, String text, String page) {
  return Container(margin: EdgeInsets.symmetric(horizontal: width*0.05,vertical: 12),
      // constraints: BoxConstraints(maxWidth: width*0.3),
          height: 151,
          decoration: BoxDecoration(
              color: boxColor.value,
              boxShadow: darkMode.value
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          padding: EdgeInsets.only(top: 6),
          child:GestureDetector(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("imgs/" + img),
                    backgroundColor: bodyColor.value,
                    radius: 45,
                  ),
                  SizedBox(height: 10),
                  Container(color: mainColor.value,
                    child: Center(child: Txt(text, Colors.white, FontWeight.normal, 15)),
    ),
                ],
              ),

      onTap: () => Get.toNamed(page, arguments: [text])),
    );
}

void getTime(DateTime date) {
  int hour = date.hour, min = date.minute;
}

formateDate(int num) {
  String result = "";
  if (num < 10)
    result = "$num 0";
  else
    result = "$num";
  return result;
}

Widget Box(String txt, Color boxColor, Color txtColor, double width,
    double margin, double radius, press) {
  var text = Txt(txt, txtColor, FontWeight.normal, 20);
  return GestureDetector(
      child: Container(
          width: width,
          margin: EdgeInsets.symmetric(vertical: margin),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(radius),
              boxShadow: [BoxShadow(color: shadowColor, blurRadius: 5)]),
          child: Center(child: text)),
      onTap: press);
}

void godNameDesc(Map item) {
  Get.defaultDialog(
      radius: 0,
      backgroundColor: boxColor.value,
      title: item['name'],
      titleStyle: TxtStyle(mainColor.value, FontWeight.w600, 23),
      content: Directionality(
          textDirection: TextDirection.rtl,
          child: Txt(item['desc'], txtColor.value, FontWeight.w500, 20)),
      cancel: null,
      confirm: null);
}

Widget radio() {
  List<Widget> radios = [];
  String groupVal = fontType.value;
  List options = ["حجم صغير", "حجم متوسط", "حجم كبير"];
  for (int i = 0; i < options.length; i++) {
    var row = Row(
      children: [
      //   Radio(
      //       activeColor: mainColor.value,
      //       value: options[i],
      //       groupValue: groupVal,
      //       onChanged: (val) => change(val, options)),
        SizedBox(width: 6),
        Txt("${options[i]}".tr, txtColor.value, FontWeight.w500, 22),
      ],
    );
    radios.add(row);
  }
  return Column(
    children: radios,
  );
}

change(val, List options) {
  if (val == options[0])
    fontSize.value = 18;
  else if (val == options[1])
    fontSize.value = 22;
  else
    fontSize.value = 26;
  storageBox.write("fontSize", fontSize.value);
  storageBox.write("fontType", fontType.value);
  Get.back();
}

void fontBox() {
  Get.defaultDialog(
      radius: 0,
      backgroundColor: boxColor.value,
      title: "حجم الخط",
      titleStyle: TxtStyle(mainColor.value, FontWeight.w500, 22),
      content:
          Directionality(textDirection: TextDirection.rtl, child: radio()));
}

void openLastPage() {
  Get.defaultDialog(
      radius: 0,
      backgroundColor: boxColor.value,
      title: "اخر قراءة",
      titleStyle: TxtStyle(mainColor.value, FontWeight.w500, 22),
      contentPadding: const EdgeInsets.all(0),
      content: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 18),
                  child: Txt("هل تريد فتح اخر قراءة؟", txtColor.value,
                      FontWeight.w500, 20)),
              Row(
                  children: [
                    DialogBtn("نعم", Colors.white, mainColor.value, () {
                Get.back();
                Get.toNamed("quranPage");
              }),
                    DialogBtn("لا", txtColor.value, boxColor.value,  () => Get.back()),
                    // Box("لا", bodyColor.value, txtColor.value, width * 0.39, 0,
                    //     0, () => Get.back()),
                  ],
              )
            ],
          )),
      confirm: null,
      cancel: null);
}
Widget DialogBtn(String txt,Color txtC,Color boxC,action){
  return Expanded(child: TextButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(boxC)),
      child: Txt(txt, txtC, FontWeight.w600, 17),onPressed: action));
}
Map getSurahData(int surahIndex){
  Map sura=surah[surahIndex]??{};
  sura["type"]=surah[surahIndex]['place']=="Makkah"?"مكية":"مدنية";
  return sura;
}











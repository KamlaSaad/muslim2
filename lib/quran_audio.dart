import 'package:flutter/material.dart';

// import 'package:muslim/shared.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class QuranAudio extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bodyColor.value,
//       body: WebView(initialUrl: "https://quran.com/1"),
//     );
//   }
// }

List qraa=["server10.mp3quran.net/ajm/128","server13.mp3quran.net/basit_mjwd","server7.mp3quran.net/s_gmd","server8.mp3quran.net/frs_a","server10.mp3quran.net/minsh","server8.mp3quran.net/afs","server12.mp3quran.net/maher","server13.mp3quran.net/husr","ia800207.us.archive.org/18/items/TvQuran.com__Jibrel","ia801208.us.archive.org/33/items/Quran-Huzza-Al_Baloushi","server11.mp3quran.net/yasser"];
List quraNames=["أحمد بن علي العجمي ","عبد الباسط عبد الصمد"," سعد الغامدي","فارس عباد","محمد صديق المنشاوي"," مشاري راشد العفاسي","ماهر المعيقلي","محمود خليل الحصري","محمد جبريل","هزاع البلوشي","ياسر الدوسري"];
String surahNo(int id){
  String result="001";
  if(id<10) result="00$id";
  else if(id<100 && id>=10) result="0$id";
  else result="$id";
  return result;
}
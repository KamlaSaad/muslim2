import 'dart:async';
import 'package:flutter/material.dart';
import 'package:muslim/shared.dart';
import 'package:quran/quran.dart' as quran;
import 'package:get/get.dart';
import 'package:quran/surah_data.dart';
import 'quran_audio.dart';

class QuranList extends StatefulWidget {
  @override
  State<QuranList> createState() => _QuranListState();
}

class _QuranListState extends State<QuranList> {
  String quranImg="quranTxtL",sura="",qaraa="";
  double bottom=-height*0.2;

  @override
  void initState() {

    Timer(Duration(seconds: 1), () => openLastPage());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    quranImg=darkMode.value?"quranTxtD":"quranTxtL";
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bodyColor.value,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: width,
                    color: bodyColor.value,
                    height: height * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width * 0.45,
                          height: height * 0.17,
                          child: Image.asset("imgs/$quranImg.png"),
                        ),
                        SizedBox(
                          width: width * 0.45,
                          child: Image.asset("imgs/quran3.png"),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: height * 0.01),
                  SizedBox(
                    height: height * 0.74,
                    width: width,
                    child: ListView.builder(
                        itemCount: quran.totalSurahCount,
                        itemBuilder: (context, i) {
                          var surah = getSurahData(i);
                          return ListItem(surah['id'],surah["arabic"], surah["aya"],  surah["type"], i);
//
                        }),
                  ),
                ],
              ),
              AudioBox()
            ],
          ),
        ),
      ),
    );
  }
  String Aya(int num){
    String txt=num<10?"آيات":"اية";
    return "$num $txt";
  }
  Widget ListItem(int id,String name,int aya,String type,int i){
    return Container(color:bodyColor.value,
      margin: EdgeInsets.only(top: 10),
      child: GestureDetector(
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            SizedBox(width: width*0.05),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CircleAvatar(
                radius: 22,
                backgroundColor: mainColor.value,
                child: Txt(
                    "${i + 1}", Colors.white, FontWeight.w500, 18),
              ),
            ),
            SizedBox(width: width*0.05),
            Container(width:width*0.56,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(" سورة $name", txtColor.value,
                      FontWeight.w600, 20),
                  Txt(Aya(aya), txtColor.value,
                      FontWeight.w500, 18),
                ],
              ),
            ),
            // SizedBox(width: width*0.2),
            Column(
              children: [
                SizedBox(height: 10),
                Txt(type, mainColor.value,
                    FontWeight.w500, 16),
                IconButton(icon: Icon(Icons.multitrack_audio,color: txtColor.value),onPressed: (){
                  print("play");
                  qura(id);
                }),
              ],),
          ],
        ),onTap: (){
        var pages = quran.getSurahPages(id);
        print("page number ${pages[0]}");
        quranPageIndex.value = pages[0] - 1;
//                            print(quran.getSurahURL(surah['id']));
        Get.toNamed("quranPage");
      },
      ),
    );
  }
  void qura(int id){
    Get.defaultDialog(
        radius: 0,
        backgroundColor: boxColor.value,
        title: "اختر قاريء",
        titleStyle: TxtStyle(mainColor.value, FontWeight.w500, 22),
    contentPadding: const EdgeInsets.all(0),
    content: Directionality(
    textDirection: TextDirection.rtl,
    child: Container(padding:const EdgeInsets.all(2),
      height: height*0.5,
      width: width*0.75,
      child: ListView.builder(
        itemCount: quraNames.length,
          itemBuilder: (context,i){
            return ListTile(title: Txt(quraNames[i], txtColor.value,
              FontWeight.w500, 16),onTap: (){
              setState(() {
                setState(()=>bottom=0);
                sura=quran.getSurahNameArabic(id);
                qaraa=quraNames[i];
              });
              print(qraa[i]);
              String suraNo=surahNo(id);
              Get.back();
              String link="http://${qraa[i]+'/'+suraNo}";
              print(link);
              player.play(link);
              print(player.mode);
            });
          }),
    )),

    );
  }
  Widget AudioBox(){
    return AnimatedPositioned(bottom: bottom,left: 0,
        duration: Duration(milliseconds: 800),
        child: Container(color: Color(0xffeeeeee),width:width,
          // padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Align(alignment:Alignment.topLeft,
                  child: SizedBox(height:18,child: CloseButton(color: txtColor.value,onPressed: (){
                    setState(()=>bottom=-width*0.3);
                    print("close");
                  }))),
              Center(
                  child:IconButton(onPressed: (){}, icon: Icon(playing.isFalse?Icons.multitrack_audio:Icons.pause_circle,color: mainColor.value,size: 60))),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Txt(" سورة $sura", mainColor.value, FontWeight.normal, 18),
                     Txt(qaraa, txtColor.value, FontWeight.normal, 18),
                  ],
                ),
              ),
              SizedBox(height: 5),
            ],
          ),

    ));
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muslim/data/quran_doaa.dart';
import 'package:quran/page_data.dart';
import 'package:quran/quran.dart' as quran;
import 'package:muslim/shared.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({Key? key}) : super(key: key);

  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  @override
  void dispose() {
    storageBox.write("quranPageIndex", quranPageIndex.value);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: bodyColor.value,
          body: SafeArea(
            child: CarouselSlider(
                options: CarouselOptions(
                    viewportFraction: 1,
                    height: height,
                    initialPage: quranPageIndex.value,
                    enableInfiniteScroll: false,
                    onPageChanged: (int i, reason) {
                      print(i);
                      setState(() => quranPageIndex.value = i);
                      // ignore: avoid_print
                    }),
                items: pageData.map((i) {
                  return quranPageIndex == 604
                      ? Builder(builder: (BuildContext context) => Doaa(context))
                      : Builder(builder: (BuildContext context) {
                          List<Widget> suras = [];
                          int juz = 1;
                          bool basmala = false;
                          for (int x = 0; x < i.length; x++) {
                            String surahName =quran.getSurahNameArabic(i[x]['surah']);
                            List surahPages = quran.getSurahPages(i[x]['surah']);
                            juz = quran.getJuzNumber(i[x]['surah'], i[x]['start']);
                            bool firstPageInSurah =quranPageIndex.value + 1 == surahPages[0];
                            basmala = i[x]['surah'] != 1 && i[x]['surah'] != 9 && firstPageInSurah;
                            var sura = SurahScreen(basmala, firstPageInSurah, i[x]['surah'], surahName, i[x]['start'], i[x]['end']);
                            suras.add(sura);
                          }
                          return Stack(
                            children: [
                              layout(SingleChildScrollView(
                                  child: Column(mainAxisAlignment: MainAxisAlignment.start,
                                      children: suras))),
                              JuzNumber(juz),
                              PageNumber(quranPageIndex.value + 1)
                            ],
                          );
                        });
                }).toList()),
          )),
    );
  }

  Widget layout(Widget child) {
    return Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 28, vertical: height * 0.05),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("imgs/layout.png"), fit: BoxFit.fill)),
        child: child);
  }

  Widget Doaa(BuildContext context) {
    return layout(Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Txt("دعاء ختم القران", txtColor.value, FontWeight.w700, 21),
          ),
//        surahName("دعاء ختم القران"),
          for (var i = 0; i < quranDoaa.length; i++) ...{
            Txt("* ${quranDoaa[i]}", txtColor.value, FontWeight.w500,
                18)
          }
        ],
      )),
    ));
  }

  Widget SurahScreen(bool basmala, bool firstPage, int surahNo, String name, int start, int end) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        firstPage ? surahName(name) : SizedBox(height: 0),
        basmala
            ? Padding(
                padding:EdgeInsets.only(top: 10),
                child: Txt(
                      "${quran.basmala}",mainColor.value, FontWeight.w600, 16),
              )
            : SizedBox(height: 0),
        SizedBox(height: 10),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(text: '',
            style: TextStyle(color: txtColor.value,fontSize: 21,fontWeight: FontWeight.w600, height: 1.8),
            children: <InlineSpan>[
              for (var i = start; i <= end; i++) ...{
                TextSpan(text: quran.getVerse(surahNo, i)),
                TextSpan(text: " (${convertNum(i)}) "),
              // WidgetSpan(
//                    child: Wrap(
//                        alignment: WrapAlignment.spaceBetween,
//                        children: [
//                      Txt(quran.getVerse(surahNo, i), txtColor.value,
//                          FontWeight.w500, 22)
//                    ])),
              }
            ],
          ),
        )
      ],
    );
  }

  Widget surahName(String name) {
    return Container(
        height: 50,
        width: width * 0.8,
        margin: const EdgeInsets.only(top: 4),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("imgs/surahN.png"), fit: BoxFit.fill)),
        child: Center(
            child: Txt("سورة $name ", txtColor.value, FontWeight.w700, 17)));
  }

  Widget PageNumber(int num) {
    return Positioned(
        right: width * 0.44,
        bottom: height * 0.0025,
        child: positinedTxt(55, 10, "${convertNum(num)}"));
  }

  Widget JuzNumber(int num) {
    return Positioned(
        left: width * 0.14,
        top: height * 0.005,
        child: positinedTxt(100, 5, "الجزء ${convertNum(num)} "));
  }

  Widget positinedTxt(double w, double r, String txt) {
    return Container(
        width: w,
        height: 35,
        decoration: BoxDecoration(
            color: bodyColor.value, borderRadius: BorderRadius.circular(r)),
        child: Center(child: Txt(txt, txtColor.value, FontWeight.w600, 21)));
  }
}

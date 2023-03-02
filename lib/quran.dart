import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:muslim/shared.dart';
import 'package:get/get.dart';
import 'package:quran/quran.dart' as quran;
import 'package:quran/page_data.dart';

class Surah extends StatefulWidget {
  @override
  _SurahState createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  var surah = {},
      currentIndex = Get.arguments[0],
      surahIndex = Get.arguments[1],
      surahNo = 1,
      verseNo = 1,
      pageNo = 1.obs,
      juz = 1;
  var controller = ScrollController();
  bool lastPage = false;
  @override
  void initState() {
    super.initState();
//    scrollController.jumpTo(index: currentPage);
  }

  @override
  Widget build(BuildContext context) {
    // surah = getSurahData(surahIndex);
    surah = getSurahData(surahIndex);
    surahNo = surah['id'];
    var pages = quran.getSurahPages(surahNo);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Text("test"),
        ),
//
      ),
//      ),
    );
  }

  Widget verses(List data) {
    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '',
        style: TextStyle(color: txtColor.value, fontSize: 25),
        children: <InlineSpan>[
          for (var i = 1; i <= data.length; i++) ...{
            TextSpan(text: data[i]),
            TextSpan(text: " (${convertNum(i)}) "),
          }
        ],
      ),
    );
  }

  Widget SurahScreen(bool firstPage, int surahNo, int start, int end) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        !firstPage
            ? Padding(
                padding: EdgeInsets.only(top: 10),
                child: Center(
                  child: Txt(
                      "${quran.basmala}", txtColor.value, FontWeight.w700, 22),
                ),
              )
            : SizedBox(height: 0),
        SizedBox(height: 10),
        RichText(
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '',
            style: TextStyle(color: txtColor.value, fontSize: 25),
            children: <InlineSpan>[
              for (var i = start; i <= end; i++) ...{
                TextSpan(text: quran.getVerse(surah['id'], i)),
                TextSpan(text: " (${convertNum(i)}) "),
              }
            ],
          ),
        )
      ],
    );
  }

  Test() {
    List<Widget> screens = [];
    List pages = pageData;
    for (int i = 0; i < pageData.length; i++) {
      List<Widget> suras = [];
      for (int x = 0; x < pageData[i].length; x++) {
        int surahNum = pageData[i][x]['surah'];
        if (surahNum > 0 && surahNum < 114) {
          // var sura = quran.getSurahData(surahNum);
          int start = pageData[i][x]['start'], end = pageData[i][x]['end'];
          juz = quran.getJuzNumber(surahNum, start);
          suras.add(SurahScreen(currentIndex == 1, surahNum, start, end));
        }
      }
      screens.add(SingleChildScrollView(
          child: Column(
        children: suras,
      )));
    }
    return CarouselSlider(
        options: CarouselOptions(
            viewportFraction: 1,
            height: height,
            initialPage: currentIndex - 1,
            enableInfiniteScroll: false,
            onPageChanged: (int i, reason) => setState(() => currentIndex = i)),
        items: screens
        );
  }

  Pages() {
    List<Widget> pages = [];
    int i = currentIndex;
    for (; i < quran.totalPagesCount; i++) {
      var pageData = quran.getPageData(i - 1);
      var surah = getSurahData(pageData[0]['surah'] - 1);
      print(surah);
      var widget = Container(
        width: width,
        height: height,
        child: Center(child: Txt("$i", txtColor.value, FontWeight.bold, 22)),
      );
      pages.add(widget);
    }

    return pages;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:muslim/shared.dart';
import 'package:get/get.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Obx(() => Scaffold(
          backgroundColor: bodyColor.value,
          appBar: Bar("", false, 1),
          body: Column(
            children: <Widget>[
              SizedBox(height: height * 0.03),
              //theme
              ListTile(
                  leading: Icon(Icons.brightness_3,
                      color: mainColor.value, size: 30),
                  title:
                      Txt("الوضع الليلي", txtColor.value, FontWeight.w500, 22),
                  trailing: SizedBox(
                      width: width * 0.15,
                      child: Obx(() => Switch(
//                        value: true,
                          value: darkMode.value,
                          onChanged: (val) {
                            darkMode.value != darkMode.value;
                            toggleTheme();
                            storageBox.write("darkMode", darkMode.value);
                          }))),
                  onTap: () {}),
              ListItem(Icons.font_download, "حجم الخط", fontBox)

              //change password
            ],
          ))),
    );
  }

  Widget ListItem(IconData icon, String txt, tap) {
    return ListTile(
        leading: Icon(icon, color: mainColor.value, size: 30),
        title: Text(txt,
            style: TextStyle(
                color: txtColor.value, fontSize: 19, fontFamily: "Cairo")),
        onTap: tap);
  }
}

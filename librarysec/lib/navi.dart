import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:librarysec/main.dart';

class Navigat {
  final String title;
  final IconData iconData;

  const Navigat({required this.title, required this.iconData});
}

Widget PageBox(
    {String? title,
    IconData? lbottomicon,
    String? rbottom,
    required double height,
    required double width}) {
  return Container(
    decoration: BoxDecoration(border: Border.all(color: appColor)),
    height: height,
    width: width,
    child: Column(
      children: [
        Container(
          color: Color.fromARGB(255, 207, 124, 124),
          height: 0.18 * height,
          width: width,
          child: Text(title!, style: TextStyle(color: Colors.white)),
        ),
        SizedBox(
          height: 0.62 * height,
        ),
        Container(
          color: Color.fromARGB(255, 207, 124, 124),
          height: 0.18 * height,
          width: width,
          child: Text(title, style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}

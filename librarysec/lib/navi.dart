
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          color: Color.fromARGB(255, 207, 124, 124),
          height: 30,
          width: width,
          child: Align(alignment: Alignment.centerLeft, child: Text(title!, style: TextStyle(color: Colors.white)),),
        ),
        // Container(
        //   width: width ,
        //   height: height,
        // ),
        Container(
          color: Color.fromARGB(255, 207, 124, 124),
          // alignment: AlignmentDirectional.bottomCenter,
          height: 30,
          width: width,
          child: Align(alignment: Alignment.centerLeft, child: Text(title, style: TextStyle(color: Colors.white)),),
        ),
      ],
    ),
  );
}

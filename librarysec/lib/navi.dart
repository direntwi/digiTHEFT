import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:librarysec/main.dart';

class Navigat {
  final String title;
  final IconData iconData;

  const Navigat({required this.title, required this.iconData});
}

Widget PageBox(
    // to be worked on -- separated into different boxes
    {String? title,
    IconData? lbottomicon,
    IconData? rbottomicon,
      String? name,
      String? id,
      String? status,
    required double height,
    required double width,
    required bool check,
    Future Function()? rfx,
    Future Function()? lfx}) {
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
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("  ${title}", style: TextStyle(color: Colors.white)),
          ),
        ),
        Container(
          // to be worked on
            child: check
                ? Column(
                    children: [
                      Text(name!),
                      Text(id!),
                      Text(status!),
                    ],
                  )
                : Text("No ${title} available")),
        Container(
            color: Color.fromARGB(255, 207, 124, 124),
            // alignment: AlignmentDirectional.bottomCenter,
            height: 30,
            width: width,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.all(6),
                      child: GestureDetector(
                        // ignore: sort_child_properties_last
                        child: Icon(
                          lbottomicon,
                          color: Colors.white,
                          size: 20,
                        ),
                        onTap: lfx,
                      )),
                  Padding(
                    padding: EdgeInsets.all(6),
                    child: GestureDetector(
                      child: Icon(
                        rbottomicon,
                        color: Colors.white,
                        size: 20,
                      ),
                      onTap: rfx,
                    ),
                  ),
                ])),
      ],
    ),
  );
}

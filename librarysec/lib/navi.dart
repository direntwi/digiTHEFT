import 'package:fluent_ui/fluent_ui.dart';
import 'package:librarysec/main.dart';

class Navigat {
  final String title;
  final IconData iconData;

  const Navigat({required this.title, required this.iconData});
}

Widget pageBox(
    // to be worked on -- separated into different boxes
    {String? title,
    IconData? lbottomicon,
    IconData? rbottomicon,
    required Widget boxType,
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
          color: const Color.fromARGB(255, 207, 124, 124),
          height: 30,
          width: width,
          child: Align(
            alignment: Alignment.centerLeft,
            child:
                Text("  $title", style: const TextStyle(color: Colors.white)),
          ),
        ),
        Container(
            // to be worked on
            child: check ? boxType : Text("No $title available")),
        Container(
            color: const Color.fromARGB(255, 207, 124, 124),
            height: 30,
            width: width,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(6),
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
                    padding: const EdgeInsets.all(6),
                    child: GestureDetector(
                      onTap: rfx,
                      child: Icon(
                        rbottomicon,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ])),
      ],
    ),
  );
}

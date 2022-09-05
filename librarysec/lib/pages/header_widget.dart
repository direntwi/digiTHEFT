import 'package:fluent_ui/fluent_ui.dart';

import '../main.dart';

Widget headerWidget(String pageName) {
  return Center(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/knust_icon.png',
                height: 50, width: 50),
            Text(
              "KNUST LIBRARY PORTAL$pageName",
              style: TextStyle(color: appColor, fontSize: 25),
            ),
          ])
);
}
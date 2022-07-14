//import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:librarysec/main.dart';
import 'package:librarysec/pages/home.dart';
import 'package:librarysec/pages/items.dart';
import 'package:librarysec/pages/profile.dart';
import 'package:librarysec/pages/search.dart';
import 'package:librarysec/pages/settings.dart';
import 'package:window_manager/window_manager.dart';
import 'package:librarysec/navi.dart';

class Checkout extends StatefulWidget {
  const Checkout({
    Key? key,
  }) : super(key: key);

  @override
  State<Checkout> createState() => _Checkout();
}

class _Checkout extends State<Checkout> with WindowListener {
  final List<Navigat> pages = const [
    Navigat(title: 'Home', iconData: FluentIcons.home),
    Navigat(title: 'Patrons', iconData: FluentIcons.people),
    Navigat(title: 'Items', iconData: FluentIcons.history),
    Navigat(title: 'Search', iconData: FluentIcons.search),
    Navigat(title: 'Settings', iconData: FluentIcons.settings),
    Navigat(title: 'Log Out', iconData: FluentIcons.sign_out),
  ];

  int index = 0;
  final viewKey = GlobalKey();

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    if (_isPreventClose) {
      showDialog(
          context: context,
          builder: (_) {
            return ContentDialog(
                title: const Text('Confirm close'),
                content: const Text('Are you sure want to close the app?'),
                actions: [
                  FilledButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      Navigator.pop(context);
                      windowManager.destroy();
                    },
                  ),
                  FilledButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ]);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      key: viewKey,
      pane: NavigationPane(
          selected: index,
          onChanged: (i) => setState(() {
                index = i;
              }),
          displayMode: PaneDisplayMode.compact,
          items: pages
              .map<NavigationPaneItem>(((e) =>
                  PaneItem(icon: Icon(e.iconData), title: Text(e.title))))
              .toList()),
      content: NavigationBody(
        index: index,
        children: [
          HomePage(title: 'Home'),
          Items(),
          Profile(),
          Search(),
          Settings(),
          logout(),
        ],
      ),
      // content: NavigationBody.builder(
      //     index: index,
      //     itemBuilder: (ctx, index) {
      //       print(pages[index].title);
      //       return HomePage(title: pages[index].title);
      //     }),
    );
  }

  Widget logout() {
    return ContentDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure want to logout of the app?'),
        actions: [
          FilledButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FilledButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ]);
  }
}

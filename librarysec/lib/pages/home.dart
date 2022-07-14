import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/material.dart';
//import 'package:librarysec/main.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<HomePage> createState() => _HomePageState(txt: title);
}

class _HomePageState extends State<HomePage> {
  _HomePageState({required String txt});
  final autoSuggestBox = TextEditingController();

  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        padding: const EdgeInsets.all(20),
        content: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropDownButton(
                          //menuColor: Color.fromARGB(153, 64, 24, 100),
                          title: const Text('Check out'),
                          items: [
                            MenuFlyoutItem(
                                text: const Text('Check out'),
                                onPressed: () {}),
                            MenuFlyoutItem(
                                text: const Text('Return'),
                                onPressed: () {
                                  setState(() {});
                                })
                          ]),
                      Container(
                          height: 32,
                          width: 200,
                          child: const TextBox(
                            placeholder: 'Enter command or Barcode',
                          )),
                    ])
              ],
            )));
  }
}

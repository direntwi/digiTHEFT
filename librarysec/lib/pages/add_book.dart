import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:librarysec/main.dart';
import 'package:flutter/material.dart' as material;

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  String? bookname;
  String? bookid;
  String? bookauthor;
  String? category;
  DateTime dateToday =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Padding(
          padding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
          child: Row(
            children: [
              Column(
                children: [
                  const Center(
                      child: Text(
                    'Add New Book',
                    style: TextStyle(color: appColor, fontSize: 30),
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  Texty('BOOK NAME'),
                  const SizedBox(
                    height: 20,
                  ),
                  Texty('BOOK ID'),
                  const SizedBox(
                    height: 20,
                  ),
                  Texty('DATE OF ENTRY'),
                  const SizedBox(
                    height: 20,
                  ),
                  Texty('NAME OF AUTHOR'),
                  const SizedBox(
                    height: 20,
                  ),
                  Texty('BOOK CATEGORY'),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                          child: Text(
                            'ENTER',
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () {}),
                      // SizedBox(
                      //   width: 50,
                      // ),
                      TextButton(
                          child: Text(
                            'CLEAR',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {})
                    ],
                  )
                ],

                // Divider(
                //   size: 350,
                //   direction: Axis.vertical,
                // ),
                //
              ),
              Image(
                image: AssetImage('images/bookimages.png'),
              )
            ],
          )),
    );
  }
}

Widget Texty(String text) {
  return Container(
    child: Row(
      children: [
        Container(
            width: 200,
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
        SizedBox(
          width: 70,
        ),
        Container(
            width: 400,
            height: 35,
            child: TextBox(
              controller: null,
            ))
      ],
    ),
  );
}

import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:librarysec/main.dart';
import 'package:flutter/material.dart' as material;
import 'package:librarysec/classes.dart';
import 'package:librarysec/DBConnector.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  @override
  void initState() {
    super.initState();
    date = _selectedDate;
    e.text = DateFormat("yMMMMd").format(DateTime.now()).toString();
  }

  TextEditingController doe = TextEditingController();
  TextEditingController e = TextEditingController();
  String? bookname;
  String? bookid;
  String? bookauthor;
  String? category;
  DateTime? date;
  final DateTime _selectedDate = (DateTime.now());
  static const int timeout = 30;
  late Book book;

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
                  Texty(
                      text: 'BOOK NAME',
                      onChanged: (value) {
                        bookname = value;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Texty(
                      text: 'BOOK ID',
                      onChanged: (value) {
                        bookid = value;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Texty(
                    controller: e,
                    text: 'DATE OF ENTRY',
                    onChanged: (value) {
                      date = DateTime.parse(value);
                    },
                    suffix: IconButton(
                      icon: Icon(FluentIcons.edit),
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Texty(
                      text: 'NAME OF AUTHOR',
                      onChanged: (value) {
                        bookauthor = value;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Texty(
                      text: 'BOOK CATEGORY',
                      onChanged: (value) {
                        category = value;
                      }),
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
                          onPressed: () async {
                            book = Book(
                              //IGNORE FIXED VALUES
                              authorName: bookauthor!,
                              availability: 3,
                              barCodeId: bookid!,
                              bookId: bookid!,
                              bookTitle: bookname!,
                              borrowStatus: 3,
                              callNumber: 'NULL',
                              categoryId: 1234,
                              dateAdded: date!,
                              location: 'KUMASI',
                              publicationYear: '2000',
                              rfId: 'NULL',
                            );
                            try {
                              if (await add_book(book)
                                  .timeout(Duration(seconds: timeout)))
                                print('ADDED');
                            } on TimeoutException catch (e) {
                              print('[INFO] $e');
                            }
                          }),
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

  Widget Texty(
      {required String text,
      Function(String value)? onChanged,
      Widget? suffix,
      String? def,
      TextEditingController? controller}) {
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
                controller: controller,
                onChanged: onChanged,
                suffix: suffix,
                placeholder: def,
              ))
        ],
      ),
    );
  }

  Future<bool> add_book(book) async {
    var db = Backend_link();
    bool status = await db.add_book(book).timeout(Duration(seconds: timeout));
    return status;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await material.showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        date = picked;
        e.text = DateFormat("yMMMMd").format(date!).toString();
      }); //&& picked != _selectedDate
    }
  }
}

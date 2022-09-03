import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart' as material;
import 'package:librarysec/classes.dart';
import 'package:librarysec/DBConnector.dart';
import 'package:intl/intl.dart';
import 'package:librarysec/pages/header_widget.dart';
import 'package:serial_port_win32/serial_port_win32.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> with TickerProviderStateMixin {
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
    super.initState();
    date = _selectedDate;
    e.text = DateFormat("yMMMMd").format(DateTime.now()).toString();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late AnimationController controller;
  TextEditingController doe = TextEditingController();
  TextEditingController e = TextEditingController();
  TextEditingController bookid = TextEditingController();
  TextEditingController booknamecontroller = TextEditingController();
  TextEditingController bookauthorcontroller = TextEditingController();
  TextEditingController bookcategorycontroller = TextEditingController();
  String? bookname;
  String? rfid;
  String? bookauthor;
  String? category;
  DateTime? date;
  final DateTime _selectedDate = (DateTime.now());
  static const int timeout = 30;
  late Book book;
  String com = "COM12";
  String? value2 = null;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        header: headerWidget(" - Add New Book"),
        // content: Padding(
        //     padding:
        //     EdgeInsets.only(left: 40, right: 40, bottom: 20),
        //     child:
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Texty(
                    controller: booknamecontroller,
                    text: 'BOOK NAME',
                    onChanged: (value) {
                      bookname = value;
                    }),
                const SizedBox(
                  height: 20,
                ),
                Texty(
                    controller: bookid,
                    text: 'BOOK ID',
                    // onChanged: (value) {
                    //   rfid = value;
                    //   print('THIS IS VALUUEEE $rfid');
                    // },
                    suffix: IconButton(
                        onPressed: () {
                          _scanBook();
                        },
                        icon: const Icon(
                          FluentIcons.generic_scan,
                          semanticLabel: "Scan Book with rfid",
                        ))),
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
                    controller: bookauthorcontroller,
                    text: 'NAME OF AUTHOR',
                    onChanged: (value) {
                      bookauthor = value;
                    }),
                const SizedBox(
                  height: 20,
                ),
                Texty(
                    controller: bookcategorycontroller,
                    text: 'BOOK CATEGORY',
                    onChanged: (value) {
                      category = value;
                    }),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    FilledButton(
                        child: Text(
                          'ENTER',
                          style: TextStyle(),
                        ),
                        onPressed: () async {
                          book = Book(
                            //IGNORE FIXED VALUES
                            authorName: bookauthor!,
                            availability: 1,
                            bookTitle: bookname!,
                            isBorrowed: 0,
                            callNumber: 'NULL',
                            categoryId: 1234,
                            dateAdded: date!,
                            location: 'KUMASI',
                            publicationYear: '2000',
                            rfId: bookid.text,
                          );
                          if (await add_book(book)) {
                            return material.showDialog(
                                context: context,
                                builder: (context) {
                                  return ContentDialog(
                                    title: Text('Book Added Successfully'),
                                    actions: [
                                      Button(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop(true);
                                          }),
                                      Button(
                                          child: const Text('Okay'),
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop(true);
                                          })
                                    ],
                                  );
                                });
                          } else {
                            return material.showDialog(
                                context: context,
                                builder: (context) {
                                  return const ContentDialog(
                                    title: Text(
                                      'Unable to add new Book',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  );
                                });
                          }
                        }),
                    SizedBox(
                      width: 30,
                    ),
                    TextButton(
                        child: Text(
                          'CLEAR',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          bookid.text = '';
                          booknamecontroller.text = '';
                          bookauthorcontroller.text = '';
                          bookcategorycontroller.text = '';
                        })
                  ],
                )
              ],

              // Divider(
              //   size: 350,
              //   direction: Axis.vertical,
              // ),
              //
            ),
            // Image(
            //   image: AssetImage('images/bookimages.png'),
            // )
          ],
        )
        // ),
        );
  }

  Widget Texty({
    required String text,
    Function(String value)? onChanged,
    Widget? suffix,
    String? def,
    TextEditingController? controller,
  }) {
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

  Future _scanBook() async {
    var dia = material.showDialog(
        context: context,
        builder: (context) {
          return ContentDialog(
            title: const Text('Scanning Book With Reader'),
            content: TextBox(
              controller: bookid,
            ),
            // content: TextBox(
            //   controller: bookid,
            // ),
            actions: [
              Button(
                  child: const Text('Done'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              Button(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                    bookid.text = '';
                  })
            ],
          );
        });
    Future<String>? rfid = scanrfid();
    String? rfidtag = await rfid;
    bookid.text = rfidtag!;
    return dia;
  }

  Future<String>? scanrfid() async {
    var ports = SerialPort.getAvailablePorts();
    print(ports);

    var converted = [];

    if (ports.contains(com)) {
      final port = SerialPort(com, openNow: false, BaudRate: 9600);
      port.open();
      print("$com port isOpened?: ${port.isOpened}");

      port.readBytesOnListen(32, (value) {
        for (final e in value) {
          var currentElement = e;
          converted
              .add(String.fromCharCode(int.parse(currentElement.toString())));
          print(converted.join());
        }
      });
      // String buffer = condition;
      port.writeBytesFromString('False');
      return Future<String>.delayed(const Duration(seconds: 5), () async {
        port.close();
        return converted.join();
      });
      // port.close();

    } else {
      print("Unable to find required COM port");
      return ('');
    }
  }
}

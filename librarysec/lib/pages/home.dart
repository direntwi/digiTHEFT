import 'dart:convert';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:librarysec/navi.dart';
import 'package:http/http.dart' as http;
import 'package:librarysec/backend_link.dart' as link;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' as material;
import 'package:librarysec/pages/header_widget.dart';
import 'package:serial_port_win32/serial_port_win32.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();

  final autoSuggestBox = TextEditingController();
  final _refNumberController = TextEditingController();
  final _bookIdController = TextEditingController();
  String com = "COM3";
  String patronName = '';
  late String rfID;
  String referenceNumber = '';
  String patronStatus = 'Enter patron reference number to begin process';
  String programme = '';
  bool bookgotten = false;
  String oneAuthorName = 'Default';
  String oneBookTitle = 'Default';
  String oneRFID = 'Default';
  String transpatron = '';
  String transborrow = '';
  String transreturn = '';
  List<String> trans = [];

  late Future<List<dynamic>> futureAlbums;
  late List transactionAlbums = [];
  late Future<dynamic> futureAlbumScan;
  String isBorrowed = '';
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool hasdata = false;
    return ScaffoldPage(
        header: headerWidget(""),
        content: Padding(
            padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.3,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 40.0,
                    mainAxisSpacing: 40.0,
                    childAspectRatio: (6.5 / 3),
                    children: [
                      pageBox(
                          height: 150,
                          width: 1400,
                          title: 'Patrons',
                          check: !hasdata,
                          boxType: patronBoxData(),
                          rbottomicon: FluentIcons.search,
                          rfx: studenttypeId),
                      pageBox(
                          height: 150,
                          width: 1400,
                          title: 'Books',
                          check: !hasdata,
                          boxType: bookBoxData(),
                          lbottomicon: FluentIcons.generic_scan,
                          rbottomicon: FluentIcons.add,
                          rfx: itemtypeId,
                          lfx: preScanDialog),
                    ],
                  ),
                ),
                pageBox(
                    height: MediaQuery.of(context).size.height / 3,
                    width: 1400,
                    boxType: transLogBoxData(),
                    title: 'Transaction Log',
                    check: !hasdata,
                    lbottomicon: FluentIcons.cancel),
              ],
            )));
  }

  Future studenttypeId() {
    return showDialog(
        context: context,
        builder: (context) {
          return ContentDialog(
            title: const Text('Manual input'),
            content: TextBox(
              controller: _refNumberController,
              placeholder: "Enter reference number",
            ),
            backgroundDismiss: true,
            actions: [
              Button(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(true);
                  }),
              Button(
                  child: const Text('Search'),
                  // FUNCTION - to handle the input of patron reference number
                  onPressed: () async {
                    final response = await http.get(Uri.parse(
                        "${link.server}/get-refid/${_refNumberController.text}"));

                    final decoded =
                        json.decode(response.body) as Map<String, dynamic>;
                    // ignore: use_build_context_synchronously
                    Navigator.of(context, rootNavigator: true).pop(true);
                    if (response.statusCode == 200) {
                      print("running it");
                      setState(() {
                        patronName = decoded['patronName'];
                        referenceNumber = decoded["referenceID"];
                        patronStatus = decoded["patronStatus"];
                        programme = decoded["programme"];
                        transpatron = 'Patron';
                      });
                    } else {
                      print("No response");
                    }
                    if (transpatron == 'Patron') {
                      trans.add('$patronName found');
                    } else {
                      trans.add('Patron Not Found');
                    }
                  })
            ],
          );
        });
  }

  Future itemtypeId() {
    return showDialog(
        context: context,
        builder: (context) {
          return ContentDialog(
            title: const Text('Manual Input'),
            content: TextBox(
                controller: _bookIdController, placeholder: "Enter book ID"),
            backgroundDismiss: true,
            actions: [
              Button(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(true);
                  }),
              Button(
                  child: const Text('Add'),
                  onPressed: () {
                    _borrowBook(_bookIdController.text);

                    Navigator.of(context, rootNavigator: true).pop(true);
                  })
            ],
          );
        });
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
      String buffer = isBorrowed;
      print(isBorrowed);
      port.writeBytesFromString(buffer);
      return Future<String>.delayed(const Duration(seconds: 5), () async {
        port.close();
        return converted.join();
      });
    } else {
      print("Unable to find required COM port");
      return ('Unable to checkout');
    }
  }

  Future preScanDialog() {
    var dialog = material.showDialog(
        context: context,
        builder: (context) {
          return ContentDialog(
            backgroundDismiss: true,
            title: const Text('Connect the RFID Reader'),
            actions: [
              Button(
                  child: const Text('Return a Book'),
                  onPressed: () {
                    setState(() {
                      isBorrowed = 'False';
                    });
                    Navigator.pop(context);
                    scanId();
                  }),
              Button(
                  child: const Text('Borrow a Book'),
                  onPressed: () {
                    setState(() {
                      isBorrowed = 'True';
                    });
                    Navigator.pop(context);
                    scanId();
                  })
            ],
          );
        });
    return dialog;
  }

  Future scanId() async {
    var dia = material.showDialog(
        context: context,
        builder: (context) {
          return ContentDialog(
            title: const Text('Scan Book With Reader'),
            content: Text("Disconnect RFID reader after scanning"),
            actions: [
              Button(
                  child: const Text('Done'),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
    Future<String>? rfid = scanrfid();
    String? rfidtag = await rfid;
    print('THIS IS RFID $rfidtag');
    fetchAlbumScan(rfidtag);
    if (isBorrowed == 'True') {
      _borrowBook(rfidtag!);
    } else {
      _returnBook(rfidtag!);
    }
    return dia;
  }

  Column patronBoxData() {
    return Column(
      children: <Widget>[
        Text(patronName),
        Text(referenceNumber),
        Text(patronStatus),
        Text(programme)
      ],
    );
  }

  Expanded bookBoxData() {
    futureAlbums = fetchAlbums();
    return Expanded(
      child: Scrollbar(
          controller: ScrollController(),
          child: FutureBuilder<List<dynamic>>(
              future: futureAlbums,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      controller: ScrollController(),

                      /// You can add a padding to the view to avoid having the scrollbar over the UI elements
                      itemCount: snapshot.data!.toList().length,
                      itemBuilder: (BuildContext ctx, int position) {
                        return ListTile(
                          title: Text(
                              "${snapshot.data!.toList()[position].bookTitle}"),
                          subtitle:
                              Text("${snapshot.data!.toList()[position].rfID}"),
                          trailing: IconButton(
                            icon: const Icon(FluentIcons.remove),
                            onPressed: () {
                              material.showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ContentDialog(
                                      content: const Text('Return Book?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              _returnBook(
                                                  "${snapshot.data!.toList()[position].rfID}");
                                              Navigator.pop(context);
                                            },
                                            child: const Text('YES')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('CANCEL'))
                                      ],
                                    );
                                  });
                            },
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return const Center(child: Text("No books to display"));
                }
                return const ProgressRing();
              })),
    );
  }

  Expanded transLogBoxData() {
    return Expanded(
        child: Scrollbar(
      controller: ScrollController(),
      child: trans.isNotEmpty
          ? ListView.builder(
              itemCount: trans.length,
              itemBuilder: (BuildContext ctx, int position) {
                return ListTile(title: Text(trans[position]));
              },
            )
          : const Center(child: Text('No Transaction Data')),
    ));
  }

  Future<List<dynamic>> fetchAlbums() async {
    final response = await http
        .get(Uri.parse("${link.server}/patron-account/$referenceNumber"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      dynamic data = jsonDecode(response.body);
      print(data);
      return data.map((element) => Album.fromJson(element)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('No patron data found');
    }
  }

  Future fetchAlbumScan(String? rfid) async {
    final response =
        await http.get(Uri.parse("${link.server}/get-book-by-rfid/$rfid"));

    final decoded = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      print("scannded");
      setState(() {
        oneAuthorName = decoded['authorName'];
        oneBookTitle = decoded['bookTitle'];
        oneRFID = decoded['rfID'];
      });
    } else {
      print("No response");
    }
  }

  Future<void> _borrowBook(String bookrfid) async {
    dynamic data = {"referenceID": referenceNumber, "rfID": bookrfid};
    var res = await http.get(Uri.parse(
      "${link.server}/isBorrowed/$bookrfid",
    ));
    print('This is response ${res.body}');
    if (res.body == "False") {
      var response = await dio.post("${link.server}/borrow-book",
          data: data, options: Options());
      var response1 = await dio.put("${link.server}/borrow-book",
          data: data, options: Options());

      /// taken from instashop project to reproduce dio.post
      if (response.statusCode == 200) {
        setState(() {
          futureAlbums = fetchAlbums();
          transborrow = 'Borrow';
        });
        if (transborrow == 'Borrow') {
          trans.add('Book found and eligible for borrowing');
        }
      } else {
        trans.add('Book Not Found');
      }
    } else {
      trans.add('Book Not Available for Borrowing');
      return material.showDialog(
          context: context,
          builder: (context) {
            return ContentDialog(
              content: const Text("Book Not Available for Borrowing"),
              actions: [
                material.TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OKAY'))
              ],
            );
          });
    }
  }

  Future<void> _returnBook(rfid) async {
    //get transactionID
    print(rfid);
    var response1 = await http.get(Uri.parse(
      "${link.server}/patron-account/$referenceNumber",
    ));
    final decoded = json.decode(response1.body);
    var transID = decoded[0]['transactionID'];
    //return book
    dynamic data = {"rfID": rfid};
    var response2 = await dio.put("${link.server}/return-book",
        data: data, options: Options());
    if (response2.statusCode == 200) {
      setState(() {
        futureAlbums = fetchAlbums();
        transreturn = 'Return';
      });
      if (transreturn == 'Return') {
        trans.add('Book successfully returned');
      } else {
        trans.add('Unable to return Book ...Try Again');
      }
    }
  }
}

class Album {
  Album(
      {required this.bookTitle,
      required this.dueDate,
      required this.patronName,
      required this.referenceId,
      required this.rfID});

  final String bookTitle;
  final dynamic dueDate;
  final String patronName;
  final String referenceId;
  final String rfID;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
      bookTitle: json["bookTitle"],
      dueDate: json["dueDate"],
      patronName: json["patronName"],
      referenceId: json["referenceID"],
      rfID: json["rfID"]);

  Map<String, dynamic> toJson() => {
        "bookTitle": bookTitle,
        "dueDate": dueDate,
        "patronName": patronName,
        "referenceID": referenceId,
        "rfID": rfID
      };
}

class ScannedBook {
  ScannedBook({
    required this.authorName,
    required this.bookTitle,
    required this.rfId,
  });

  String authorName;
  String bookTitle;
  String rfId;

  factory ScannedBook.fromJson(Map<String, dynamic> json) => ScannedBook(
        authorName: json["authorName"],
        bookTitle: json["bookTitle"],
        rfId: json["rfID"],
      );

  Map<String, dynamic> toJson() => {
        "authorName": authorName,
        "bookTitle": bookTitle,
        "rfID": rfId,
      };
}

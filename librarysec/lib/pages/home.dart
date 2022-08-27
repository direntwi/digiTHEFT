import 'dart:convert';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:librarysec/navi.dart';
import 'package:http/http.dart' as http;
import 'package:librarysec/backend_link.dart' as link;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' as material;
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
  String patronName = 'Enter patron reference number to begin process';
  late String rfID;
  late String referenceNumber = '';
  String patronStatus = '';
  String programme = '';
  bool bookgotten = false;
  late String oneAuthorName = 'Default';
  late String oneBookTitle = 'Default';
  late String oneRFID = 'Default';

  late Future<List<dynamic>> futureAlbums;
  late Future<dynamic> futureAlbumScan;

  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
  }

  // NEW PUSH

  // var items = [
  //   'Item 1',
  //   'Item 2',
  //   'Item 3',
  //   'Item 4',
  //   'Item 5',
  // ];

  @override
  Widget build(BuildContext context) {
    bool hasdata = false;
    return ScaffoldPage(
        // padding: const EdgeInsets.all(20),
        content: Padding(
            padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                      const SizedBox(
                          height: 32,
                          width: 200,
                          child: TextBox(
                            placeholder: 'Enter command or barcode',
                          )),
                    ]),
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
                      PageBox(
                          height: 150,
                          width: 1400,
                          title: 'Patrons',
                          check: !hasdata,
                          boxType: patronBoxData(),
                          lbottomicon: FluentIcons.generic_scan,
                          rbottomicon: FluentIcons.search,
                          rfx: studenttypeId),
                      PageBox(
                          height: 150,
                          width: 1400,
                          title: 'Books',
                          check: !hasdata,
                          boxType: bookBoxData(),
                          lbottomicon: FluentIcons.generic_scan,
                          rbottomicon: FluentIcons.add,
                          rfx: itemtypeId,
                          lfx: scanId),
                    ],
                  ),
                ),
                PageBox(
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

                    if (response.statusCode == 200) {
                      print("running it");
                      setState(() {
                        patronName = decoded['patronName'];
                        referenceNumber = decoded["referenceID"];
                        patronStatus = decoded["patronStatus"];
                        programme = decoded["programme"];
                      });
                    } else {
                      print("No response");
                    }
                    // to be worked on
                    Navigator.of(context).pop();
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

      String buffer = "True";
      port.writeBytesFromString(buffer);
      return Future<String>.delayed(
          const Duration(seconds: 3), () async => converted.join());
      // port.close();

    } else {
      print("Unable to find required COM port");
      return ('Unable to checkout');
    }
  }

  Future scanId() async {
    // Future<String>? rfid = scanrfid();
    // String? rfidtag = await rfid;
    // print('THIS IS RFID $rfidtag');
    // print('surely working');
    // _getbookinfo(rfidtag);
    // futureAlbumScan = fetchAlbumScan("2437539148");

    var dia = showDialog(
        context: context,
        builder: (context) {
                  return ContentDialog(
                    title: Text('Scan Book With Reader'),
                    // content: Column(
                      // children: [
                      //   Text(oneBookTitle),
                      //   Text(oneAuthorName),
                      //   Text(oneRFID)
                      // ],
                    // ),
                    actions: [
                      Button(
                          child: Text('Okay'),
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
    _borrowBook(rfidtag!);
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
                      //padding: EdgeInsets.only(right: 16.0),
                      itemCount: snapshot.data!.toList().length,
                      itemBuilder: (BuildContext ctx, int position) {
                        return ListTile(
                          title: Text(
                              "${snapshot.data!.toList()[position].bookTitle}"),
                          subtitle: Text(
                              "${snapshot.data!.toList()[position].dueDate}"),
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
                                                  _bookIdController.text);
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
                  return const Text("No books found in patron's account");
                  // return Text('${snapshot.error}');
                }
                return const ProgressRing();
              })),
    );
  }

  Widget transLogBoxData() {
    return const Text("No transaction log data available");
  }

  Future<List<dynamic>> fetchAlbums() async {
    final response = await http
        .get(Uri.parse("${link.server}/patron-account/$referenceNumber"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      dynamic data = jsonDecode(response.body);
      return data.map((element) => Album.fromJson(element)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('No patron data found');
    }
  }

  // Future<List<dynamic>> _getbookinfo(String? rfid) async {
  //   final response =
  //       await http.get(Uri.parse("${link.server}/get-book-by-rfid/$rfid"));
  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     dynamic data = jsonDecode(response.body);
  //     setState(() {
  //       print('poollop');
  //       bookgotten = true;
  //     });
  //     return data.map((element) => Album.fromJson(element)).toList();
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     setState(() {});
  //     throw Exception('No book data found');
  //   }
  // }

  Future fetchAlbumScan(String? rfid) async {
    final response = await http.get(Uri.parse("${link.server}/get-book-by-rfid/$rfid"));

    final decoded =
    json.decode(response.body) as Map<String, dynamic>;

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




    // final response =
    //     await http.get(Uri.parse("${link.server}/get-book-by-rfid/$rfid"));
    // if (response.statusCode == 200) {
    //   // If the server did return a 200 OK response,
    //   // then parse the JSON.
    //   dynamic data = jsonDecode(response.body);
    //   setState(() {
    //     print('poollop');
    //     bookgotten = true;
    //   });
    //   return data.map((element) => ScannedBook.fromJson(element)).toList();
    // } else {
    //   // If the server did not return a 200 OK response,
    //   // then throw an exception.
    //   setState(() {});
    //   throw Exception('No book data found');
    // }
  }

  Future<void> _borrowBook(String bookrfid) async {
    dynamic data = {"referenceID": referenceNumber, "rfID": bookrfid};

    var response = await dio.post("${link.server}/borrow-book",
        data: data, options: Options());

    /// taken from instashop project to reproduce dio.post
    if (response.statusCode == 200) {
      setState(() {
        futureAlbums = fetchAlbums();
      });
      print('yeahhhh');
    } else {
      print('noooooooooooo');
    }
    //   final addedToWishlist = SnackBar(
    //     content: new Text("Item added to wishlist!"),
    //     action: SnackBarAction(
    //       label: "View",
    //       onPressed: () {
    //         var router = new MaterialPageRoute(
    //             builder: (BuildContext context) => new WishlistPage());
    //         Navigator.of(context).push(router);
    //
    //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //       },
    //     ),
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(addedToWishlist);
    // } else {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text("Unable to add to wishlist")));
    // }
  }

  Future<void> _returnBook(bookID) async {
    //get transactionID
    var response1 = await http.get(Uri.parse(
      "${link.server}/patron-account/$referenceNumber",
    ));
    final decoded = json.decode(response1.body); //as Map<String, dynamic>;
    var transID = decoded[0]['transactionID'];
    //return book
    dynamic data = {"transactionID": transID, "bookID": bookID};
    var response2 = await dio.put("${link.server}/return-book",
        data: data, options: Options());
    if (response2.statusCode == 200) {
      print('done');
      setState(() {
        futureAlbums = fetchAlbums();
      });
    }
  }
}

class Album {
  Album({
    required this.bookTitle,
    required this.dueDate,
    required this.patronName,
    required this.referenceId,
    required this.transactionId,
  });

  final String bookTitle;
  final dynamic dueDate;
  final String patronName;
  final String referenceId;
  final String transactionId;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        bookTitle: json["bookTitle"],
        dueDate: json["dueDate"],
        patronName: json["patronName"],
        referenceId: json["referenceID"],
        transactionId: json["transactionID"],
      );

  Map<String, dynamic> toJson() => {
        "bookTitle": bookTitle,
        "dueDate": dueDate,
        "patronName": patronName,
        "referenceID": referenceId,
        "transactionID": transactionId,
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

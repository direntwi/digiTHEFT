import 'dart:convert';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:librarysec/navi.dart';
import 'package:http/http.dart' as http;
import 'package:librarysec/backend_link.dart' as link;
import 'package:dio/dio.dart';

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
  var _refNumberController = TextEditingController();
  var _bookIdController = TextEditingController();

  String patronName = '';
  late String referenceNumber = '';
  String patronStatus = '';
  String programme = '';

  late Future<List<dynamic>> futureAlbums;
  Dio dio = new Dio();

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
                Container(
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
                      ),
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
            title: Text('Manual input'),
            content: TextBox(
              controller: _refNumberController,
              placeholder: "Enter reference number",
            ),
            backgroundDismiss: true,
            actions: [
              Button(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(true);
                  }),
              Button(
                  child: Text('Search'),

                  // FUNCTION - to handle the input of patron reference number
                  onPressed: () async {
                    final response = await http.get(Uri.parse(
                        "${link.server}/get-refid/${_refNumberController.text}"));

                    final decoded =
                        json.decode(response.body) as Map<String, dynamic>;

                    setState(() {
                      patronName = decoded['patronName'];
                      referenceNumber = decoded["referenceID"];
                      patronStatus = decoded["patronStatus"];
                      programme = decoded["programme"];
                    });

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
            title: Text('Manual Input'),
            content: TextBox(
              controller: _bookIdController,
                placeholder: "Enter book ID"),
            backgroundDismiss: true,
            actions: [
              Button(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(true);
                  }),
              Button(
                  child: Text('Search'),
                  onPressed: () {
                    _borrowBook(_bookIdController.text);

                    Navigator.of(context, rootNavigator: true).pop(true);
                  })
            ],
          );
        });
  }

  Future scanId() {
    return showDialog(
        context: context,
        builder: (context) {
          return const ContentDialog(
            title: Text('Patron id'),
            content: TextBox(),
            backgroundDismiss: false,
          );
        });
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
    var futureAlbums = fetchAlbums();
    return Expanded(
      child: Container(
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
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const ProgressRing();
                  }))),
    );
  }

  Widget transLogBoxData() {
    return Container(child: Text("No transaction log data available"));
  }

  Future<List<dynamic>> fetchAlbums() async {
    final response = await http
        .get(Uri.parse("${link.server}/patron-account/${referenceNumber}"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      dynamic data = jsonDecode(response.body);
      return data.map((element) => Album.fromJson(element)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<void> _borrowBook(String bookID) async {
    dynamic data = {"referenceID": referenceNumber, "bookID": bookID};

    var response = await dio.post("${link.server}/borrow-book",
        data: data, options: Options());

    /// taken from instashop project to reproduce dio.post
    if (response.statusCode == 200) {
      print(referenceNumber);
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

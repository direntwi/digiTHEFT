import 'dart:convert';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:librarysec/navi.dart';
import 'package:http/http.dart' as http;
import 'package:librarysec/backend_link.dart' as link;

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

  String patronName = '';
  String referenceNumber = '';
  String patronStatus = '';

  late Future<List<dynamic>> futureAlbums;

  @override
  void initState() {
    super.initState();
  }
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
                          rbottomicon: FluentIcons.pencil_reply,
                          rfx: studenttypeId),
                      PageBox(
                        height: 150,
                        width: 1400,
                        title: 'Books',
                        check: !hasdata,
                        boxType: bookBoxData(),
                        lbottomicon: FluentIcons.generic_scan,
                        rbottomicon: FluentIcons.pencil_reply,
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
              placeholder: "Enter reference number",),
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

                    final response = await http.get(Uri.parse("${link.server}/get-refid/${_refNumberController.text}"));

                    final decoded = json.decode(response.body) as Map<String, dynamic>;

                    setState(() {
                      patronName = decoded['memberName'];
                      referenceNumber = decoded["referenceID"];
                      patronStatus = decoded["memberStatus"];
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
            content: TextBox(placeholder: "Enter book ID"),
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
      ],
    );
  }

  Expanded bookBoxData() {
    var futureAlbums = fetchAlbums();
    return Expanded(
      child: Container(
             child:  Scrollbar(
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
                        return ListTile(title: Text("${snapshot.data!.toList()[position].bookTitle} - ${snapshot.data!.toList()[position].authorName}"),
                        subtitle: Text("${snapshot.data!.toList()[position].dateAdded}"),);
                      });
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const ProgressRing();
              }
    )

          )),
    );
  }

  Widget transLogBoxData() {
    return Container(
            child: Text("No transaction log data available"));
  }

}

Future<List<dynamic>> fetchAlbums() async {

  final response =
  await http.get(Uri.parse("${link.server}/books"));

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

class Album {
  Album({
    required this.authorName,
    required this.availability,
    required this.barCodeId,
    required this.bookId,
    required this.bookTitle,
    required this.borrowStatus,
    required this.callNumber,
    required this.categoryId,
    required this.dateAdded,
    required this.location,
    required this.publicationYear,
    required this.rfId,
  });

  final String authorName;
  final int availability;
  final String barCodeId;
  final String bookId;
  final String bookTitle;
  final int borrowStatus;
  final String callNumber;
  final int categoryId;
  final DateTime dateAdded;
  final String location;
  final String publicationYear;
  final String rfId;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    authorName: json["authorName"],
    availability: json["availability"],
    barCodeId: json["barCodeID"],
    bookId: json["bookID"],
    bookTitle: json["bookTitle"],
    borrowStatus: json["borrowStatus"],
    callNumber: json["callNumber"],
    categoryId: json["categoryID"],
    dateAdded: DateTime.parse(json["dateAdded"]),
    location: json["location"],
    publicationYear: json["publicationYear"],
    rfId: json["rfID"],
  );

  Map<String, dynamic> toJson() => {
    "authorName": authorName,
    "availability": availability,
    "barCodeID": barCodeId,
    "bookID": bookId,
    "bookTitle": bookTitle,
    "borrowStatus": borrowStatus,
    "callNumber": callNumber,
    "categoryID": categoryId,
    "dateAdded": "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
    "location": location,
    "publicationYear": publicationYear,
    "rfID": rfId,
  };
}


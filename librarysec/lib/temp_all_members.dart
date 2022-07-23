// temporary file used to help me understand

import 'dart:convert';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:http/http.dart' as http;
import 'package:librarysec/backend_link.dart' as link;

class TempAllMembersPage extends StatefulWidget {
  const TempAllMembersPage({Key? key}) : super(key: key);

  @override
  _TempAllMembersPageState createState() => _TempAllMembersPageState();
}

class _TempAllMembersPageState extends State<TempAllMembersPage> {
  late Future<List<dynamic>> futureAlbums;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var futureAlbums = fetchAlbums();
    return ScaffoldPage(
      content: FutureBuilder<List<dynamic>>(
        future: futureAlbums,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    childAspectRatio: 2 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20),
                itemCount: snapshot.data!.toList().length,
                padding: EdgeInsets.all(15),
                itemBuilder: (BuildContext ctx, int position) {
                  return Container(
                    alignment: Alignment.center,
                    child: Stack(
                      children: <Widget>[
                        new Column(
                          children: [
                            new Container(
                              child: Text(
                                '${snapshot.data!.toList()[position].authorName}',
                              ),
                            ),
                            new Container(
                              child: new Text(
                                '${snapshot.data!.toList()[position].bookTitle}',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(15),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const ProgressRing();
        },
      )
      ,
    );
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

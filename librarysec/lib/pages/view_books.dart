import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:librarysec/backend_link.dart' as link;
import 'package:flutter/material.dart' as material;
import 'dart:convert';

import 'package:librarysec/pages/header_widget.dart';

class Items extends StatefulWidget {
  const Items({Key? key}) : super(key: key);

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  late Future<List> futurebooks;

  @override
  Widget build(BuildContext context) {
    futurebooks = fetchBooks();
    return ScaffoldPage(
      header: headerWidget(" - All Books"),
      content: Padding(
        padding: EdgeInsets.all(10),
        child: Scrollbar(
            controller: ScrollController(),
            child: FutureBuilder<List<dynamic>>(
                future: futurebooks,
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
                                "${snapshot.data!.toList()[position].bookTitle} - ${snapshot.data!.toList()[position].authorName}"),
                            subtitle: Text(
                                "RFID: ${snapshot.data!.toList()[position].rfId}"),
                            // trailing: IconButton(
                            //   icon: const Icon(FluentIcons.remove),
                            //   onPressed: () {
                            //     material.showDialog(
                            //         context: context,
                            //         builder: (context) {
                            //           return ContentDialog(
                            //             content: const Text('Return Book?'),
                            //             actions: [
                            //               TextButton(
                            //                   onPressed: () {},
                            //                   child: const Text('YES')),
                            //               TextButton(
                            //                   onPressed: () {
                            //                     Navigator.pop(context);
                            //                   },
                            //                   child: const Text('CANCEL'))
                            //             ],
                            //           );
                            //         });
                            //   },
                            // ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("No books to display"));
                    // return Text('${snapshot.error}');
                  }
                  return const ProgressRing();
                })),
      ),
    );
  }

  Future<List<dynamic>> fetchBooks() async {
    final response = await http.get(Uri.parse("${link.server}/books"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      dynamic data = jsonDecode(response.body);
      return data.map((element) => AllBook.fromJson(element)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('No patron data found');
    }
  }
}

class AllBook {
  AllBook({
    required this.authorName,
    required this.availability,
    required this.bookTitle,
    required this.callNumber,
    required this.categoryId,
    required this.dateAdded,
    required this.id,
    required this.isBorrowed,
    required this.location,
    required this.publicationYear,
    required this.rfId,
  });

  String authorName;
  int availability;
  String bookTitle;
  String callNumber;
  int categoryId;
  DateTime dateAdded;
  String id;
  int isBorrowed;
  String location;
  String publicationYear;
  String rfId;

  factory AllBook.fromJson(Map<String, dynamic> json) => AllBook(
        authorName: json["authorName"],
        availability: json["availability"],
        bookTitle: json["bookTitle"],
        callNumber: json["callNumber"],
        categoryId: json["categoryID"],
        dateAdded: DateTime.parse(json["dateAdded"]),
        id: json["id"],
        isBorrowed: json["isBorrowed"],
        location: json["location"],
        publicationYear: json["publicationYear"],
        rfId: json["rfID"],
      );

  Map<String, dynamic> toJson() => {
        "authorName": authorName,
        "availability": availability,
        "bookTitle": bookTitle,
        "callNumber": callNumber,
        "categoryID": categoryId,
        "dateAdded":
            "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
        "id": id,
        "isBorrowed": isBorrowed,
        "location": location,
        "publicationYear": publicationYear,
        "rfID": rfId,
      };
}

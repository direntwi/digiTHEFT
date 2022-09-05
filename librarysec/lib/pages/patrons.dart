import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:librarysec/backend_link.dart' as link;
import 'package:flutter/material.dart' as material;
import 'package:librarysec/pages/header_widget.dart';
import 'dart:convert';

class Patrons extends StatefulWidget {
  const Patrons({Key? key}) : super(key: key);

  @override
  State<Patrons> createState() => _PatronsState();
}

class _PatronsState extends State<Patrons> {
  late Future<List> futurepatrons;

  @override
  Widget build(BuildContext context) {
    futurepatrons = fetchPatrons();
    return ScaffoldPage(
      header: headerWidget(" - Patrons"),
      content: Padding(
        padding: EdgeInsets.all(10),
        child: Scrollbar(
            controller: ScrollController(),
            child: FutureBuilder<List<dynamic>>(
                future: futurepatrons,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        controller: ScrollController(),

                        /// You can add a padding to the view to avoid having the scrollbar over the UI elements
                        itemCount: snapshot.data!.toList().length,
                        itemBuilder: (BuildContext ctx, int position) {
                          return ListTile(
                            title: Text(
                                "${snapshot.data!.toList()[position].patronName} - ${snapshot.data!.toList()[position].patronStatus}"),
                            subtitle: Text(
                                "${snapshot.data!.toList()[position].referenceId}"),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("No books to display"));
                  }
                  return const ProgressRing();
                })),
      ),
    );
  }

  Future<List<dynamic>> fetchPatrons() async {
    final response = await http.get(Uri.parse("${link.server}/patrons"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      dynamic data = jsonDecode(response.body);
      return data.map((element) => AllPatron.fromJson(element)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('No patron data found');
    }
  }
}

class AllPatron {
  AllPatron({
    required this.id,
    required this.nationality,
    required this.patronName,
    required this.patronStatus,
    required this.programme,
    required this.referenceId,
  });

  String id;
  String nationality;
  String patronName;
  String patronStatus;
  String programme;
  String referenceId;

  factory AllPatron.fromJson(Map<String, dynamic> json) => AllPatron(
        id: json["id"],
        nationality: json["nationality"],
        patronName: json["patronName"],
        patronStatus: json["patronStatus"],
        programme: json["programme"],
        referenceId: json["referenceID"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nationality": nationality,
        "patronName": patronName,
        "patronStatus": patronStatus,
        "programme": programme,
        "referenceID": referenceId,
      };
}

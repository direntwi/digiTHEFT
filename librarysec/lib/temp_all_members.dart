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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            new Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${snapshot.data!.toList()[position].memberName}',
                                style: new TextStyle(
                                    fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            new Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: new Text(
                                '${snapshot.data!.toList()[position].referenceId}',
                                style: new TextStyle(
                                    fontSize: 20),
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
  await http.get(Uri.parse("${link.server}/members"));

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
    required this.memberId,
    required this.memberName,
    required this.memberStatus,
    required this.referenceId,
  });

  final String memberId;
  final String memberName;
  final String memberStatus;
  final String referenceId;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    memberId: json["memberID"],
    memberName: json["memberName"],
    memberStatus: json["memberStatus"],
    referenceId: json["referenceID"],
  );

  Map<String, dynamic> toJson() => {
    "memberID": memberId,
    "memberName": memberName,
    "memberStatus": memberStatus,
    "referenceID": referenceId,
  };
}

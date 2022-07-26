import 'classes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'backend_link.dart' as link;

class Backend_link {
  int timeout = 30;

  Future add_book(Book book) async {
    var body = json.encode(book.toJson());

    print('[INFO] Connecting to DB...');
    http.Response response = await http
        .post(Uri.parse('${link.server}/new-book'),
            headers: {"Content-Type": "application/json"}, body: body)
        .timeout(Duration(seconds: timeout));

    if (response.statusCode == 200) {
      print('Book in');
    } else {
      print('[INFO] Status Code: ${response.statusCode}');
      return false;
    }
  }
}

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

  String name = '';
  String id = '';
  String status = '';


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
                          name: name,
                          id: id,
                          status: status,
                          lbottomicon: FluentIcons.generic_scan,
                          rbottomicon: FluentIcons.pencil_reply,
                          rfx: studenttypeId),
                      PageBox(
                        height: 150,
                        width: 1400,
                        title: 'Books',
                        check: !hasdata,
                        name: name,
                        id: id,
                        status: status,
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
                    name: name,
                    id: id,
                    status: status,
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
                      name = decoded['memberName'];
                      id = decoded["referenceID"];
                      status = decoded["memberStatus"];
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
}

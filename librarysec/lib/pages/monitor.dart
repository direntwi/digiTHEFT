import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

class Monitor extends StatefulWidget {
  const Monitor({Key? key}) : super(key: key);

  @override
  State<Monitor> createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> {
  final Uri _url = Uri.parse('http://192.168.43.112/webserial');

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Padding(
          padding: EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("images/knust_logo_transparent.png"),
                          fit: BoxFit.fill)),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width),
              Container(
                child: ContentDialog(
                    //title: const Text('Confirm Logout'),
                    content: const Text('Follow this link to monitor Gate'),
                    actions: [
                      TextButton(
                        child: const Text('RFID GATE MONITOR'),
                        onPressed: () {
                          _launchUrl();
                        },
                      ),
                    ]),
              )
            ],
          )),
    );
  }

  Widget monitor() {
    return Container(
      child: ContentDialog(
          //title: const Text('Confirm Logout'),
          content: const Text('Follow this link to monitor Gate'),
          actions: [
            TextButton(
              child: const Text('RFID GATE MONITOR'),
              onPressed: () {
                _launchUrl();
              },
            ),
          ]),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}

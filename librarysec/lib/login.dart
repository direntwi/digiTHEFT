import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> with WindowListener {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          const Text(
            'digiTheft',
            style: TextStyle(
                fontSize: 30,
                color: Colors.purple,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          const Image(image: AssetImage('images/download.png')),
          SizedBox(
            height: 20,
          ),
          Container(
              height: 20,
              width: 100,
              child: TextField(
                style: const TextStyle(fontSize: 9),
                decoration: InputDecoration(
                  labelText: 'Identity',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                ),
              ))
        ])));
  }
}

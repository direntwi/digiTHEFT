import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _Page();
}

class _Page extends State<Login> with WindowListener {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          const Text(
            'KNUST LIBRARY PORTAL',
            style: TextStyle(
                fontSize: 30,
                color: Color(0xff610600),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset('images/knust_logo_transparent.png',
              height: 275, width: 275),
          SizedBox(
            height: 20,
          ),
          Column(
            children: <Widget>[
              SizedBox(
                  width: 400,
                  child: TextField(
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      labelText: 'Identity',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  )),
              SizedBox(height: 20),
              SizedBox(
                  width: 400,
                  child: TextField(
                    style: const TextStyle(fontSize: 15),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  ))
            ],
          )
        ])));
  }
}

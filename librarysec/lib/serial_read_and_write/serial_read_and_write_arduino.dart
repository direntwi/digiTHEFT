import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:serial_port_win32/serial_port_win32.dart';

void main() {
  var ports = SerialPort.getAvailablePorts();
  print(ports);

  if (ports.contains("COM3")) {
    final port = SerialPort("COM3", openNow: false, BaudRate: 9600);
    print("COM3 port found");

    port.open();
    print("isOpened: ${port.isOpened}");

    port.readBytesOnListen(8, (value) => print(value.toString()));
    String buffer = "True";
    port.writeBytesFromString(buffer);

  } else {
    print("Unable to find required COM port");
  }
}

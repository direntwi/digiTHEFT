import 'package:serial_port_win32/serial_port_win32.dart';

void main() {
  var ports = SerialPort.getAvailablePorts();
  print(ports);

  var converted = [];

  if (ports.contains("COM3")) {
    final port = SerialPort("COM3", openNow: false, BaudRate: 9600);
    port.open();
    print("COM3 port isOpened?: ${port.isOpened}");

    port.readBytesOnListen(32, (value) {

      for(final e in value){
        var currentElement = e;
          converted.add(String.fromCharCode(int.parse(currentElement.toString())));
      }
      print(converted.join());
    });

    String buffer = "True";
    port.writeBytesFromString(buffer);
    // port.close();

  } else {
    print("Unable to find required COM port");
  }

}



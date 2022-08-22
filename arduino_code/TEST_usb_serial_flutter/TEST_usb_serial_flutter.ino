void setup() {
   Serial.begin(9600);
   Serial.println("Enter string to echo:");
   delay(5000);
   Serial.println("Enter string to echo:");
   Serial.flush();
}

void loop() {

  while(Serial.available() > 0) {
    uint8_t byteFromSerial = Serial.read();
    uint8_t buff[100] = {byteFromSerial};
    String str = (char*)buff;
    Serial.print(str);
  }
}

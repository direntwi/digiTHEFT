String command;

void setup() {
  Serial.begin(9600);
  Serial.println("Serial input...");
  delay(5000);
  Serial.println("Serial input...");

  Serial.flush();

}

void loop() {

  if(Serial.available()) {
    command = Serial.readStringUntil('\n');
    command.trim();
    Serial.println(command + " was inputted");
  }
  
//      uint8_t fromSerial = Serial.read();
//      uint8_t buff[100] = {fromSerial};
//  
//      String str = (char*)buff;
//      Serial.print(str);
}

/*
  Software serial multple serial test

 Receives from the hardware serial, sends to software serial.
 Receives from software serial, sends to hardware serial.

 The circuit:
 * RX is digital pin 2 (connect to TX of other device)
 * TX is digital pin 3 (connect to RX of other device)

 Note:
 Not all pins on the Mega and Mega 2560 support change interrupts,
 so only the following can be used for RX:
 10, 11, 12, 13, 50, 51, 52, 53, 62, 63, 64, 65, 66, 67, 68, 69

 Not all pins on the Leonardo support change interrupts,
 so only the following can be used for RX:
 8, 9, 10, 11, 14 (MISO), 15 (SCK), 16 (MOSI).

 created back in the mists of time
 modified 25 May 2012
 by Tom Igoe
 based on Mikal Hart's example

 This example code is in the public domain.

 */
#include <SoftwareSerial.h>

SoftwareSerial mySerial(2, 3); // RX, TX

void setup()
{
  // Open serial communications and wait for port to open:
  Serial.begin(115200);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for Native USB only
  }


  Serial.println("Goodnight moon!");

  // set the data rate for the SoftwareSerial port
  mySerial.begin(38400);
  mySerial.println("Hello, world?");
}

void loop() // run over and over
{
  if (mySerial.available())
    Serial.write(mySerial.read());
  if (Serial.available())
    mySerial.write(Serial.read());
}



//#include <SoftwareSerial.h>
//
//SoftwareSerial wifiSerial(0, 1);      // RX, TX for ESP8266
//
//bool DEBUG = true;   //show more logs
//int responseTime = 10; //communication timeout
//
//void setup()
//{
//  pinMode(0,INPUT);
//  pinMode(1,OUTPUT);//set build in led as output
//  // Open serial communications and wait for port to open esp8266:
//  Serial.begin(115200);
//  while (!Serial) {
//    ; // wait for serial port to connect. Needed for Leonardo only
//  }
//  wifiSerial.begin(115200);
//  while (!wifiSerial) {
//    ; // wait for serial port to connect. Needed for Leonardo only
//  }
//  sendToWifi("AT+CWMODE=2",responseTime,DEBUG); // configure as access point
//  sendToWifi("AT+CIFSR",responseTime,DEBUG); // get ip address
//  sendToWifi("AT+CIPMUX=1",responseTime,DEBUG); // configure for multiple connections
//  sendToWifi("AT+CIPSERVER=1,80",responseTime,DEBUG); // turn on server on port 80
// 
//  sendToUno("Wifi connection is running!",responseTime,DEBUG);
//  
//
//}
//
//
//void loop()
//{
//  if(Serial.available()>0){
//     String message = readSerialMessage();
//    if(find(message,"debugEsp8266:")){
//      String result = sendToWifi(message.substring(13,message.length()),responseTime,DEBUG);
//      if(find(result,"OK"))
//        sendData("\nOK");
//      else
//        sendData("\nEr");
//    }
//  }
////  else{
////    Serial.println("TRUSTED");
////    }
//  
//  if(wifiSerial.available()>0){
//    
//    String message = readWifiSerialMessage();
//    
//    if(find(message,"esp8266:")){
//       String result = sendToWifi(message.substring(8,message.length()),responseTime,DEBUG);
//      if(find(result,"OK"))
//        sendData("\n"+result);
//      else
//        sendData("\nErrRead");               //At command ERROR CODE for Failed Executing statement
//    }else
//    if(find(message,"HELLO")){  //receives HELLO from wifi
//        sendData("\\nHI!");    //arduino says HI
//    }else if(find(message,"LEDON")){
//      //turn on built in LED:
//      digitalWrite(13,HIGH);
//    }else if(find(message,"LEDOFF")){
//      //turn off built in LED:
//      digitalWrite(13,LOW);
//    }
//    else{
//      sendData("\nErrRead");                 //Command ERROR CODE for UNABLE TO READ
//    }
//  }
//  delay(responseTime);
//}
//
//
///*
//* Name: sendData
//* Description: Function used to send string to tcp client using cipsend
//* Params: 
//* Returns: void
//*/
//void sendData(String str){
//  String len="";
//  len+=str.length();
//  sendToWifi("AT+CIPSEND=0,"+len,responseTime,DEBUG);
//  delay(100);
//  sendToWifi(str,responseTime,DEBUG);
//  delay(100);
//  sendToWifi("AT+CIPCLOSE=5",responseTime,DEBUG);
//}
//
//
///*
//* Name: find
//* Description: Function used to match two string
//* Params: 
//* Returns: true if match else false
//*/
//boolean find(String string, String value){
//  return string.indexOf(value)>=0;
//}
//
//
///*
//* Name: readSerialMessage
//* Description: Function used to read data from Arduino Serial.
//* Params: 
//* Returns: The response from the Arduino (if there is a reponse)
//*/
//String  readSerialMessage(){
//  char value[100]; 
//  int index_count =0;
//  while(Serial.available()>0){
//    value[index_count]=Serial.read();
//    index_count++;
//    value[index_count] = '\0'; // Null terminate the string
//  }
//  String str(value);
//  str.trim();
//  return str;
//}
//
//
//
///*
//* Name: readWifiSerialMessage
//* Description: Function used to read data from ESP8266 Serial.
//* Params: 
//* Returns: The response from the esp8266 (if there is a reponse)
//*/
//String  readWifiSerialMessage(){
//  char value[100]; 
//  int index_count =0;
//  while(wifiSerial.available()>0){
//    value[index_count]=wifiSerial.read();
//    index_count++;
//    value[index_count] = '\0'; // Null terminate the string
//  }
//  String str(value);
//  str.trim();
//  return str;
//}
//
//
//
///*
//* Name: sendToWifi
//* Description: Function used to send data to ESP8266.
//* Params: command - the data/command to send; timeout - the time to wait for a response; debug - print to Serial window?(true = yes, false = no)
//* Returns: The response from the esp8266 (if there is a reponse)
//*/
//String sendToWifi(String command, const int timeout, boolean debug){
//  String response = "";
//  wifiSerial.println(command); // send the read character to the esp8266
//  long int time = millis();
//  while( (time + timeout) > millis())
//  {
//    while(wifiSerial.available())
//    {
//    // The esp has data so display its output to the serial window 
//    char c = wifiSerial.read(); // read the next character.
//    response += c;
//    }  
//  }
//  if(debug)
//  {
//    Serial.println(response);
//  }
//  return response;
//}
//
///*
//* Name: sendToUno
//* Description: Function used to send data to Arduino.
//* Params: command - the data/command to send; timeout - the time to wait for a response; debug - print to Serial window?(true = yes, false = no)
//* Returns: The response from the esp8266 (if there is a reponse)
//*/
//String sendToUno(String command, const int timeout, boolean debug){
//  String response = "";
//  Serial.println(command); // send the read character to the esp8266
//  long int time = millis();
//  while( (time+timeout) > millis())
//  {
//    while(Serial.available())
//    {
//      // The esp has data so display its output to the serial window 
//      char c = Serial.read(); // read the next character.
//      response+=c;
//    }  
//  }
//  if(debug)
//  {
//    Serial.println(response);
//  }
//  return response;
//}

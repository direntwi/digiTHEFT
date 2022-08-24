#include <SPI.h>
#include <MFRC522.h>
#include <RFID.h>
#define SS_PIN 10
#define RST_PIN 9
#define BUZZER_PIN 8

RFID rfid(SS_PIN, RST_PIN);
MFRC522 mfrc522(SS_PIN, RST_PIN);

MFRC522::MIFARE_Key key;

String finalValue;

void setup() {
  Serial.begin(9600);
  SPI.begin();
  mfrc522.PCD_Init();
  Serial.println("Scan a MIFARE Classic card");

  for (byte i = 0; i < 6; i++) {
    key.keyByte[i] = 0xFF;
  }

}

int block = 2;

byte blockcontent[16] = {"SubScribe______"};
//byte blockcontent[16] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};//all zeros. This can be used to delete a block.
byte readbackblock[18];

void loop() {
  // Wait for an RFID card to be read
  
  if ( ! mfrc522.PICC_IsNewCardPresent()) {
    return;
  }

      Serial.println("about to authenticate tag");

  

    // Select one of the cards
  if ( ! mfrc522.PICC_ReadCardSerial()) {//if PICC_ReadCardSerial returns 1, the "uid" struct (see MFRC522.h lines 238-45)) contains the ID of the read card.
    return;//if it returns a '0' something went wrong and we return to the start of the loop
  }

    Serial.println("about to read block");

  

  readBlock(block, readbackblock);

  finalValue = extractReadBlock(readbackblock);
  
  Serial.println(finalValue);

  if(finalValue == "84114117101"){
    beepBuzzer();
  }
  mfrc522.PCD_StopCrypto1();
//  mfrc522.PICC_HaltA();
}

void beepBuzzer() {
  tone(BUZZER_PIN, 1000);
  delay(1000);
  noTone(BUZZER_PIN);
}

String extractReadBlock(byte readblock) {
  //  Serial.println("Reading block");
  String temp = "";
  for (int j = 0 ; j < 4 ; j++) //print the block contents
  {
    // Adds read value to temp string
    temp += readbackblock[j];
    //     Serial.write (readbackblock[j]);//Serial.write() transmits the ASCII numbers as human readable characters to serial monitor
  }
  //   Serial.println("");

  return temp;

}

int readBlock(int blockNumber, byte arrayAddress[]) {
  int largestModulo4Number = blockNumber / 4 * 4;
  int trailerBlock = largestModulo4Number + 3; //determine trailer block for the sector

  byte status = mfrc522.PCD_Authenticate(MFRC522::PICC_CMD_MF_AUTH_KEY_A, trailerBlock, &key, &(mfrc522.uid));

  if (status != MFRC522::STATUS_OK) {
    Serial.print("PCD_Authenticate() failed (read): ");
    Serial.println(mfrc522.GetStatusCodeName(status));
    return 3;//return "3" as error message
  }

  byte buffersize = 18;
  status = mfrc522.MIFARE_Read(blockNumber, arrayAddress, &buffersize);
  if (status != MFRC522::STATUS_OK) {
    Serial.print("MIFARE_read() failed: ");
    Serial.println(mfrc522.GetStatusCodeName(status));
    return 4;//return "4" as error message
  }
  Serial.println("block was read");
}

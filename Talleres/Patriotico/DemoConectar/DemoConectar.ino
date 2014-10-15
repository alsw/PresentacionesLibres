#include <SoftwareSerial.h>

SoftwareSerial BTSerial(10, 11); // RX | TX

void setup()
{
  Serial.begin(9600);
  Serial.println("Entra en comandos AT:");
  BTSerial.begin(9600);  
}

void loop()
{

  // Leer el puerto HC-05 y lo escrive en el puerto serial de Arduino
  if (BTSerial.available())
    Serial.write(BTSerial.read());

  // Lee el  puerto serial del arduino y lo escrive en el puerto serial
  if (Serial.available())
    BTSerial.write(Serial.read());
}

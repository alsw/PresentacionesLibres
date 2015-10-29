#include <Bridge.h>
#include <SpacebrewYun.h>

// Crea la variable de SpacebrewYun y la inicializa con el constructor
SpacebrewYun sb = SpacebrewYun("Demo_arduino", "Demo del arduino day El Salvador alsw.net/arduinoday");

// variable que guarda el ultimo estado del boton
int last_value = 0;

void setup() {

  // Inicializa el puerto serial
  Serial.begin(57600);

  // Inicia el bridge(puente entre el arduino y liliro)
  Bridge.begin();

  // Configuracion para que spacebrew imprima estado en le serial
  sb.verbose(false);

  // Configura el publicado y subcriptor de spacebrew
  sb.addPublish("Boton_Fisico", "boolean");
  sb.addSubscribe("Led", "boolean");

  // register the string message handler method
  sb.onBooleanMessage(handleBoolean);

  // conectano al nube publica
  sb.connect("sandbox.spacebrew.cc");


  //boton
  pinMode(3, INPUT);
  digitalWrite(3, HIGH);
  
  //Led
  pinMode(13, OUTPUT);
  digitalWrite(13, LOW);
}


void loop() {
  // Monitor si existen nuevo dato de spacebrew
  sb.monitor();

  // Si viene esta conectado y el boton en diferente del estado anterrior envia data
  if ( sb.connected() ) {
    int cur_value = digitalRead(3);
    if ( last_value != cur_value ) {
      if (cur_value == HIGH) sb.send("Boton_Fisico",  0);
      else sb.send("Boton_Fisico", 1);
      last_value = cur_value;
    }
  }
}

// Metodo que es llamado cuando llega un dato buliano
void handleBoolean (String route, boolean value) {
  // Imprime los mensaes que les llega
  Serial.print("Mensaje de ");
  Serial.print(route);
  Serial.print(", Recivimos: ");
  Serial.println(value ? "true" : "false");
  digitalWrite(13, value);

}


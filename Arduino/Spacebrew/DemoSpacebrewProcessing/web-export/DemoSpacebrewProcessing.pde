import spacebrew.*;

//Datos con el servidor spacebrew
String server="sandbox.spacebrew.cc";
String name="Demo_Processing";
String description ="Demo del arduino day El Salvador alsw.net/arduinoday";

//Crea intancia con spacebrew
Spacebrew sb;

//Crea los colores de fondo para activo y desactivo 
color color_on = color(0, 151, 156);
color color_off = color(255, 255, 255);
int currentColor = color_off;

void setup() {
  frameRate(240);
  size(500, 400);

  sb = new Spacebrew( this );

  //Crea el enviar datos de spacebrew
  sb.addPublish( "Boton_Virtal","range", 0); 

  //crea e escuchar datos de spacebrew
  sb.addSubscribe( "Fondo", "range" );

  //Conectarce con Spacebrew
  sb.connect(server, name, description );
}

void draw() {
  // Setea el color de fondo
  background( currentColor );

  // Dibuja el Boton
  fill(0, 0, 255);
  stroke(200, 0, 0);
  rectMode(CENTER);
  ellipse(width/2, height/2, 250, 250);

  // añade el Texto al boton
  fill(230);
  textAlign(CENTER);
  textSize(24);
  if (mousePressed == true) {
    text("Gracias", width/2, height/2 + 12);
  } else {
    text("Precioname", width/2, height/2 + 12);
  }
}

void mousePressed(){
  // Envia el mensaje a spacebrew cuando se preciona
  sb.send( "Boton_Virtal", 1);
}

void mouseReleased(){
  // Envia el mensaje a spacebrew cuando se suelta
  sb.send( "Boton_Virtal", 0);
}

void onBooleanMessage( String name, boolean value ) {
  println("Obtiene Mensage Buliano de " + name + " : " + value); 

  // actualizar fondo
  if (value == true) {
    currentColor = color_on;
  } else {
    currentColor = color_off;
  }
}



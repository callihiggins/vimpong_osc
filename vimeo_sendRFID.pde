import processing.serial.*;
import oscP5.*;
import netP5.*;
boolean mousecontrol;
int message;
int pot1, pot2;
OscP5 oscP5;
//OscP5 oscP5_2;
NetAddress myRemoteLocation;

int joystick1; // To store data from serial port,
int joystick2 = 0;
String id = "";
String lastId = "";
VimeoGrabber grab;
String user;

void setup() {
  size(640, 360);
  //frameRate(6);
  joystick1 = height/2;
  joystick2 = height/2;
  oscP5 = new OscP5(this, 9002);
  mousecontrol = false;

  //ITP
  //    myRemoteLocationC = new NetAddress("128.122.151.179", 9202);
  //    myRemoteLocationL = new NetAddress("128.122.151.180", 9201);
  //    myRemoteLocationR = new NetAddress("128.122.151.177", 9203);

  //IAC
  //  myRemoteLocationC = new NetAddress ("192.168.130.241", 12346);
  //  myRemoteLocationL = new NetAddress("192.168.130.240", 12345);
  //  myRemoteLocationR = new NetAddress("192.168.130.242", 12347);

  //  myRemoteLocationC = new NetAddress("localhost", 12346);

  // My Laptop
  myRemoteLocation = new NetAddress("127.0.0.1", 9003);



  // println("Available serial ports:");
  // Print a list of the serial ports, for debugging purposes:
  println(Serial.list());

  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].

  String portName = Serial.list()[0];
  //  myPort = new Serial(this, portName, 9600);
  // myPort.write(65);

  //  user1 = "calli";
  //  user2 = "imagima";
  grab = new VimeoGrabber();
}

void keyPressed() {
  if (key=='M' || key == 'm')
    mousecontrol =! mousecontrol;

  if ( (key > 47 && key < 58) || (key > 64 && key < 91) ) id += key;
  else if (keyCode == ENTER ) {
    if (!id.equals(lastId) && id.length() == 10) { // prevents double/bad reads
      newId();
    }
    id = "";
  }

  if (key== 'l') {
    if (joystick1< height) {
      joystick1 +=40;
    }

    println(joystick1);
  }
  if (key== 'r') {
    if (joystick1> 0) {
      joystick1 -=40;
    }

    println(joystick1);
  }
  if(key =='b'){
    OscMessage myMessage = new OscMessage("/ball");
    myMessage.add("go!");
    oscP5.send(myMessage, myRemoteLocation);
  }
}

void newId() {
  // put your actions
  println("current id: " + id + " " + id.length());
  grab.requestImage(id);
  user = grab.getuserPhoto();
  OscMessage myMessage = new OscMessage("/user");
  myMessage.add(user);
  oscP5.send(myMessage, myRemoteLocation); 
  lastId = id;
}




void draw() {

  if (mousecontrol == true) {
    joystick1 = mouseY;
    // joystick2 = mouseY;


    background(255); 
    int message = mouseY;
    stroke(0);
    rect(100, mouseY, 10, height/2);

    OscMessage myMessage = new OscMessage("/pot");
    myMessage.add(message);


    oscP5.send(myMessage, myRemoteLocation);
  }

  else {

    background(255); 


    fill(0);
    rect(100, joystick1, 10, 10);
    // rect(width/2 + 100, joystick2, 10, 10);

    OscMessage myMessage = new OscMessage("/joysticks");
    myMessage.add(joystick1);
    // myMessage.add(josystick2);



    /* send the message */

    oscP5.send(myMessage, myRemoteLocation);
  }
}
void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */

  if (theOscMessage.checkAddrPattern("/pot")==true) {

    int pot1 = theOscMessage.get(0).intValue();  
    int pot2 = theOscMessage.get(1).intValue();  
    //  print("### received an osc message ");
    //  println(" values: "+pot1+ ", "+pot2);
    return;
  }
}





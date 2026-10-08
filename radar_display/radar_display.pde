import processing.serial.*;

Serial port;
int PORT_INDEX = 0;
int maxDist = 50;

float R;
int angle = 90;
int dist = 0;
int[] hits = new int[181];
String buf = "";

void setup() {
  fullScreen();
  smooth();
  R = min(width / 2.0 - 60, height - 140);
  println(Serial.list());
  port = new Serial(this, Serial.list()[PORT_INDEX], 9600);
}

void draw() {
  background(30);
  readSerial();

  pushMatrix();
  translate(width / 2, height - 60);
  drawGrid();
  drawHits();
  drawSweep();
  popMatrix();

  drawReadout();
}

void readSerial() {
  while (port.available() > 0) {
    char c = port.readChar();
    if (c == '.' || c == '\n') {
      parseLine(buf);
      buf = "";
    } else {
      buf += c;
    }
  }
  if (buf.length() > 100) buf = "";
}

void parseLine(String s) {
  String[][] m = matchAll(s, "(\\d+)\\s*,\\s*(\\d+)");
  if (m == null) return;
  angle = constrain(int(m[0][1]), 0, 180);
  dist = int(m[0][2]);
  hits[angle] = (dist > 0 && dist <= maxDist) ? dist : 0;
}

void drawGrid() {
  noFill();
  stroke(0, 255, 0);
  strokeWeight(2);
  textSize(22);
  textAlign(CENTER);
  for (int i = 1; i <= 5; i++) {
    float r = R * i / 5.0;
    arc(0, 0, r * 2, r * 2, PI, TWO_PI);
    fill(0, 255, 0);
    text((maxDist * i / 5) + "cm", r, 28);
    noFill();
  }
  for (int a = 0; a <= 180; a += 30) {
    line(0, 0, R * cos(radians(a)), -R * sin(radians(a)));
  }
  line(-R, 0, R, 0);
}

void drawHits() {
  stroke(255, 0, 0);
  strokeWeight(5);
  for (int a = 0; a <= 180; a++) {
    if (hits[a] > 0) {
      float r1 = R * hits[a] / maxDist;
      line(r1 * cos(radians(a)), -r1 * sin(radians(a)),
           R * cos(radians(a)), -R * sin(radians(a)));
    }
  }
}

void drawSweep() {
  stroke(0, 255, 0);
  strokeWeight(3);
  line(0, 0, R * cos(radians(angle)), -R * sin(radians(angle)));
}

void drawReadout() {
  fill(0, 255, 0);
  textSize(30);
  textAlign(LEFT);
  text("Angle: " + angle + "   Distance: " + dist + " cm", 40, height - 25);
}

import processing.pdf.*;

void setup() {
  size(480,480);
  stroke(255);
}

void draw() {
  line(width/2,height/2,mouseX,mouseY);
}

void mousePressed() {
  saveFrame("output-####.png");
  background(192,64,0);
}

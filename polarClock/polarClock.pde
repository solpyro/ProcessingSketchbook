int nX,nY;
float rS, rM, rH;
color cBg, cS, cM, cH;

void setup() {
  size(480,480);
  noFill();
  strokeWeight(40);
  
  nX = width/2;
  nY = height/2;
  
  rS = 400;
  rM = 250;
  rH = 100;
  
  cBg = color(#000000);
  cS = color(#ff0000);
  cM = color(#00ff00);
  cH = color(#0000ff);
}

void draw() {
  //clear the screen
  background(cBg);
  //calculate the arc angles
  float s = map(second(),0,60,0,TWO_PI)-HALF_PI;
  float m = map(minute(),0,60,0,TWO_PI)-HALF_PI;
  float h = map(hour(),0,24,0,TWO_PI)-HALF_PI;
  //draw the seconds arc
  stroke(cS);
  arc(nX,nY,rS,rS,0-HALF_PI,s);
  //draw the minutes arc
  stroke(cM);
  arc(nX,nY,rM,rM,0-HALF_PI,m);
  //draw the hours arc
  stroke(cH);
  arc(nX,nY,rH,rH,0-HALF_PI,h);
}

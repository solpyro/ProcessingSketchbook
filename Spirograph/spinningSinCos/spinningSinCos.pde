float fDTheta = PI/512;
int iMaxR = 50;//100;
int iMinR = 50;
int iStroke = 5;
color cStroke = color(#ffffff);
color cBg = color(#000000);
float fX = 3;
float fY = 5;

float fTheta = 0.0;
int iX, iY;



void setup() {
  size((iMaxR+iMinR)*3,(iMaxR+iMinR)*3);
  background(cBg);
  stroke(cStroke);
  strokeWeight(iStroke);
  rectMode(RADIUS);
  
  iX = int(iMaxR+(iMinR*cos(fTheta*fX)));
  iY = int(iMaxR+(iMinR*sin(fTheta*fY)));
}

void draw() {
  fTheta += fDTheta;
  
  translate(width/2,height/2);
  rotate(fTheta);
  int iNewX = int(iMaxR +(iMinR*cos(fTheta*fX)));
  int iNewY = int(iMaxR +(iMinR*sin(fTheta*fY)));
  stroke(#ffffff);
  //point(0,0);
  fill(cBg,5);
  rect(0,0,width,height);
  line(iX,iY,iNewX,iNewY);//iX,10);//int(fTheta));//iNewY);
  
  iX = iNewX;
  iY = iNewY;
}

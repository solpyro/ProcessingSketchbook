int iX, iY;
int iClockR, iHourR, iMinR, iSecR;

color cBg, cLine;
int iWeight;
int iTickR;

void setup() {
  size(640,640);
  
  iX = width/2;
  iY = height/2;
  
  iClockR = 600;
  iHourR = 475;//466;
  iMinR = 300;//333;
  iSecR = 150;//200;
  
  cBg = color(#000000);
  cLine = color(#ffffff);
  iWeight = 5;  
  iTickR = 0;
  
  strokeWeight(iWeight);
  stroke(cLine);
  noFill();
}

void draw() {
  background(cBg);
  
  float s = map(second(),0,60,0,TWO_PI);
  float m = map(minute(),0,60,0,TWO_PI);
  float h = map(hour(),0,24,0,TWO_PI);
  
  translate(iX,iY);
  
  //outer circle
  ellipse(0,0,iClockR,iClockR);
  //hour ticks
  if(iTickR>0) {
    for(float f=0.0;f<TWO_PI;f+=(PI/12)) {
      pushMatrix();
      rotate(f);
      line(0,-(iClockR/2-iTickR),0,-(iClockR/2+iTickR));
      popMatrix();
    }
  }
  
  //hour circle
  rotate(h+(m/60)+(s/3600));
  translate(0,(iHourR-iClockR)/2);
  ellipse(0,0,iHourR,iHourR);
  //minute ticks
  if(iTickR>0) {
    for(float f=0.0;f<TWO_PI;f+=(PI/6)) {
      pushMatrix();
      rotate(f);
      line(0,-(iHourR/2-iTickR),0,-(iHourR/2+iTickR));
      popMatrix();
    }
  }
  
  //minute circle
  rotate(m+(s/60));
  translate(0,(iMinR-iHourR)/2);
  ellipse(0,0,iMinR,iMinR);
  //second ticks
  if(iTickR>0) {
    for(float f=0.0;f<TWO_PI;f+=(PI/6)) {
      pushMatrix();
      rotate(f);
      line(0,-(iMinR/2-iTickR),0,-(iMinR/2+iTickR));
      popMatrix();
    }
  }
  
  //second circle
  rotate(s);
  translate(0,(iSecR-iMinR)/2);
  ellipse(0,0,iSecR,iSecR);
  
}

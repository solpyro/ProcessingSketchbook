float fMaxDist, fMaxRad; 
color cBg, cFill;

void setup() {
  size(640,480);
  
  fMaxDist = dist(0,0,width,height);
  fMaxRad = 10; //circles are 20px wide
  
  cBg = color(#000000);
  cFill = color(#ffffff);
  
  noStroke();
  fill(cFill);
}

void draw() {
  background(cBg);
  
  for(int i=0;i<width/fMaxRad;i++) {
    for(int j=0;j<height/fMaxRad;j++) {
      float fDist = dist(mouseX,mouseY,i*fMaxRad,j*fMaxRad);
      float fRad = (1-(fDist/fMaxDist))*fMaxRad;
      ellipse((i*fMaxRad)+fMaxRad/2,(j*fMaxRad)+fMaxRad/2,fRad,fRad);
    }
  }
}

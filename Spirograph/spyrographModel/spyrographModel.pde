
int iCircleR;
float fCogD, fCogR, fCogTheta, fCogDTheta, fCircleCogRatio;
float fPointOffset, fLastPointX, fLastPointY;
boolean bShowWorking;
PGraphics gImage;
color cBg, cLine, cConstruction;

void setup() {
  size(500,500);
  
  //prepare variables
  bShowWorking = false;
  iCircleR = min(width,height)/2;
  fCogD = random(iCircleR*.2,iCircleR*1.4);
  //fCogD -= 
  fCogR = iCircleR-fCogD/2;
  fCogTheta = random(0,TWO_PI);
  fCogDTheta = random(0.05,0.08);
  fPointOffset = random(fCogD*.05,fCogD*.45);
  fCircleCogRatio = (iCircleR*2)/fCogD;
  float fCogX = (width/2) + (fCogR*cos(fCogTheta));
  float fCogY = (height/2) + (fCogR*sin(fCogTheta));
  fLastPointX = fCogX + (fPointOffset*cos(-fCircleCogRatio*fCogTheta));
  fLastPointY = fCogY + (fPointOffset*sin(-fCircleCogRatio*fCogTheta));
  
  //prepare colours
  cBg = color(0);
  cLine = color(random(255),random(255),random(255));
  cConstruction = color(255);
  
  //prepare lines
  noFill();
  strokeWeight(1);
  stroke(cConstruction);  
  
  //prepare the image
  gImage = createGraphics(width,height);
  gImage.beginDraw();
  gImage.background(cBg);
  gImage.stroke(cLine);
  gImage.endDraw();  
}

void draw() {  
  //calculate new positions
  fCogTheta += fCogDTheta;
  float fCogX = (width/2) + (fCogR*cos(fCogTheta));
  float fCogY = (height/2) + (fCogR*sin(fCogTheta));
  
  float fPointX = fCogX + (fPointOffset*cos(-fCircleCogRatio*fCogTheta));
  float fPointY = fCogY + (fPointOffset*sin(-fCircleCogRatio*fCogTheta));
  
  //draw to the image
  gImage.beginDraw();
  gImage.line(fLastPointX,fLastPointY,fPointX,fPointY);
  gImage.endDraw();
  
  //update point buffer
  fLastPointX = fPointX;
  fLastPointY = fPointY;
  
  //draw the image
  image(gImage,0,0);
  
  //draw the construction
  if(bShowWorking) {
    ellipse(width/2,height/2,iCircleR*2,iCircleR*2);
    ellipse(fCogX,fCogY,fCogD,fCogD);
    line(fCogX,fCogY,fPointX,fPointY);
  }
}

void keyPressed() {
  switch(key) {
    case 'c':
      bShowWorking  = !bShowWorking;
      break;
    case ' ':
      gImage.beginDraw();
      gImage.background(cBg);
      gImage.endDraw();
    case 'n':
      //set new line colour
      gImage.beginDraw();
      gImage.stroke(color(random(255),random(255),random(255)));
      gImage.endDraw();
      //define new cog
      fCogD = random(iCircleR*.2,iCircleR*1.4);
      fCogR = iCircleR-fCogD/2;
      fCogTheta = random(0,TWO_PI);
      fCogDTheta = random(0.05,0.08);
      fPointOffset = random(fCogD*.05,fCogD*.45);
      fCircleCogRatio = (iCircleR*2)/fCogD;
      float fCogX = (width/2) + (fCogR*cos(fCogTheta));
      float fCogY = (height/2) + (fCogR*sin(fCogTheta));
      fLastPointX = fCogX + (fPointOffset*cos(-fCircleCogRatio*fCogTheta));
      fLastPointY = fCogY + (fPointOffset*sin(-fCircleCogRatio*fCogTheta));
      break;
    case 's':
      saveFrame("SpyrographModel-####.png");
      break;
  }
}

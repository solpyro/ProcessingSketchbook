
int iCircleR, iCycles = 1;
float fCogD, fCogR, fCogTheta, fCogDTheta, fCircleCogRatio;
float fPointOffset, fLastPointX, fLastPointY;
boolean bShowWorking;
PGraphics gImage;
color cBg, cLine, cConstruction;

void setup() {
  size(500, 500);

  //prepare variables
  bShowWorking = true;//false;
  iCircleR = min(width, height)/2;

  generateCog();


  //prepare colours
  cBg = color(0);
  cLine = color(random(255), random(255), random(255));
  cConstruction = color(255);

  //prepare lines
  noFill();
  strokeWeight(1);
  stroke(cConstruction);  

  //prepare the image
  gImage = createGraphics(width, height);
  gImage.beginDraw();
  gImage.background(cBg);
  gImage.stroke(cLine);
  gImage.endDraw();
}

void generateCog() {
  //build new system:
  //select random int for number of cycles...(equal to GCF)
  iCycles = int(random(2,12));//between 2 and 11
  
  //calculate cog D such that it's circmference is a factor of the circle's circumference
  //this only produces patterns with iCycle+1 points, in 1 traverse of the circle
  fCogD = (iCircleR*2)/iCycles; 
  fCircleCogRatio = float(iCycles);
  
  //calculate cog R from GCF
  /*
  iCycles = ((2*iCircleR)*fCogR)/fGCF;
   
   iCycles*fGCF = ((2*iCircleR)*fCogR);
   
   (iCycles*fGCF)/(2*iCircleR) = fCogR;
   */


  //fCogD = random(iCircleR*.2,iCircleR*1.4);
  fCogR = iCircleR-fCogD/2;
  fCogTheta = 0;//random(0, TWO_PI);
  fCogDTheta = 0.002;//random(0.05, 0.08);
  fPointOffset = fCogD/2;//random(fCogD*.05, fCogD*.45);
  //fCircleCogRatio = round((iCircleR*2)/fCogD);
  float fCogX = (width/2) + (fCogR*cos(fCogTheta));
  float fCogY = (height/2) + (fCogR*sin(fCogTheta));
  fLastPointX = fCogX + (fPointOffset*cos(-fCircleCogRatio*fCogTheta));
  fLastPointY = fCogY + (fPointOffset*sin(-fCircleCogRatio*fCogTheta));

  println(iCycles+" | "+fCircleCogRatio);
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
  gImage.line(fLastPointX, fLastPointY, fPointX, fPointY);
  gImage.endDraw();

  //update point buffer
  fLastPointX = fPointX;
  fLastPointY = fPointY;

  //draw the image
  image(gImage, 0, 0);

  //draw the construction
  if (bShowWorking) {
    ellipse(width/2, height/2, iCircleR*2, iCircleR*2);
    ellipse(fCogX, fCogY, fCogD, fCogD);
    line(fCogX, fCogY, fPointX, fPointY);
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
    gImage.stroke(color(random(255), random(255), random(255)));
    gImage.endDraw();
    //define new cog
    generateCog();
    break;
  case 's':
    saveFrame("SpyrographModel-####.png");
    break;
  }
}

float lcm(float a, float b) {
  float fGCF = gcf(a, b);
  return (a*b)/fGCF;
}

float gcf(float a, float b) {
  //order values
  if (b>a) {
    float c = b;
    b = a;
    a = c;
  }
  //find GCD
  float R = a%b;
  float r = R;
  while (r!=0) {
    R = r;
    r = b%R;
  }
  return R;
}
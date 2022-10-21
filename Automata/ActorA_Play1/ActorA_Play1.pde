
int iAutomataCount;
int iMinR,iMaxR;
int iMinS,iMaxS;
int iLimit;
int iProximity;
int iSeed, iRestart;
color cBg, cStroke, cConstruct;
boolean bShowWorking;

ActorA[] aActors;
PGraphics image;

void setup() {
  size(500,500);
  
  iSeed = millis()%1000;
  iRestart = millis();
  randomSeed(iSeed);
  
  cBg = color(255);
  cStroke = color(0,32,48);
  cConstruct = color(255,0,0);
  bShowWorking = false;
  
  image = createGraphics(width,height);
  
  image.beginDraw();
  image.background(cBg);
  image.stroke(cStroke,30);
  image.endDraw();

  //initilise global variables
  iMinR = 10;
  iMaxR = 50;
  iMinS = 2;
  iMaxS = 5;
  iLimit = min(width,height)/2;
  iProximity = 80;
  
  //initilise automata
  iAutomataCount = 10;
  aActors = new ActorA[iAutomataCount];
  for(int i=0;i<iAutomataCount;i++) {
    int r = (int)random(iMinR,iMaxR);
    
    float theta = random(0,TWO_PI);
    float initR = random(0,iLimit-r);
    float x = initR*sin(theta);
    float y = initR*cos(theta);
    
    float s = random(iMinS,iMaxS);
    float sTheta = random(0,TWO_PI);
    float rX = s*sin(sTheta);
    float rY = s*cos(sTheta);
    
    aActors[i] = new ActorA(x,y,rX,rY,r);
  }
  
  
}
void draw() {
  //move origin to centre
  translate(width/2,height/2);
  
  //move the automata
  for(int i=0;i<iAutomataCount;i++)
    aActors[i].move();

  //allow the automata to arrange themselves
  for(int i=0;i<iAutomataCount;i++)
   aActors[i].react(iLimit);

  //draw between automata
  image.beginDraw();
  image.translate(width/2,height/2);
  for(int i=0;i<aActors.length-1;i++)
    for(int j=i+1;j<aActors.length;j++)
      if(dist(aActors[i].x,aActors[i].y,aActors[j].x,aActors[j].y)<=iProximity)
        image.line(aActors[i].x,aActors[i].y,aActors[j].x,aActors[j].y);
  image.endDraw();
  
  //draw the automata image
  image(image,-width/2,-height/2);
  
  //draw the automata
  if(bShowWorking) {
    noFill();
    stroke(cConstruct,70);    
    //show container
    ellipse(0,0,min(width,height),min(width,height));
    //draw each automata
    for(int i=0;i<iAutomataCount;i++) {
      aActors[i].display();
    }
    fill(cConstruct,70);
    text("Seed: "+iSeed,-iLimit,10-iLimit);
    text("Time: "+(millis()-iRestart),-iLimit,25-iLimit);
  }
}

void keyPressed() {
  switch(key) {
    case 'c':
      bShowWorking = !bShowWorking;
      break;
    case 's':
      saveFrame("ActorA-Play1-S"+iSeed+"-T"+(millis()-iRestart)+".png");
      break;
    case ' ':
      iSeed = (int)(random(1)*1000);
      randomSeed(iSeed);
      iRestart = millis();
      for(int i=0;i<aActors.length;i++) {
        int r = (int)random(iMinR,iMaxR);
    
        float theta = random(0,TWO_PI);
        float initR = random(0,iLimit-r);
        float x = initR*sin(theta);
        float y = initR*cos(theta);
        
        float s = random(iMinS,iMaxS);
        float sTheta = random(0,TWO_PI);
        float rX = s*sin(sTheta);
        float rY = s*cos(sTheta);
        
        aActors[i].change(x,y,rX,rY,r);
      }
      image.beginDraw();
      image.background(cBg);
      image.endDraw();
      break;
    default:
      println("Unknown command <"+key+">");
  }
}

public class ActorA {
  float x,y,dx,dy;
  int r;
  
  public ActorA(float fX, float fY, float fDX, float fDY, int iR) {
    x = fX;
    y = fY;
    dx = fDX;
    dy = fDY;
    r = iR;
  }
  
  void change(float fX, float fY, float fDX, float fDY, int iR) {
    x = fX;
    y = fY;
    dx = fDX;
    dy = fDY;
    r = iR;
  }
  
  void move() {
    //move to new position
    x += dx;
    y += dy;
  }
  void react(int limit) {
    //check for bouncing off the wall
    if(dist(0,0,x,y)+r>=limit) {
      //This code was derived from algebra found here:
      //http://rectangleworld.com/blog/archives/358 
      float twoProjNV = 2*(((dx*x)+(dy*y))/(sq(x)+sq(y)));
      dx -= twoProjNV*x;
      dy -= twoProjNV*y;
    }
    //check for bouncing off other automata
    
  }
  
  void display() {
    //draw radius
    ellipse(x,y,2*r,2*r);
    //draw vector
    line(x,y,x+dx,y+dy);
    ellipse(x,y,5,5);
  }
}

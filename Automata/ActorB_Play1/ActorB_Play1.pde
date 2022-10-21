
int iAutomataCount;
int iMinR,iMaxR;
int iMinS,iMaxS;
int iLimit;
int iProximity;
color cBg, cStroke, cConstruct;
boolean bShowWorking;

ActorB[] aActors;
PGraphics image;

void setup() {
  size(500,500);
  
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
  aActors = new ActorB[iAutomataCount];
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
    
    aActors[i] = new ActorB(x,y,rX,rY,r);
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

  //draw between automata !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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
    
    //the bounce doesn't function properly 
    fill(cConstruct,100);
    text("this is not working",0,0);
  }
}

void keyPressed() {
  switch(key) {
    case 'c':
      bShowWorking = !bShowWorking;
      break;
    case 's':
      saveFrame("ActorB-Play1-####.png");
      break;
    case ' ':
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

public class ActorB {
  float x,y,dx,dy;
  int r;
  
  public ActorB(float fX, float fY, float fDX, float fDY, int iR) {
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
    //check for bouncing off other automata - this is not working
    for(int i=0;i<aActors.length;i++)
      if(aActors[i]!=this)
        if(dist(x,y,aActors[i].x,aActors[i].y)<=r+aActors[i].r) {
          float tempX = dx;
          float tempY = dy;
          dx = aActors[i].dx;
          dy = aActors[i].dy;
          aActors[i].dx = tempX;
          aActors[i].dy = tempY;
        }
  }
  
  void display() {
    //draw radius
    ellipse(x,y,2*r,2*r);
    //draw vector
    line(x,y,x+dx,y+dy);
    ellipse(x,y,5,5);
  }
}

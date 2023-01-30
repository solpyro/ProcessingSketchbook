
int iAutomataCount;
int iMinR,iMaxR;
int iMinS,iMaxS;
int iLimit;
int iProximity;
color cBg, cStroke, cConstruct;
boolean bShowWorking;

ActorC[] aActors;
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
  aActors = new ActorC[iAutomataCount];
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
    
    aActors[i] = new ActorC(x,y,r);
  }
  
  
}
void draw() {
  //move origin to centre
  translate(width/2,height/2);
  
  //move the automata
  for(int i=0;i<iAutomataCount;i++)
    aActors[i].move(aActors);

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
        
        aActors[i].change(x,y, r);
      }
      image.beginDraw();
      image.background(cBg);
      image.endDraw();
      break;
    default:
      println("Unknown command <"+key+">");
  }
}
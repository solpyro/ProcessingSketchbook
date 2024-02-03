int pointCount = 500;
int radius = 500;

Point[] points;
boolean rainbow = true;
boolean tail = true;

void setup() {
  //size(1600,900);
  fullScreen(2);
  frameRate(24);
  colorMode(HSB, pointCount, 100, 100, 100);
  background(0,0,0);
  
  int midX = width/2;
  int midY = height/2;
  
  PVector initialPos = new PVector(0,-radius);
  PVector initialDir = PVector.random2D().mult(3+random(2));//should we scale this unit vector by something?
  float rotation = (float)(2*Math.PI)/pointCount;
  
  points = new Point[pointCount];
  for (int i=0;i<pointCount;i++) {
    points[i] = new Point(midX+initialPos.x, midY+initialPos.y, initialDir.x, initialDir.y, (i+1)==pointCount?0:i+1);
    initialPos.rotate(rotation);
  }
  
  
}

void draw() {
  //clear screen
  if(tail) {
    noStroke();
    fill(0,0,0,10);
    rect(0,0,width,height);
  } else 
    background(0,0,0);
  
  //move all points
  for(int i=0;i<pointCount;i++) {
    points[i].move();
  }
  
  //draw all points
  strokeWeight(2);
  stroke(0,0,100);
  
  for(int i=0;i<pointCount;i++) {
    if(rainbow)stroke(i,100,100);
    points[i].draw(points);
  }
}

void keyPressed() {
  switch(key) {
    case 'c':
      println("Toggle colour mode");
      rainbow = !rainbow;
      break;
    case 't':
      println("Toggle tail mode");
      tail = !tail;
      break;
    default:
      println("Key "+key+" not assigned");
  }
}

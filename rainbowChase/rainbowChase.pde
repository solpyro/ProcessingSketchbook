int n, e = 9;
PVector[] p, pb;

void setup() {
  fullScreen();
  noCursor();

  background(0);
  colorMode(HSB, 200, 100, 100);

  initilisePoints();
  n = int(random(50, 200));
  p = new PVector[n];
  pb = new PVector[n];
  for (int i=0; i<n; i++) {
    p[i] = new PVector(
      random(width), 
      random(height)
      );
  }
  fill(0, 0, 0, 5);
}

void draw() {
  //update buffer with current positions
  for (int i=0; i<n; i++) {
    pb[i] = p[i].copy();
  }

  //move to new position & draw step;
  float totalDist = 0;
  for (int i=0; i<n; i++) {
    if (i+1==n) {
      stepTowards(p[i], pb[0]);
      stroke((i*200)/n, 100, 100, 10000/p[i].dist(pb[0]));
    } else {
      stepTowards(p[i], pb[i+1]);
      stroke((i*200)/n, 100, 100, 10000/p[i].dist(pb[i+1]));
    }

    line(pb[i].x, pb[i].y, p[i].x, p[i].y);
  
    totalDist += p[i].dist(pb[i]);
  }
  
  totalDist /= n;
  
  //fill(0,0,0);
  //noStroke();
  //rect(0,0,200,40);
  //fill(0,0,100);
  //stroke(0);
  //textSize(32);
  //text(round(totalDist*1000)/1000.0,5,35);
  
  if(totalDist<.5)
    initilisePoints();
}

void stepTowards(PVector point, PVector target) {
  point.mult(e).add(target).div(e+1);
}

void initilisePoints() {
  clear();
  n = int(random(50, 200));
  p = new PVector[n];
  pb = new PVector[n];
  for (int i=0; i<n; i++) {
    p[i] = new PVector(
      random(width), 
      random(height)
      );
  }
}

void keyPressed() {
  switch(key) {
  case ' ':
    initilisePoints();
  default:
    println("No acton for key '"+key+"'");
  }
}

PVector p;
int c = 0;
final float ROOT_HALF = pow(.5,.5);

void setup(){
  size(600,400);
}

void draw() {
  background(128);
  p = new PVector(133.3,133.3,0);
  
  dc(c,400);
  
  c++;
}

void dc(int o, float l) {
  turn(o*45);
  dcr(o,l,1);
}

void dcr(int o, float l, int s) {
  if(o==0)
    drawLine(l);
  else {
    dcr(o-1,l*ROOT_HALF,1);
    turn(s*-90);
    dcr(o-1,l*ROOT_HALF,-1);
  } 
}

void turn(int d) {
  p.z += d;
}

void drawLine(float l) {
  PVector s = new PVector(l,0);
  s.rotate(p.z*PI/180);
  line(p.x,p.y,p.x+s.x,p.y+s.y);
  p.add(s);
}

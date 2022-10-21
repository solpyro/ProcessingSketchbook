final int M_BOID = 0;
final int M_FISH = 1;
final int M_RAINBOWFISH = 2;
final int M_BIRD = 3;
final int M_LEAF = 4;

void drawBoid(PVector p, PVector d, float s, float ms, float vr, float ps, float a, color c) {
  switch(mode) {
  case M_FISH:
    drawFish(p, d, ms);
    break;
  case M_RAINBOWFISH:
    drawFish(
      p, d, ms, 
      color(
      ((vr-50)/50)*255, 
      ((ps-20)/20)*255, 
      ((a-.95)/.05)*255
      ));
    break;
  case M_BIRD:
    drawBird(p, d, ms);
    break;
  case M_LEAF:
    drawLeaf(
      p, d, ms,
      color(
        ((vr-50)/50)*255,
        ((ps-20)/20)*255,
        0
      )
    );
    break;
  case M_BOID:
  default:
    //draw the position
    fill(c);
    noStroke();
    circle(p.x, p.y, 10);

    //draw the vector
    stroke(c);
    PVector start = PVector.add(p, (PVector.mult(d, 5)));
    PVector endMS = PVector.add(start, (PVector.mult(d, 4*ms)));
    PVector endS = PVector.add(start, (PVector.mult(d, 4*s)));
    strokeWeight(2);
    line(start.x, start.y, endMS.x, endMS.y);
    strokeWeight(4);
    line(start.x, start.y, endS.x, endS.y);

    //draw the sense areas
    noFill();
    strokeWeight(2);
    circle(p.x, p.y, vr*2);
    circle(p.x, p.y, ps*2);
    
    //draw the agility struts
    PVector left = d.copy().rotate(HALF_PI).normalize().mult(5*(1+((a-.95)/.05)));
    PVector right = PVector.mult(left,-1).add(p);
    left.add(p);
    line(left.x, left.y, right.x, right.y);
    
  }
}
void drawFish(PVector p, PVector d, float ms) {
  drawFish(p, d, ms, color(110, 120, 140));
}
void drawFish(PVector p, PVector d, float ms, color c) {
  ms /= 3;

  push();
  translate(p.x, p.y);
  rotate(d.heading());

  noStroke();
  fill(c);

  ellipse(0, 0, 30*ms, 10*ms);
  triangle(-10*ms, 0, -20*ms, -5*ms, -20*ms, 5*ms);
  triangle(8*ms, 0, -2*ms, -10*ms, -2*ms, 10*ms);

  pop();
}

void drawBird(PVector p, PVector d, float ms) {
  push();
  translate(p.x, p.y);
  rotate(d.heading());
  scale(6/ms);

  noStroke();
  fill(140, 120, 110);

  triangle(10, 0, 5, -3, 5, 3);
  circle(5, 0, 6);

  ellipse(-5, 0, 20, 8);

  triangle(2, 0, 0, -12, 0, 12);
  triangle(-10, 0, 0, -12, 0, 12);
  triangle(0, -12, -8, -18, -4, -6);
  triangle(0, 12, -8, 18, -4, 6);

  triangle(0, 0, -25, -4, -25, 4);

  pop();
}

void drawLeaf(PVector p, PVector d, float ms, color c) {
  ms /= 3;

  push();
  translate(p.x, p.y);
  rotate(d.heading());

  noStroke();
  fill(c);

  triangle(24*ms, 0, -20*ms, -8*ms, -20*ms, 8*ms);
  triangle(18*ms, -12*ms, -20*ms, -8*ms, -20*ms, 8*ms);
  triangle(18*ms, 12*ms, -20*ms, -8*ms, -20*ms, 8*ms);

  triangle(6*ms, -30*ms, -20*ms, -8*ms, -10*ms, 0);
  triangle(-4*ms, -28*ms, -20*ms, -8*ms, -10*ms, 0);
  triangle(8*ms, -22*ms, -20*ms, -8*ms, -10*ms, 0);
  
  triangle(6*ms, 30*ms, -20*ms, 8*ms, -10*ms, 0);
  triangle(-4*ms, 28*ms, -20*ms, 8*ms, -10*ms, 0);
  triangle(8*ms, 22*ms, -20*ms, 8*ms, -10*ms, 0);

  //triangle(8*ms, 22*ms, -20*ms, 8*ms, -10*ms, 0);
  //triangle(8*ms, 22*ms, -20*ms, 8*ms, -10*ms, 0);

  pop();
}

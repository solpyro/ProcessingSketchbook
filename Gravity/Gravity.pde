//more than 1k and the VM can't handle it
int bodyCount = 1000;

int mode;
Body[] bodies;
int t, dt;
boolean drawLines, showTrail, drawStars;
PGraphics map;

void setup() {
  //initilise screen
  //size(1600, 900);
  fullScreen();
  noCursor();

  map = createGraphics(width, height);
  map.beginDraw();
  map.background(0);
  map.stroke(0, 255, 0);
  map.strokeWeight(0);
  map.endDraw();

  bodies = new Body[bodyCount];
  for (int i=0; i<bodyCount; i++) {
    bodies[i] = new Body(width, height);
  }

  t = 0;

  drawLines = false;
  showTrail = true;
  drawStars = true;
}

void draw() {
  //calculate clock;
  dt = millis()-t;
  t += dt;


  //clear the screen
  background(0);

  //draw trail
  if (showTrail) {
    image(map, 0, 0);
  }

  //calculate next positions
  //draw & move all bodies
  for (int i=0; i<bodyCount; i++) {
    bodies[i].updateHeading(bodies);
    if(drawStars)
      bodies[i].draw();
  }    

  map.beginDraw();
  map.noStroke();
  map.fill(0, 0, 0, 5);
  map.rect(0, 0, width, height);
  map.stroke(255, 255, 0);

  for (int i=0; i<bodyCount; i++) {
    if (drawLines && bodies[i].mass>0) {

      strokeWeight(0);
      //gravity vector
      PVector end = bodies[i].gravity.copy().mult(50).add(bodies[i].position);
      stroke(255, 0, 0);
      line(bodies[i].position.x, bodies[i].position.y, end.x, end.y);

      PVector v = bodies[i].velocity.copy().mult(50);
      end = PVector.add(v, bodies[i].position);
      if (v.mag()>(bodies[i].mass*PI*scale)/2) {
        stroke(255);
        line(bodies[i].position.x, bodies[i].position.y, end.x, end.y);
        v.normalize().mult(bodies[i].mass*PI*scale).div(2);
      }
      end = PVector.add(v, bodies[i].position);
      stroke(0);
      line(bodies[i].position.x, bodies[i].position.y, end.x, end.y);
    }

    bodies[i].drawTrail(dt, map);
    bodies[i].move(dt);
  }
  map.endDraw();
}

void keyPressed() {
  switch(key) {
  case ' ':
    drawLines = !drawLines;
    break;
  case 't':
    showTrail = !showTrail;
    break;
  case 's':
    drawStars = !drawStars;
    break;
  default:
    println("No acton for key '"+key+"'");
  }
}

PVector ToroidalDist(PVector from, PVector to) {
  PVector result = PVector.sub(to, from);
  if (abs(result.x) > width/2) {
    if (result.x>0)
      result.x -= width;
    else 
    result.x += width;
  }
  if (abs(result.y) > height/2) {
    if (result.y>0)
      result.y -= height;
    else 
    result.y += height;
  }
  return result;
}

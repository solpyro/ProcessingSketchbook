int boidCount = 100;

int mode;
Boid[] boids;

void setup() {
  //initilise screen
  //size(1600, 900);
  fullScreen();
  noCursor();

  mode = M_LEAF;

  //initilise boids 
  boids = new Boid[boidCount];
  for (int i=0; i<boidCount; i++) {
    boids[i] = new Boid(width, height);

    boidsViewRange += boids[i].viewRange;
    boidsPersonalSpace += boids[i].personalSpace;
    boidsMaxSpeed += boids[i].maxSpeed;
    boidsAgility += boids[i].agility;
  }

  boidsViewRange /= boids.length;
  boidsPersonalSpace /= boids.length;
  boidsMaxSpeed /= boids.length;
  boidsAgility /= boids.length;
}

void keyPressed() {
  switch(key) {
  case 'f':
    println("Enter fish mode");
    mode = M_FISH;
    break;
  case 'F':
    println("Enter rainboew fish mode");
    mode = M_RAINBOWFISH;
    break;
  case 'b':
    println("Enter bird mode");
    mode = M_BIRD;
    break;
  case 'l':
    println("Enter leaf mode");
    mode = M_LEAF;
    break;
  case ' ':
    println("Enter boid mode");
    mode = M_BOID;
    break;
  default:
    println("Mode '"+key+"' is not defined");
  }
}

void draw() {  
  //all birds plan their next step
  for (int i=0; i<boids.length; i++) {
    boids[i].flock(boids);
  }

  //clear the screen
  background(60);

  //all birds move
  for (int i=0; i<boids.length; i++) {
    boids[i].move();
    boids[i].draw();
  }

  //draw centre of mass
  if (mode == M_BOID)
    drawBoidCom();
}

float
  boidsMaxSpeed = 0, 
  boidsViewRange = 0, 
  boidsPersonalSpace = 0, 
  boidsAgility = 0;
  
void drawBoidCom() {
  PVector
    boidsComP = new PVector(), 
    boidsComV = new PVector();

  for (int i=0; i<boids.length; i++) {
    boidsComP.add(boids[i].position);
    boidsComV.add(PVector.mult(boids[i].direction, boids[i].speed));
    boidsViewRange += boids[i].viewRange;
    boidsPersonalSpace += boids[i].personalSpace;
    boidsMaxSpeed += boids[i].maxSpeed;
    boidsAgility += boids[i].agility;
  }

  boidsComP.div(boids.length);
  boidsComV.div(boids.length);
  boidsViewRange /= boids.length;
  boidsPersonalSpace /= boids.length;
  boidsMaxSpeed /= boids.length;
  boidsAgility /= boids.length;

  drawBoid(
    boidsComP, 
    boidsComV.normalize(null), 
    boidsComV.mag(), 
    boidsMaxSpeed, 
    boidsViewRange, 
    boidsPersonalSpace, 
    boidsAgility, 
    100);
}

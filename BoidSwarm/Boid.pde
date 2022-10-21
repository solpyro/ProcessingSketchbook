color cCrowded = color(205, 30, 0);
color cLonely = color(205, 100, 0);
color cHappy = color(30, 105, 0);

class Boid {
  PVector position;
  PVector direction;
  float speed;

  int viewRange;// = 100;
  int personalSpace;// = 20; 
  float agility;// = .95;
  float maxSpeed;// = 5;
  boolean lonely, crowded;

  Boid(int width, int height) {
    //apply attributes
    viewRange = int(random(50, 100));
    personalSpace = int(random(20, 40));
    agility = random(.95, .9999);
    maxSpeed = random(3, 5);

    //set position & speed
    position = new PVector(random(width), random(height));
    direction = PVector.random2D();
    speed = random(maxSpeed/4, maxSpeed);
  }

  void flock(Boid[] swarm) {
    lonely = true;
    crowded = false;

    int 
      nsCount = 0, 
      psCount = 0;
    PVector 
      swarmCom = new PVector(), 
      nsDirection = new PVector(), 
      psPressure = new PVector();
    float nsSpeed = 0;

    //find visible boids & close boids
    for (int i=0; i<swarm.length; i++) {
      swarmCom.add(swarm[i].position);

      if (swarm[i]==this) continue;

      float dist = swarm[i].position.dist(position);
      if (dist<viewRange) {
        //add vector to near swarm average
        nsCount++;
        nsDirection.add(swarm[i].direction);
        nsSpeed += swarm[i].speed;

        if (dist<=personalSpace) {
          psCount++;
          psPressure.add(swarm[i].position);
        }
      }
    }

    if (nsCount > 0) {
      lonely = false;

      //normalize swarm average
      nsSpeed = nsSpeed/nsCount;
      nsDirection.normalize();

      //apply swarm average to boid
      speed = min((agility*speed)+((1-agility)*nsSpeed), maxSpeed);
      direction.mult(agility).add(nsDirection.mult(1-agility)).normalize();
    }

    //adjust heading towards COM
    swarmCom.div(swarm.length).sub(position).normalize();
    direction.mult(agility).add(swarmCom.mult(1-agility)).normalize();

    if (psCount > 0) {
      crowded = true;

      //adjust heading to avoid other boids
      psPressure.div(psCount).sub(position).mult(-1);
      speed = min((agility*speed)+((1-agility)*(psPressure.mag()*maxSpeed/personalSpace)), maxSpeed);
      psPressure.normalize();
      direction.mult(agility*1.05).add(psPressure.mult(1-(agility/1.05))).normalize();
      
    }
  }

  void move() {
    //move based on current vectors
    position.add(PVector.mult(direction, speed));

    //toroidal space, although flocking won't calculate correctly at the edges
    if (position.x<0)
      position.x += width;

    if (position.x>width)
      position.x -= width;

    if (position.y<0)
      position.y += height;

    if (position.y>height)
      position.y -= height;
  }

  void draw() {
    drawBoid(
      position, 
      direction, 
      speed, 
      maxSpeed, 
      viewRange, 
      personalSpace,
      agility,
      lonely
      ? cLonely
      : crowded
      ? cCrowded
      : cHappy
      );
  }
}

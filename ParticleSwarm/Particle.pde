class Particle {
  //current 
  PVector position;
  PVector velocity;
  //future
  PVector plannedVelocity;
  
  //abilites
  int viewRange;// = 100;
  int personalSpace;// = 20; 
  float agility;// = .95;
  float maxSpeed;// = 5;
    
  public Particle(int width, int height) {    
    //set abilities
    viewRange = int(random(50, 100));
    personalSpace = int(random(20, 40));
    agility = random(.95, .9999);
    maxSpeed = random(3, 5);
    
    //set starting position & direction
    position = new PVector(random(width), random(height));
    velocity = PVector.random2D().mult(random(maxSpeed/4, maxSpeed));
    plannedVelocity = velocity.copy();
  }
  
  public void swarm(Particle[] swarm) {
    //imperitives
    // move towards nearest largest group
      // how can we determine different groups
      
    // align heading with neighbours  
      // need some way of averaging the heading of similar neioghbours and discounting outlier headings
      
    //result is future values for speed and direction
    
    //simple brain
    //- average all visible neighbours directions & speeds
    PVector accumulator = new PVector();
    int counter = 0;
    for(int i=0;i<swarm.length;i++) {
      if(swarm[i]!=this && inRange(swarm[i])) {
        accumulator.add(swarm[i].velocity);
        counter++;
      }
    }
    
    if(counter > 0)
      plannedVelocity = accumulator.div(counter);
      
    plannedVelocity.normalize().mult(maxSpeed);
  }
  
  private boolean inRange(Particle target) {
    return position.dist(target.position) <= viewRange;   
  }

  public void move() {
    //set new speed and position as current speed & direction
    //we should apply the agility here also
    velocity.set(plannedVelocity);
    
    //move based on current vectors
    position.add(velocity);
    
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

  public void draw() {
    switch (mode) {
      case M_PARTICLE:
        drawParticle(position);
        break;
      case M_TAIL:
        drawTail(this);
        break;
      default:
        drawWireframe(this);
    }
  }
}

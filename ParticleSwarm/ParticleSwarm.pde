int swarmCount = 100;
int mode;
Particle[] particles;

void setup() {
  //size(1600, 900);
  fullScreen(2);
  noCursor();
  frameRate(60);
  
  mode = M_TAIL;
  
  //initilise particles
  particles = new Particle[swarmCount];
  for(int i=0;i<swarmCount;i++) {
    particles[i] = new Particle(width, height);
  }
}

void keyPressed() {
  switch(key) {
    case '.':
      println("Point cloud mode");
      mode = M_PARTICLE;
      break;
    case 't':
      println("Point with tail");
      mode = M_TAIL;
      break;
    case ' ':
      println("Wireframe mode");
      mode = M_WIREFRAME;
      break;     
    default:
      println("Mode '"+key+"' is not defined");
  }
}

void draw() {  
  //all particles plan their next step
  for (int i=0; i<particles.length; i++) {
    particles[i].swarm(particles);
  }
  
  if(mode == M_TAIL) {
    noStroke();
    fill(60,60);
    rect(0,0,width,height);
  } else {
    //clear the screen
    background(60);
  }
  
  //all particles move
  for (int i=0; i<particles.length; i++) {
    particles[i].move();
    particles[i].draw();
  }
}

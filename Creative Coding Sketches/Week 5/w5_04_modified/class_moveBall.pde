/*
 * MovingBall class
 *
 * Represents a moving ball that moves in a single direction
 *
 */
class MovingBall {

  float x, y;        // position
  float tx, ty;      // target in x and y
  float step, inc;
  float radius;
  
  int numDirections;
  int direction;
  boolean bDisplay;

  // constructor
  // create a moving ball at the supplied position (x_, y_)
  MovingBall(float x_, float y_) {
    x = x_;
    y = y_;
    
    numDirections = 3;
    
    bDisplay = true;
    reset();
  }
  MovingBall() {
    x = 0;
    y = 0;
    
    numDirections = 3;
    
    bDisplay = false;
  }
  
  //release the brakes and start the engine
  void begin(float x_, float y_) {
    this.x = x_;
    this.y = y_;
    bDisplay = true;
    this.reset();
  }
  //stop the engine
  void recall() {
    bDisplay = false;
  }
  
  // run
  // calls move() followed by display()
  // 
  void run() {
    if(!bDisplay) return;
    
    this.move();
    this.display();
  }

  // move
  // move the ball in the desired direction
  //
  void move() {

    step -= inc;

    if (step < 0) {
      x = tx;
      y = ty;
      reset();
    }

    x = lerp(tx, x, step); 
    y = lerp(ty, y, step);

    checkBounds();
  }

  // checkBounds
  // checks that the ball is within the display window.
  // If it reaches the edge, move in the opposite direction
  void checkBounds() {
    if (x <= 0 || x >= width || y <= 0 || y >= height) {
      x = width/2;
      y = height/2;
      reset();
    }
  }


  void reset() {
    if(!bDisplay) return;
    
    step = 1;
    inc = random(0.01);
    radius = random(10, 50);
    float angleUnit = TWO_PI/numDirections; 
    direction = (int) random(numDirections);

    tx = x + radius*cos(direction * angleUnit);
    ty = y + radius*sin(direction * angleUnit);
  }

  // display method
  //
  //
  void display() {
    noStroke();
    rectMode(CENTER);
    fill(0, 30);
    rect(tx, ty, 10, 10);
    fill(255, 60);
    ellipse(x, y, 2, 2);
  }
  
  // update directions
  void updateDirections(int add) {    
    numDirections += add;
  }
}


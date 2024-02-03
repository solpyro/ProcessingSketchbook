class Point {
  PVector position;
  PVector velocity;
  int drawTarget;
  
  Point(float x, float y, float dx, float dy, int t) {
    position = new PVector(x,y);
    velocity = new PVector(dx,dy);
    drawTarget = t;
  }
  
  void move() {
    position.add(velocity);
    
    //check for wall collision
    if(position.x < 0 || position.x > width) {
      velocity.x = -velocity.x;
      if(position.x < 0)
        position.x = -position.x;
      else
        position.x = width - (position.x - width);
    }
    
    if(position.y < 0 || position.y > height) {
      velocity.y = -velocity.y;
      if(position.y < 0)
        position.y = -position.y;
      else
        position.y = height - (position.y - height);
    }
  }
  
  void draw(Point[] points) {
    line(position.x, position.y, points[drawTarget].position.x, points[drawTarget].position.y); 
  }
}

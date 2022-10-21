class Vector {
  int direction;
  float magnitude;
  
  Vector(int x, int y) {
    PVector v = new PVector(-x/sqrt(x^2+y^2+4),y/sqrt(x^2+y^2+4));
    //PVector v = new PVector(x,y);
    //PVector v = new PVector(-x,-y);
    //PVector v = new PVector(x,-y);
    //PVector v = new PVector(sin(x),cos(y));
    //PVector v = new PVector(y,1/x);
    //PVector v = new PVector(x+1,x+3);
    
    direction = round(v.heading()*180/PI);
    magnitude = v.mag();
  }
}

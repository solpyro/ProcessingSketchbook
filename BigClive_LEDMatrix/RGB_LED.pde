class RGB_LED implements LED {
  PVector position;
  float clock = 0;
  
  float speed;
  color cg, cb;
  
  RGB_LED(float x, float y) {
    speed = random(.8,1.2);
    position = new PVector(x,y);
    cb = color(0,30,100);
    cg = color(0,100,90);
  }
  
  float x() {
    return position.x;
  }
  
  float y() {
    return position.y;
  }
  
  boolean glow() {
    return true;
  }
  
  color glowColour() {
    return cg;
  }
  
  color bulbColour() {
    return cb;
  }
  
  void update(int dt) {
    clock += dt;
    cb = color((clock/90*speed)%100,30,100);
    cg = color((clock/90*speed)%100,100,90);
  }
}

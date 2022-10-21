class Flicker_LED implements LED {
  PVector position;
  float clock = 0;
  
  boolean on = true;
  color cg = color(#ff0000);
  color cbon = color(#ff4444);
  color cboff = color(#aa0000);
  
  int ton, toff;
  
  Flicker_LED(float x, float y) {
    position = new PVector(x,y);
    ton = int(random(50,120));
    toff = int(random(50,120));
  }
  
  float x() {
    return position.x;
  }
  float y() { 
    return position.y;
  }
  
  boolean glow() {
    return on;
  }
  
  color glowColour() {
    return cg;
  }
  color bulbColour() {
    return on?cbon:cboff;
  }
  
  void update(int dt) {
    clock += dt;
    if((on&&clock>=ton)||(!on&&clock>=toff)) {
      clock = 0;
      on = !on;
    }
      
  }
}

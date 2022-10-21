int xCount = 11, yCount = 6;
float xStep, yStep, ledScale=6;
LED[] leds;
int t, dt;

void setup() {  
  fullScreen();
  colorMode(HSB, 100);
  background(100, 0, 50);
  noStroke();

  xStep = width/(xCount+1);
  yStep = height/(yCount+1);  
  leds = new LED[xCount*yCount];

  for (int i=0; i<leds.length; i++) {
    if(random(1)>.5) {
    leds[i] = new RGB_LED(
      ((i%xCount)+1)*xStep, 
      ((i/xCount)+1)*yStep
      );
    } else {
    leds[i] = new Flicker_LED(
      ((i%xCount)+1)*xStep, 
      ((i/xCount)+1)*yStep
      );
    }
  }

  t = 0;
}

void draw() {
  dt = millis()-t;
  t += dt;

  background(#296e01);

  for (int i=0; i<leds.length; i++) {
    leds[i].update(10);//dt);
    color c = leds[i].glowColour();
    for (int j=5, k=30; leds[i].glow()&&j<50; j+=5, k-=2) {
      fill(c, j);
      circle(leds[i].x(), leds[i].y(), k*ledScale);
    }
    //gGlow.fill(leds[i].glowColour());
    //gGlow.circle(leds[i].x(), leds[i].y(), 30*ledScale);

    fill(leds[i].bulbColour());
    circle(leds[i].x(), leds[i].y(), 10*ledScale);
  }
  //filter( BLUR, 5 );
}

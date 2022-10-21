PGraphics image;
color cBg = color(255);
int counter = 1;
int states = 3;

void setup() {
  size(768, 768);
  
  colorMode(HSB,states,100,100);
  
  image = createGraphics(width, height);
  image.beginDraw();
  image.background(cBg);
  //draw first line
  for (int i=0; i<width; i++) {
    image.set(i, 0, colorFromInt(int(random(states))));
  }
  image.endDraw();
  image(image, 0, 0);
}

void draw() {
  image.beginDraw();
  for (int i=0; i<width; i++) {
    int prev = intFromColor(image.get((i-1<0)?width-1:i-1, counter-1));
    int curr = intFromColor(image.get(i, counter-1));
    int next = intFromColor(image.get((i+1<width)?i+1:0, counter-1));
    
    if (prev == (curr+1)%states)
      image.set(i, counter, colorFromInt(prev));
    else if (next == (curr+1)%states)
      image.set(i, counter, colorFromInt(next));
    else
      image.set(i, counter, image.get(i, counter-1));
  }
  image.endDraw();
  image(image, 0, 0);

  if (++counter==height) {
    noLoop();
  }
}

color colorFromInt(int num) {  
  return color(num,100,100);
}

int intFromColor(color col) {
  return round(hue(col));
}
final color LIVE = color(0, 255, 0, 100), 
            NEW = color(255, 255, 255, 100),
            DEAD = color(0, 0, 0, 0);

PGraphics image, image_buffer, 
  interest, interest_buffer, interest_novel;

boolean showColony = true, 
  showInterest = true, 
  showStats = false;

int generation = 0;

void setup() {

  //size(1000,1000);
  fullScreen();
  noCursor();

  image_buffer = createGraphics(width, height);
  image_buffer.beginDraw();

  //seed the buffer
  for (int i=0; i<int((width*height)*0.2); i++)
    image_buffer.set(
      int(random(width)), 
      int(random(height)), 
      LIVE
      ); 

  image_buffer.endDraw();

  interest_buffer = createGraphics(width, height);
  interest_buffer.beginDraw();
  interest_buffer.background(LIVE);
  interest_buffer.endDraw();
  
  interest_novel = createGraphics(width, height);
  interest_novel.beginDraw();
  interest_novel.background(DEAD);
  interest_novel.endDraw();

  image = createGraphics(width, height);
  image.beginDraw();
  image.image(image_buffer, 0, 0);
  image.endDraw();

  interest = createGraphics(width, height);
  interest.beginDraw();
  interest.image(interest_buffer, 0, 0);
  interest.endDraw();

  //draw 0th generation
  drawFrame();
}

void draw() {  
  //calculate next generation
  image_buffer.beginDraw();
  interest_buffer.beginDraw();
  interest_buffer.clear();
  for (int x = 0; x<width; x++) {
    for (int y = 0; y<height; y++) {
      if (isInteresting(x, y))
        setCellState(x, y);
    }
  }
  image_buffer.endDraw();
  interest_buffer.endDraw();

  generation++;

  interest_novel.beginDraw();
  interest_novel.clear();
  interest_novel.loadPixels();
  for(int i=0;i<interest_novel.pixels.length;i++) {
    if(interest_buffer.pixels[i]==LIVE && interest.pixels[i]!=LIVE)
      interest_novel.pixels[i] = NEW;
  }
  interest_novel.updatePixels();
  interest_novel.endDraw();
  
  
  interest.beginDraw();
  interest.clear();
  interest.image(interest_buffer, 0, 0);
  interest.endDraw();

  image.beginDraw();
  image.clear();
  image.image(image_buffer, 0, 0);
  image.endDraw();

  //draw nth generation
  drawFrame();
  
  if(count(interest_novel, NEW)==0 && generation>2)
    noLoop();
}

void keyPressed() {
  switch(key) {
  case 'c':
    showColony = !showColony;
    break;
  case 'i':
    showInterest = !showInterest;
    break;
  case 's':
    showStats = !showStats;
    break;
  default:
    println("no action for key '"+key+"'");
  }
}

void drawFrame() {
  clear();
  background(0);

  if (showInterest) {
    image(interest, 0, 0);
    image(interest_novel, 0, 0);
    fill(color(0, 128));
    rect(0, 0, width, height);
  }
  if (showColony)
    image(image, 0, 0);

  if (showStats) {
    textSize(16);
    fill(255);
    text("Generation: "+generation, 16, 32);
    text("Population: "+count(image, LIVE), 16, 50);
    text("Interested: "+count(interest, LIVE), 16, 68);
    text("Novel: "+count(interest_novel, NEW), 16, 86);
    text("Framerate: "+nf(frameRate,0,1), 16, 104);
  }
}
boolean isInteresting(int x, int y) {
  return interest.get(x, y)==LIVE;
}

void setCellState(int x, int y) {
  int n = countNeighbours(x, y);
  boolean i = getState(x, y)==1;

  //B3/S23
  if (i && !(n==2 || n==3)) {
    image_buffer.set(x, y, DEAD);
    setInterest(x, y);
  }
  if (!i && n==3) {
    image_buffer.set(x, y, LIVE);
    setInterest(x, y);
  }
}

int countNeighbours(int x, int y) {
  int count = 0;
  for (int _x=-1; _x<2; _x++) {
    for (int _y=-1; _y<2; _y++) {
      if (_x!=0||_y!=0)
        count += getState(x+_x, y+_y);
    }
  }
  return count;
}

int getState(int x, int y) {
  x = wrap(x, width);
  y = wrap(y, height);

  if (image.get(x, y)==LIVE)
    return 1;

  return 0;
}

void setInterest(int x, int y) {
  for (int _x=-1; _x<2; _x++) {
    for (int _y=-1; _y<2; _y++) {
      interest_buffer.set(
        wrap(x+_x, width), 
        wrap(y+_y, height), 
        LIVE
        );
    }
  }
}

int wrap(int n, int limit) {
  if (n<0) {
    return limit-1;
  }
  while (n>=limit) {
    n-=limit;
  }
  return n;
}

int count(PGraphics image, color target) {
  int count = 0;
  for(int i=0;i<image.pixels.length;i++) {
    if(image.pixels[i]==target)count++;
  }
  return count;
}

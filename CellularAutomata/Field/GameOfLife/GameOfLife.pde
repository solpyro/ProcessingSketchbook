PGraphics image;
color cColor = color(0,255,0);
color cBg = color(0);

void setup() {
  size(512, 512);
  
  image = createGraphics(width,height);
  
  //seed field
  image.beginDraw();
  image.background(cBg);
  //*/ Random seeding
  //int seedCount = (width*height)/int(pow(2,5)); //sparse
  int seedCount = (width*height)/int(pow(2,4)); //medium
  //int seedCount = (width*height)/int(pow(2,3)); //dense
  for(int i=0;i<seedCount;i++) {
    image.set(round(random(width)),round(random(height)),cColor);
  }
  //*/
  /*/ Simple examples
  cColor = color(0);
  cBg = color(255);
  //PImage preset = loadImage("Example_512_512_0_255.gif"); //Example shapes
  PImage preset = loadImage("GosperGun_512_512_0_255.gif");
  image.background(cBg);
  image.image(preset,0,0);
  //*/
  /*/ Infinite block layers
  cColor = color(255);
  cBg = color(0,128,255);
  //PImage preset = loadImage("BlockLayer1_512_512_0_0-128-255.gif");
  //PImage preset = loadImage("BlockLayer2_512_512_0_0-128-255.gif");
  PImage preset = loadImage("BlockLayer3_512_512_0_0-128-255.gif");
  image.background(cBg);
  image.image(preset,0,0);
  //*/
  /*/ Interesting patterns
  cColor = color(0,255,0);
  cBg = color(0);
  //PImage preset = loadImage("Acorn_512_512_0-255-0_0.gif");
  //PImage preset = loadImage("Diehard_512_512_0-255-0_0.gif");
  PImage preset = loadImage("R-pentomino_512_512_0-255-0_0.gif");
  image.background(cBg);
  image.image(preset,0,0);
  //*/
  
  image.endDraw();
  image(image,0,0);  
}

void draw() {
  PGraphics temp = createGraphics(width, height);
  temp.beginDraw();
  for(int i=0;i<width;i++) {
    for(int j=0;j<width;j++) {
      int n = countNeighbours(i,j);
      
      if(n<2||n>3)
        temp.set(i,j,cBg);
      else if(n==3)
        temp.set(i,j,cColor);
      else
        temp.set(i,j,image.get(i,j));
    }
  }
  temp.endDraw();
  
  image.beginDraw();
  image.image(temp,0,0);
  image.endDraw();
  
  image(image,0,0);  
}

int countNeighbours(int x, int y) {
  int i = 0;
  
  if(image.get(x, (y-1<0)?height-1:y-1)==cColor)
    i++;
  if(image.get((x+1==width)?0:x+1, (y-1<0)?height-1:y-1)==cColor)
    i++;
  if(image.get((x+1==width)?0:x+1, y)==cColor)
    i++;
  if(image.get((x+1==width)?0:x+1, (y+1==height)?0:y+1)==cColor)
    i++;
  if(image.get(x, (y+1==height)?0:y+1)==cColor)
    i++;
  if(image.get((x-1<0)?width-1:x-1, (y+1==height)?0:y+1)==cColor)
    i++;
  if(image.get((x-1<0)?width-1:x-1, y)==cColor)
    i++;
  if(image.get((x-1<0)?width-1:x-1, (y-1<0)?height-1:y-1)==cColor)
    i++;
  
  return i;
}
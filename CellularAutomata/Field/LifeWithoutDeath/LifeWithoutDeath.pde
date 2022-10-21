PGraphics image;
color cColor = color(255);
color cBg = color(0);


void setup() {
  size(512, 512);
  
  image = createGraphics(width,height);
  
  //seed field
  image.beginDraw();
  image.background(cBg);
  /*/ Random seeding
  int seedCount = (width*height)/int(pow(2,7)); //sparse
  //int seedCount = (width*height)/int(pow(2,6)); //medium
  //int seedCount = (width*height)/int(pow(2,5)); //dense
  //int seedCount = (width*height)/int(pow(2,4)); //extra dense
  for(int i=0;i<seedCount;i++) {
    image.set(round(random(width)),round(random(height)),cColor);
  }
  //*/
  //*/ Preconfigured
  //PImage preset = loadImage("Ladder.gif");
  PImage preset = loadImage("LadderFrom8.gif");
  //add some curcuits...
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
      
     if(n==3)
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
PGraphics image;
color cExcited = color(255);
color cRefactory = color(128);
color cResting = color(0);
boolean isMooreNeigbourhood = true;


void setup() {
  size(512, 512);
  
  image = createGraphics(width,height);
  
  //seed field
  image.beginDraw();
  image.background(cResting);
  //*/ Random seeding
  int seedCount = (width*height)/int(pow(2,12)); //sparse
  //int seedCount = (width*height)/int(pow(2,11)); //medium
  //int seedCount = (width*height)/int(pow(2,10)); //dense
  
  for(int i=0;i<seedCount;i++) {
    image.set(round(random(width)),round(random(height)),cExcited);
  }
  //*/
  /*/ Preconfigured
  //PImage preset = loadImage("Spiral.bmp");
  PImage preset = loadImage("Windmill.bmp");
  image.image(preset,0,0);
  //*/
  
  image.endDraw();
  image(image,0,0);  
}

void draw() {
  PGraphics temp = createGraphics(width, height);
  temp.beginDraw();
  temp.background(cResting);
  for(int i=0;i<width;i++) {
    for(int j=0;j<width;j++) {
      if(image.get(i,j)==cExcited) {
        temp.set(i,j,cRefactory);
      } else if(image.get(i,j)==cRefactory) {
        temp.set(i,j,cResting);
      } else if(countExcitedNeighbours(i,j,isMooreNeigbourhood)>0) {
        temp.set(i,j,cExcited);        
      }
    }
  }
  temp.endDraw();
  
  image.beginDraw();
  image.image(temp,0,0);
  image.endDraw();
  
  image(image,0,0);  
}

int countExcitedNeighbours(int x, int y) {
  return countExcitedNeighbours(x,y,false);
}

int countExcitedNeighbours(int x, int y, boolean isMooreNeighbour) {
  int i = 0;
  
  //calculate vonNeumann neighbours
  if(image.get(x, (y-1<0)?height-1:y-1)==cExcited)
    i++;
  if(image.get((x+1==width)?0:x+1, y)==cExcited)
    i++;
  if(image.get(x, (y+1==height)?0:y+1)==cExcited)
    i++;
  if(image.get((x-1<0)?width-1:x-1, y)==cExcited)
    i++;
  if(isMooreNeighbour) {
    //calculate additional Moore neighbours
    if(image.get((x+1==width)?0:x+1, (y-1<0)?height-1:y-1)==cExcited)
      i++;
    if(image.get((x+1==width)?0:x+1, (y+1==height)?0:y+1)==cExcited)
      i++;
    if(image.get((x-1<0)?width-1:x-1, (y+1==height)?0:y+1)==cExcited)
      i++;
    if(image.get((x-1<0)?width-1:x-1, (y-1<0)?height-1:y-1)==cExcited)
      i++;
  }
  
  return i;
}
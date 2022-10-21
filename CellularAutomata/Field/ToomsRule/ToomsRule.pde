PGraphics image;
color cPve = color(0, 155, 0);
color cNve = color(255, 0, 0);

void setup() {
  size(512, 512);

  image = createGraphics(width, height);

  //seed field

  image.beginDraw();

  //Random seeding

  for (int i=0; i<width; i++) {
    for (int j=0; j<height; j++) {
      image.set(i, j, (random(1)>.5)?cPve:cNve);
    }
  }

  image.endDraw();
  image(image, 0, 0);
}

void draw() {
  PGraphics temp = createGraphics(width, height);
  temp.beginDraw();
  for (int i=0; i<width; i++) {
    for (int j=0; j<height; j++) {
      temp.set(i,j,(calculatePolarity(i,j)>0)?cPve:cNve);
    }
  }
  temp.endDraw();
  
  image.beginDraw();
  image.image(temp,0,0);
  image.endDraw();
  
  image(image,0,0);  
}

int calculatePolarity(int x, int y) {
  int i = 0;
  int xe = (x+1)==width?0:x+1;
  int yn = (y-1)<0?height-1:y-1;
  
  i += (image.get(x,y)==cPve)?1:-1;
  i += (image.get(x,yn)==cPve)?1:-1;
  i += (image.get(xe,y)==cPve)?1:-1;
  
  return i;
}
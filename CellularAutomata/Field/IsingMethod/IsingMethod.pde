PGraphics image;
color cPve = color(145, 156, 53);
color cNve = color(73, 92, 35);
color cZero = color((145+73)/2, (156+92)/2, (53+35)/2);


void setup() {
  size(768,768);

  image = createGraphics(width, height);

  //seed field

  image.beginDraw();
  image.background(cZero);

  //Random seeding
  //*/
  //int nSeedCount = (width*height)/int(pow(2,5)); //fine grain
  //int nSeedCount = (width*height)/int(pow(2,7)); //medium grain
  int nSeedCount = (width*height)/int(pow(2,9)); //coarse grain
  for (int i=0; i<nSeedCount; i++) {
    int x = int(random(width));
    int y = int(random(height));
    if(image.get(x,y)!=cZero)
      i--;
    else
      image.set(x, y, (random(1)>.5)?cPve:cNve);
  }
  //*/
  
  image.endDraw();
  image(image, 0, 0);
}

void draw() {
  PGraphics temp = createGraphics(width, height);
  temp.beginDraw();
  for (int i=0; i<width; i++) {
    for (int j=0; j<height; j++) {
      int v = calculatePolarity(i,j);
      temp.set(i,j,(v>0)?cPve:(v<0)?cNve:cZero);
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
  int xw = (x-1)<0?width-1:x-1;
  int ys = (y+1)==height?0:y+1;
  
  i += (image.get(x,y)==cPve)?1:(image.get(x,y)==cNve)?-1:0;
  i += (image.get(x,yn)==cPve)?1:(image.get(x,yn)==cNve)?-1:0;
  i += (image.get(xe,y)==cPve)?1:(image.get(xe,y)==cNve)?-1:0;
  i += (image.get(x,ys)==cPve)?1:(image.get(x,ys)==cNve)?-1:0;
  i += (image.get(xw,y)==cPve)?1:(image.get(xw,y)==cNve)?-1:0;
  
  return i;
}
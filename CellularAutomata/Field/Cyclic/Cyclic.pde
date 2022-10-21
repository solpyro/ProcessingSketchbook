PGraphics image;
color cBg = color(255);
int states = 25;//16-25

void setup() {
  size(768, 768);
  
  colorMode(HSB,states,100,100);
  
  image = createGraphics(width, height);
  image.beginDraw();
  image.background(cBg);
  //fill field
  for (int i=0; i<width; i++) {
    for (int j=0; j<height; j++) {
      image.set(i, j, colorFromInt(int(random(states))));
    }
  }
  image.endDraw();
  image(image, 0, 0);
}

//void keyPressed() {
void draw() {
  PGraphics temp = createGraphics(width, height);
  temp.beginDraw();
  for (int i=0; i<width; i++) {
    for(int j=0;j<height; j++) {
      int curr = intFromColor(image.get(i, j));
      
      int n = intFromColor(image.get(i, j-1));
      int ne= intFromColor(image.get(i+1, j-1));
      int e = intFromColor(image.get(i+1, j));
      int se= intFromColor(image.get(i+1, j+1));
      int s = intFromColor(image.get(i, j+1));
      int sw= intFromColor(image.get(i-1, j+1));
      int w = intFromColor(image.get(i-1, j));
      int nw= intFromColor(image.get(i-1, j-1));
      
      if (n == (curr+1)%states)
        temp.set(i, j, colorFromInt(n));
      else if (ne == (curr+1)%states)
        temp.set(i, j, colorFromInt(ne));
      else if (e == (curr+1)%states)
        temp.set(i, j, colorFromInt(e));
      else if (se == (curr+1)%states)
        temp.set(i, j, colorFromInt(se));
      else if (s == (curr+1)%states)
        temp.set(i, j, colorFromInt(s));
      else if (sw == (curr+1)%states)
        temp.set(i, j, colorFromInt(sw));
      else if (w == (curr+1)%states)
        temp.set(i, j, colorFromInt(w));
      else if (nw == (curr+1)%states)
        temp.set(i, j, colorFromInt(nw));
      else
        temp.set(i,j,image.get(i, j));
    }
  }
  temp.endDraw();
  
  image.beginDraw();
  image.image(temp,0,0);
  image.endDraw();
  
  image(image, 0, 0);
}
/*
void draw() {
  
  image(image, 0, 0);
}
*/
color colorFromInt(int num) {  
  return color(num,100,100);
}

int intFromColor(color col) {
  return round(hue(col));
}
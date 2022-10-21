PImage img;

color[] colors = {}, sColors;
int[] count = {}, sCount;
int pxCount = 0;//, colCount;

void setup() {
  img = loadImage("moonwalk.jpg");
  size(640,360);
  background(img);
  
  for(int i=0;i<img.width;i++) {
    for(int j=0;j<img.height;j++) {
      color px = img.get(i,j);
      int cPtr = colorIndex(px,colors);
      if(cPtr>=0) {
        count[cPtr]++;
      } else {
        colors = append(colors,px);
        count = append(count,1);
      }
    }
  }
  fill(#ffffff);
  ellipse(width/2,height/2,200,200);
  
  println("colors:"+colors.length);
  sortColors();
  println("colors:"+colors.length);
}

void draw() {
  for(int i=0;i<colors.length;i++) {
    //colCount = 0;
    stroke(colors[i]);
    for(int j=0;j<count[i];j++) {
      point(pxCount%width,pxCount/width);
      //print("("+pxCount%width+","+pxCount/width+"),");
      pxCount++;
      //colCount++;
    }
    //println(count[i]);
  }
  noLoop();
}

int colorIndex(color needle,color[] haystack) {
  for(int i=0;i<haystack.length;i++) {
    if(haystack[i]==needle)
      return i;
  }
  return -1;
}

void sortColors() {
  
  //sort by saturation?
  int num = 0;
  sColors = new color[colors.length];
  sCount = new int[colors.length];
  for (int i = 0; i < 255; i++){
    for(int j =0; j < colors.length; j++){
      if (int(saturation(colors[j])) == i) {
        sColors[num] = colors[j];
        sCount[num] = count[j];
        num++;
      }
    }
  }
  colors = sColors;
  count = sCount;
  
  //sort by brightness?
  num = 0;
  sColors = new color[colors.length];
  sCount = new int[colors.length];
  for (int i = 0; i < 255; i++){
    for(int j =0; j < colors.length; j++){
      if (int(brightness(colors[j])) == i) {
        sColors[num] = colors[j];
        sCount[num] = count[j];
        num++;
      }
    }
  }
  colors = sColors;
  count = sCount;
  
  //sort by hue
  num = 0;
  sColors = new color[colors.length];
  sCount = new int[colors.length];
  for (int i = 0; i < 255; i++){
    for(int j =0; j < colors.length; j++){
      if (int(hue(colors[j])) == i) {
        sColors[num] = colors[j];
        sCount[num] = count[j];
        num++;
      }
    }
  }
  colors = sColors;
  count = sCount;
}
PImage src, out;
PVector targetCol;
color col;

void setup() {
  src = loadImage("amélie.jpg");

  size(242, 300);
  col = 0xFFFF0099;
  //targetCol = ratio(col);
  //out = tintPic(src,targetCol);
  tint(col);
  image(src, 0, 0);
}

PGraphics tintPic(PGraphics g, PVector t) {
  PGraphics o = createGraphics(g.width, g.height);
  for (int i=0; i<g.pixels.length; i++) {
    //g.pixels[i].set(
  }
  return o;
}

PVector ratio(color c) {
  return new PVector(
    red(c)/255, 
    green(c)/255, 
    blue(c)/255
    );
}

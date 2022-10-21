void setup() {
  size(512,512);
  background(#ffffff);
  fill(#000000,20);
  noStroke();
  rectMode(RADIUS);
}

void draw() {
  drawCircles(width/2,height/2,min(width,height)/2,6);
  noLoop();
}

void drawCircles(int x, int y, int r, int depth) {
  rect(x,y,r,r);
  if (depth>0) {
    drawCircles(x-r/2, y, r/2, depth-1);
    drawCircles(x+r/2, y, r/2, depth-1);
    drawCircles(x, y-r/2, r/2, depth-1);
    drawCircles(x, y+r/2, r/2, depth-1);
  }
}

String[][] images = {
  //{"findingnemo", "jpg"}, 
  //{"homealone", "jpg"}, 
  //{"maleficent", "jpg"}, 
  //{"thematrix", "jpg"}, 
  //{"jurassicpark", "jpg"}, 
  //{"2001aspaceoddyssey", "png"}, 
  //{"aclockworkorange", "png"}, 
  //{"pulpfiction", "jpg"}, 
  //{"scarface", "jpg"}, 
  //{"avatar", "jpg"}, 
  //{"titanic", "png"}, 
  //{"thesilenceofthelambs", "jpg"}, 
  //{"shaunofthedead", "jpg"},
  //{"1989", "png"},
  //{"aladdinsane", "jpg"},
  //{"currents", "png"},
  //{"elvispresley", "jpg"},
  //{"londoncalling", "jpg"},
  {"amélie", "jpg"},
  {"bladerunner", "png"},
  {"ettheextraterrestrial","jpg"},
  {"jaws","jpg"},
  {"minions","jpg"},
  {"starwars","jpg"},
  {"thelegomovie","jpg"},
};
int i;

void setup() {
  size(500, 150);
  i = 0;
  fill(0, 128, 0);
}

void draw() {
  String[] image = images[i];
  PImage in = loadImage(image[0]+"."+image[1]);

  PGraphics row = pixelateRow(in);
  PGraphics col = pixelateCol(in);

  row.save("data/"+image[0]+"_row.jpg");
  col.save("data/"+image[0]+"_col.jpg");
  pixelatePlaid(row, col).save("data/"+image[0]+"_plaid.jpg");

  if (++i<images.length) {
    rect(0, 0, i*(width/images.length), height);
  } else {
    exit();
  }
}

PGraphics pixelateRow(PImage pIn) {
  int w = pIn.width;
  int h = pIn.height;
  PGraphics pg = createGraphics(w, h);
  pg.beginDraw();
  pg.noStroke();

  for (int y=0; y<h; y++) {
    PImage row = pIn.get(0, y, w, 1);
    pg.fill(averageColor(row.pixels));
    pg.rect(0, y, w, 1);
  }

  pg.endDraw();
  return pg;
}
PGraphics pixelateCol(PImage pIn) {
  int w = pIn.width;
  int h = pIn.height;
  PGraphics pg = createGraphics(w, h);
  pg.beginDraw();
  pg.noStroke();

  for (int x=0; x<w; x++) {
    PImage row = pIn.get(x, 0, 1, h);
    pg.fill(averageColor(row.pixels));
    pg.rect(x, 0, 1, h);
  }

  pg.endDraw();
  return pg;
}

PGraphics pixelatePlaid(PGraphics p1, PGraphics p2) {
  int w = p1.width;
  int h = p1.height;
  PGraphics pg = createGraphics(w, h);

  pg.beginDraw();
  pg.noStroke();
  for (int x=0; x<w; x++) {
    for (int y=0; y<h; y++) {
      if ((x+y)%2==0)
        pg.set(x, y, p1.get(x, y));
      else
        pg.set(x, y, p2.get(x, y));
    }
  }
  
  return pg;
}

color averageColor(color[] arr) {
  int r=0, g=0, b=0;

  for (color c : arr) {
    r += c >> 020 & 0xFF;
    g += c >> 010 & 0xFF;
    b += c        & 0xFF;
  }

  r /= arr.length;
  g /= arr.length;
  b /= arr.length;

  return color(r, g, b);
}

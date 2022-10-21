Vector[][] field;

void setup() {
  size(500, 500);
  colorMode(HSB, 360, 100, 100);
  
  //create matrix
  field = new Vector[width][height];
  for(int x = 0; x<width; x++) {
    for(int y = 0; y<height; y++) {
      field[x][y] = new Vector(x,y);
    }
  }
  
  //paint canvas
  for(int x = 0; x<width; x++) {
    for(int y = 0; y<height; y++) {
      set(x,y,color(field[x][y].direction, 100, 100));
    }
  }
}

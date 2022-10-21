int counter = 0;
int total;
color black = color(0x0);
color grey = color(0x99);
color white = color(0xFF);
Coord offset = new Coord(0,1000000000);

void setup() {
  //create canvas
  size(500,500);
  background(grey);
  
  total = width*height;
  
  while(counter<total) {
    Coord coord = getCoords(counter);
    Coord tupperCoord = coord.Add(offset);
    boolean isBlack = tupper(tupperCoord.x, tupperCoord.y);
    set(coord.x,height-(coord.y+1),isBlack?black:white);
    //println(coord.x, coord.y, isBlack);
    
    counter += 1;
  }
}

Coord getCoords(int counter) {
  return new Coord(
    counter%width,
    floor(counter/width)
  );
}

boolean tupper(int x, int y) {
  return (0.5 < floor((floor(y/17)*pow(2,(-17*x)-(y%17)))%2));
}

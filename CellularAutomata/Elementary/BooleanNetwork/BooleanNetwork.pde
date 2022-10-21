Network network;
int _row;
final color[] _colours = {
  color(126),
  color(0),
  color(255)
};

void setup() {
  size(256,512);
  background(_colours[0]);
  
  initiliseNetwork();
}

void draw() {
  if(_row<height) {
    drawLine(_row, network.updateBuffer());
    _row++;
  } else {
    background(_colours[0]);
    initiliseNetwork();
  }
}

void drawLine(int row, boolean[] buffer) {
  for(int i=0;i<buffer.length;i++) {
    set(i,row,_colours[buffer[i]?2:1]);
  }
}
void initiliseNetwork() {
  _row = 0;
  network = new Network(width, 16);
  //max 30 since we're using int
  
  drawLine(_row, network.getBuffer());
  _row++;
}

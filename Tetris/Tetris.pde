final color
  COL_BG = color(255),
  COL_T = color(0,255,255);

color[] grid = new color[10*20];
int 
  gridWidth = 10,
  score = 0,
  currentPosition = 4, //for demonstration
  currentRotation = 0;
char currentShape;
Tetromino tetromino;


void setup() {
  size(440,840);
  //noStroke();
  
  tetromino = new Tetromino(gridWidth);
  currentShape = tetromino.randomShape();
  
  drawTetromino();
}

void draw() {
  background(255);
  
  drawGrid();
  drawScore();
  
}

void drawGrid() {
  //draw each square as 20x20px 
  for(int n=0;n<grid.length;n++) {
    int _x = 20+((n%gridWidth)*20);
    int _y = 20+(floor(n/gridWidth)*20);
    fill(grid[n]);
    rect(_x,_y,_x+20,_y+20);
  }
}

void drawScore() {
  //draw "Score: "+score
}

void drawTetromino() {
  //draws the L first roation
  for(int n : tetromino.getShape(currentShape)[currentRotation]) {
    grid[n] = COL_T;
  }
}
void undrawTetromino() {
  for(int n : tetromino.L[currentRotation]) {
    grid[n] = COL_BG;
  }
}

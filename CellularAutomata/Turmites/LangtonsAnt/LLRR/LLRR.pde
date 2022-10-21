final color COL1 = color(225, 0, 0), 
            COL2 = color(0, 225, 0), 
            COL3 = color(0, 0, 225), 
            COL4 = color(0, 0, 0);
            
PVector ant; 

void setup() {
  //size(500,500);
  fullScreen();
  noCursor();
  background(COL4);
  
  ant  = new PVector(
    int(width/2), 
    int(height/2),
    0
  );  
}

void draw() {
  turn();
  flip();
  move();
}

void turn() {
  if(get(int(ant.x),int(ant.y))==COL3 ||
     get(int(ant.x),int(ant.y))==COL4) {
    //clockwise
    ant.z++;
    if(ant.z==4)
      ant.z=0;
  } else {
    //anticlockwise
    ant.z--;
    if(ant.z<0)
      ant.z=3;
  }
}

void flip() {
  int col = get(int(ant.x),int(ant.y));
  if(col == COL1)
      set(int(ant.x),int(ant.y),COL2);
  if(col == COL2)
      set(int(ant.x),int(ant.y),COL3);
  if(col == COL3)
      set(int(ant.x),int(ant.y),COL4);
  if(col == COL4)
      set(int(ant.x),int(ant.y),COL1);
}

void move() {
  switch(int(ant.z)) {
    case 0:
      ant.x++;
      break;
    case 1:
      ant.y++;
      break;
    case 2:
      ant.x--;
      break;
    case 3:
      ant.y--;
      break;
    default:
      println("Direction '"+int(ant.z)+"' is not real");
  }
  
  if(ant.x<0)
    ant.x=width-1;
  if(ant.x>=width)
    ant.x-=width;
    
  if(ant.y<0)
    ant.y=height-1;
  if(ant.y>=height)
    ant.y-=height;
}

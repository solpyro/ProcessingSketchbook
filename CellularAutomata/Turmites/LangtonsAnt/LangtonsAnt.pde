final color ON = color(0, 255, 0), 
            OFF = color(0, 0, 0);
            
PVector ant; 

void setup() {
  //size(500,500);
  fullScreen();
  noCursor();
  background(OFF);
  
  ant  = new PVector(
    int(random(width)), 
    int(random(height)),
    0
  );  
}

void draw() {
  turn();
  flip();
  move();
}

void turn() {
  if(get(int(ant.x),int(ant.y))==ON) {
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
  if(get(int(ant.x),int(ant.y))==ON)
    set(int(ant.x),int(ant.y),OFF);
  else
    set(int(ant.x),int(ant.y),ON);
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

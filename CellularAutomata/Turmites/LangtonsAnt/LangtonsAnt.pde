PGraphics image;
color cBg, cColor;
int seedCount = 500;
int ant_x, ant_y, ant_d;


void setup() {
  size(500,500);
  
  //initilise ant
  ant_x = width/2;
  ant_y = height/2;
  ant_d = 0; //0=n,1=e,2=s,3=w
  
  //initilise colours
  cBg = color(255);
  cColor = color(0);
  
  //create initial image
  image = createGraphics(width,height);
  
  image.beginDraw();
  image.background(cBg);
  /*
  //seed with random data
  for(int i=0;i<seedCount;i++) {
    image.set(round(random(width)),round(random(height)),cColor);
  }
  */
  image.endDraw();
  image(image,0,0);
    
}

void draw() {
  //move ant
  color temp = image.get(ant_x,ant_y);
  //turn ant (w==r, b==l)
  ant_d += (temp==cBg)?1:-1;
  if(ant_d<0)ant_d+=4;
  ant_d %= 4;
  //change cell
  image.beginDraw();
  image.set(ant_x,ant_y,(temp==cBg)?cColor:cBg);
  image.endDraw();
  //move ant
  switch(ant_d) {
    case 0://north
      ant_y-=1;
      break;
    case 1://east
      ant_x+=1;
      break;
    case 2://south
      ant_y+=1;
      break;
    case 3://west
      ant_x-=1;
      break;
  }
  
  //map grid onto a torus
  if(ant_x<0)ant_x=width-1;
  if(ant_x==width)ant_x=0;
  if(ant_y<0)ant_y=height-1;
  if(ant_y==height)ant_y=0;
  
  //draw image
  image(image,0,0);
  
}
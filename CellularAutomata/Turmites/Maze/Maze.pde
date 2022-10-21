PGraphics image;
color cBg, cColor;

Ant[] ant;

void setup() {
  size(513,513);
  
  //throws errors when using more than one ant, as the die routine does not clean the array correctly
  ant = new Ant[50];
  
  for(int i=0;i<ant.length;i++) {
    ant[i] = new Ant(int(random(width)),int(random(height)),int(random(4)));
  }
  
  cBg = color(255);
  cColor = color(0);
  
  image = createGraphics(width,height);
  image.beginDraw();
  image.background(cBg);
  image.set(ant[0]._x,ant[0]._y,cColor);
  image.endDraw();
  image(image,0,0);
}

void draw() {
  image.beginDraw();
  //update each ant
  for(int i=0;i<ant.length;i++) {
    if(i<ant.length) {
      println("ant id "+i);
      println("arr len "+ant.length);
      printArray(ant);
      println("ant "+ant[i]);
      if(ant[i].die) {
        println(">>"+ant.length);
        ant = removeAnt(i);
        i--;
        println("<<"+ant.length);
      } else {
        //check if can move forward
        if(ant[i].isNextOpen(image)) {
          //move forward & paint square
          ant[i].moveAhead(image);
        } else {
          //turn left/right
          println(">"+ant.length);
          ant = (Ant[])append(ant,new Ant(ant[i]._x,ant[i]._y,(ant[i]._d+1)%4));
          ant[i]._d -= 1;
          if(ant[i]._d<0)ant[i]._d=3;
          println("<"+ant.length);
        }
      }
    }
  }
  image.endDraw();
  //draw new image
  image(image,0,0);
}
Ant[] removeAnt(int i) {
  Ant[] out = new Ant[ant.length-1];
  arrayCopy(ant,out,i);
  splice(ant,out,i+1);
  return out;
}

class Ant {
  int _x, _y, _d;
  boolean die = false;
  
  Ant(int x,int y,int d) {
    _x = x;
    _y = y;
    _d = d; 
  }
  
  private int nextX() {
    if(this._d==1)
      return (this._x+1==width)?0:this._x+1;
    if(this._d==3)
      return (this._x-1<0)?width-1:this._x-1;
    return this._x;    
  }
  private int nextY() {
    if(this._d==2)
      return (this._y+1==height)?0:this._y+1;
    if(this._d==0)
      return (this._y-1<0)?height-1:this._y-1;
    return this._y;    
  }
  private int kernelCount(PGraphics img,int x,int y) {
    int count=0;
    
    if(img.get(x,(y-1<0)?height-1:y-1)==cColor)
      count++;
    if(img.get(x,(y+1==height)?0:y+1)==cColor)
      count++;
    if(img.get((x-1<0)?width-1:x-1,y)==cColor)
      count++;
    if(img.get((x+1==width)?0:x+1,y)==cColor)
      count++;
    
    //println(count);
    return count;
  }
  
  boolean isNextOpen(PGraphics img) {
    if(img.get(this.nextX(),this.nextY())==cColor)
      return false;
    if(this.kernelCount(img,this.nextX(),this.nextY())>1) {
      this.die = true;
      return false;
    }
    return true;
  }
  void moveAhead(PGraphics img) {
    this._x = this.nextX();
    this._y = this.nextY();
    img.set(this._x,this._y,cColor);
  }
}
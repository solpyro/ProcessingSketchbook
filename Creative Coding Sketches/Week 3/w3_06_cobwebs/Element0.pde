//element class
class Element0 {
  //attributes
  float iX,iY, iR, iDX, iDY;
  
  //constructor
  Element0(float x, float y, float r, float dx, float dy) {
    iX = x;
    iY = y;
    iR = r;
    iDX = dx;
    iDY = dy;
  }
  
  //methods
  void move() {
    //move
    iX+=iDX;
    iY+=iDY;
    
    //bounce off walls
    if((iX-iR<=0)||(iX+iR>=width)) iDX *=-1;
    if((iY-iR<=0)||(iY+iR>=height)) iDY *=-1;
    
    //draw construciton
    if(bShowConstruction) {
      ellipse(iX,iY,2*iR,2*iR);
      point(iX,iY);
    }
  }
}

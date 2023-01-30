public class ActorC {
  float x,y,dx,dy;
  int r;
  int speed = 100;
  
  public ActorC(float fX, float fY, int iR) {
    x = fX;
    y = fY;
    dx = 0;
    dy = 0;
    r = iR;
  }
  
  void change(float fX, float fY, int iR) {
    x = fX;
    y = fY;
    dx = 0;
    dy = 0;
    r = iR;
  }
  
  void move(ActorC[] actors) {
    //move to new position
    for (int i = 0; i<actors.length; i++) {
      if (actors[i]!=this) {
        float fDist = dist(actors[i].x, actors[i].y, this.x, this.y);
        fDist = (fDist<10*speed)?0:1/fDist;
        float fX = (actors[i].x-this.x);
        float fY = (actors[i].y-this.y);
        float fAtan = atan2(fY, fX);

        dx += fDist*cos(fAtan);
        dy += fDist*sin(fAtan);
      }
    }
    
    x += constrain(dx, -speed, speed);
    y += constrain(dy, -speed, speed);
  }
  void react(int limit) {
    //check for bouncing off the wall
    if(dist(0,0,x,y)+r>=limit) {
      //This code was derived from algebra found here:
      //http://rectangleworld.com/blog/archives/358 
      float twoProjNV = 2*(((dx*x)+(dy*y))/(sq(x)+sq(y)));
      dx -= twoProjNV*x;
      dy -= twoProjNV*y;
    }
    //check for bouncing off other automata - this is not working
    for(int i=0;i<aActors.length;i++)
      if(aActors[i]!=this)
        if(dist(x,y,aActors[i].x,aActors[i].y)<=r+aActors[i].r) {
          float tempX = dx;
          float tempY = dy;
          dx = aActors[i].dx;
          dy = aActors[i].dy;
          aActors[i].dx = tempX;
          aActors[i].dy = tempY;
        }
  }
  
  void display() {
    //draw radius
    ellipse(x,y,2*r,2*r);
    //draw vector
    line(x,y,x+dx,y+dy);
    ellipse(x,y,5,5);
  }
}
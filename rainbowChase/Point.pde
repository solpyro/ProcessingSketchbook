class Point {
  float fX,fY;
  float iSpeed = 0.75; // px/frame
  color cCol;
  
  Point(float x, float y, color col) {
    fX = x;
    fY = y;
    cCol = col;
  }
  
  boolean follow(float x, float y) {
    //check if lines are too close
    if(dist(fX,fY,x,y)>1) {
      //calculate new position
      float fTheta = atan2((x-fX),(y-fY)); 
      float dX = fX+(sin(fTheta)*iSpeed);
      float dY = fY+(cos(fTheta)*iSpeed);
      //calculate proximity
      float iAlpha = (1-(dist(fX,fY,x,y)/(dist(0,0,width,height)/2)))*100;
      //draw movement line
      stroke(cCol,iAlpha);
      line(fX,fY,dX,dY);
      //update position
      fX = dX;
      fY = dY;
      return true;
    } else {
      return false;
    }
  }
  
  void setCoords(float x, float y) {
    fX = x;
    fY = y;
  }
}

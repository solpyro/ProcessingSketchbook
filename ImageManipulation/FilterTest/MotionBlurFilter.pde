class MotionBlurFilter extends KernelFilter {
  
  MotionBlurFilter(float angle) {
    //run parent constructor
    super(3);
    
    angle = rad(angle);
    
    //populate kernel based on angle of rotation
    kernel[0][0] = 0;//abs(cos(angle-(PI/4)));
    kernel[0][1] = 4;//abs(cos(angle));
    kernel[0][2] = 0;//abs(cos(angle+(PI/4)));
    kernel[1][0] = 0;//abs(cos(angle-(PI/2)));
    kernel[1][1] = 1;
    kernel[1][2] = 0;//abs(cos(angle+(PI/2)));
    kernel[2][0] = 0;//abs(cos(angle-(3*PI/4)));
    kernel[2][1] = 4;//abs(cos(angle+PI));
    kernel[2][2] = 0;//abs(cos(angle+(3*PI/4))); 
  }

  private float rad(float deg) {
    return deg*PI/180;
  }
}
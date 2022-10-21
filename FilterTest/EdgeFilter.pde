class EdgeFilter extends KernelFilter {
  int strength;
  protected float[][] kernel_b;
  
  EdgeFilter() {
    //run parent constructor
    super (3);
        
    //populate kernel with (y)
    //[[-1,-2,-1]
    // [ 0, 0, 0]
    // [ 1, 2, 1]]
    kernel[0][0] = -1;
    kernel[0][1] = -2;
    kernel[0][2] = -1;
    kernel[1][0] = 0;
    kernel[1][1] = 0;
    kernel[1][2] = 0;
    kernel[2][0] = 1;
    kernel[2][1] = 2;
    kernel[2][2] = 1;
    
    //populate kernel_b with (x)
    //[[-1, 0, 0]
    // [-1, 0, 1]
    // [-1, 0, 0]]
    kernel_b = new float[3][3];
    kernel_b[0][0] = -1;
    kernel_b[1][0] = -2;
    kernel_b[2][0] = -1;
    kernel_b[0][1] = 0;
    kernel_b[1][1] = 0;
    kernel_b[2][1] = 0;
    kernel_b[0][2] = 1;
    kernel_b[1][2] = 2;
    kernel_b[2][2] = 1;
    
  }
  
  protected color calcPixel(int x, int y,  PImage img) {
    //calculate colours seperately
    float ry = 0;
    float gy = 0;
    float by = 0;
    float rx = 0;
    float gx = 0;
    float bx = 0;
    float r = 0;
    float g = 0;
    float b = 0;
    //loop through the kernel, ignoring areas of ther kernel outside of the image 
    for(int i=-centre;(i<=centre);i++) {
      if((x+i>=0)&&(x+i<=img.width)) {
        for(int j=-centre;(j<=centre);j++) {
          if((y+j>=0)&&(y+j<=img.height)) {
            //tally colour values and weights
            ry += kernel[i+centre][j+centre]*red(img.get(x+i,y+j));
            gy += kernel[i+centre][j+centre]*green(img.get(x+i,y+j));
            by += kernel[i+centre][j+centre]*blue(img.get(x+i,y+j));
            
            rx += kernel_b[i+centre][j+centre]*red(img.get(x+i,y+j));
            gx += kernel_b[i+centre][j+centre]*green(img.get(x+i,y+j));
            bx += kernel_b[i+centre][j+centre]*blue(img.get(x+i,y+j));
            
          }
        }
      }
    }
    
    r = sqrt(pow(ry,2)+pow(rx,2));
    g = sqrt(pow(gy,2)+pow(gx,2));
    b = sqrt(pow(by,2)+pow(bx,2));
    
    //return averged RGB values
    return color(r,g,b);
  }
}
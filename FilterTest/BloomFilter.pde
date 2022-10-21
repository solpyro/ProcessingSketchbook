class BloomFilter extends KernelFilter {
  float threshold;
  
  BloomFilter(int str, float t) {
    //run parent constructor
    super((str*2)+1);
    
    threshold = t;
    
    //populate kernel
    for(int i=0;i<(str*2)+1;i++) {
      for(int j=0;j<(str*2)+1;j++) {
        //populate matrix - how do we decide this?
        kernel[i][j] = 1;
      }
    } 
  }
  
  protected color calcPixel(int x, int y, PImage img) {    
    //calculate colours seperately
    float r = 0;
    float g = 0;
    float b = 0;
    float v = 0;
    //loop through the kernel, ignoring areas of ther kernel outside of the image 
    for(int i=-centre;(i<=centre);i++) {
      if((x+i>=0)&&(x+i<=img.width)) {
        for(int j=-centre;(j<=centre);j++) {
          if((y+j>=0)&&(y+j<=img.height)) {
            //tally colour values and weights
            if((i==0 && j==0) ||
               ((red(img.get(x+i,y+j))+green(img.get(x+i,y+j))+blue(img.get(x+i,y+j)))/3>=threshold)) {
              r += kernel[i+centre][j+centre]*red(img.get(x+i,y+j));
              g += kernel[i+centre][j+centre]*green(img.get(x+i,y+j));
              b += kernel[i+centre][j+centre]*blue(img.get(x+i,y+j));
              v++;
            }
          }
        }
      }
    }
    
    //return averged RGB values
    return color(r/v,g/v,b/v);
  }
}
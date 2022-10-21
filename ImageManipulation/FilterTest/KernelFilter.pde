class KernelFilter extends PixelFilter {
  protected float[][] kernel;
  protected int centre;
  
  KernelFilter(int size) {
    //run parent constructor
    super();
    
    //ensure grid is an odd number (round up because rounding down for 2 would make a pointless grid)
    if(size%2==0)size++;
    //ensure the grid is useful by having a size >1
    max(size,3);
    
    //store centre element value
    centre = floor(size/2);
    
    //build kernel
    kernel = new float[size][size];
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
            r += kernel[i+centre][j+centre]*red(img.get(x+i,y+j));
            g += kernel[i+centre][j+centre]*green(img.get(x+i,y+j));
            b += kernel[i+centre][j+centre]*blue(img.get(x+i,y+j));
            v += kernel[i+centre][j+centre];
          }
        }
      }
    }
    
    //return averged RGB values
    return color(r/v,g/v,b/v);
  }
}
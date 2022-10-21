//Derive fropm KernelFilter
//kernek like this
//[[-1, -1,  0]
// [-1,  0,  1]
// [ 0,  1,  1]]
// for a 45deg bump.

//maybe use SIN(dir+theta) to decide the value at each point?
//bonus points for a greyscale output

class BumpFilter extends KernelFilter {
  float bias = 128.0;


  BumpFilter(float angle) {
    //run parent constructor
    super(3);
    
    angle = rad(angle);
    
    //populate kernel based on angle of rotation
    kernel[0][0] = cos(angle-(PI/4));
    kernel[0][1] = cos(angle);
    kernel[0][2] = cos(angle+(PI/4));
    kernel[1][0] = cos(angle-(PI/2));
    kernel[1][1] = 0;
    kernel[1][2] = cos(angle+(PI/2));
    kernel[2][0] = cos(angle-(3*PI/4));
    kernel[2][1] = cos(angle+PI);
    kernel[2][2] = cos(angle+(3*PI/4));
  }

  protected color calcPixel(int x, int y, PImage img) {    
    //calculate colours seperately
    float r = 0;
    float g = 0;
    float b = 0;
    //loop through the kernel, ignoring areas of ther kernel outside of the image 
    for (int i=-centre; (i<=centre); i++) {
      if ((x+i>=0)&&(x+i<=img.width)) {
        for (int j=-centre; (j<=centre); j++) {
          if ((y+j>=0)&&(y+j<=img.height)) {
            //tally colour values and weights
            r += kernel[i+centre][j+centre]*red(img.get(x+i, y+j));
            g += kernel[i+centre][j+centre]*green(img.get(x+i, y+j));
            b += kernel[i+centre][j+centre]*blue(img.get(x+i, y+j));

            if (x==5&&y==5) {
              println(kernel[i+centre][j+centre]+" * "+red(img.get(x+i, y+j)));
              println(addBias(r)+", "+addBias(g)+", "+addBias(b));
            }
          }
        }
      }
    }
    
    //return averged RGB values
    return color(addBias(r), addBias(g), addBias(b));
  }

  private float addBias(float val) {
    return min(max(val+bias, 0), 255);
  }
  private float rad(float deg) {
    return deg*PI/180;
  }
}
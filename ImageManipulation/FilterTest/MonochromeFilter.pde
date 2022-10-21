class MonochromeFilter extends PixelFilter {
  color tint;
  
  MonochromeFilter(color targetColor) {
    //run parent constructor
    super();
    
    tint = targetColor;
  }
  
  MonochromeFilter() {
    //run parent constructor
    super();
    
    tint = color(0,0,0);
  }
  
  protected color calcPixel(int x, int y, PImage img) {
    color pxl = img.get(x,y);
    float val = (red(pxl)+ green(pxl)+ blue(pxl))/3;
    return color(tintPixel(red(tint),val),tintPixel(green(tint),val),tintPixel(blue(tint),val));
  }
  private float tintPixel(float base, float mod) {
    return base + ((mod/255)*(255-base));
  }
  
}
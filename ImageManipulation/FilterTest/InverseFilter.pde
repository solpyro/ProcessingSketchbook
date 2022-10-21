class InverseFilter extends PixelFilter {
  
  InverseFilter() {
    super();
  }
  
  protected color calcPixel(int x, int y, PImage img) {
    color pxl = img.get(x,y);
    return color(255-red(pxl),255-green(pxl),255-blue(pxl));
  }
}
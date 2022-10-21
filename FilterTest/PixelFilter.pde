class PixelFilter extends Filter {
  protected float[][] kernel;
  protected int centre;
  
  PixelFilter() {
    //run parent constructor
    super();
  }
  
  protected color calcPixel(int x, int y, PImage img) {
    //return RGB value
    return img.get(x,y);
  }
  
  public PImage applyFilter(PImage img) {
     PImage output = createImage(img.width,img.height,RGB);
     
     for(int i=0;i<img.width;i++) {
       for(int j=0;j<img.height;j++) {
         output.set(i,j,calcPixel(i,j,img));
       }
     }
     
     return output;
  }
  
}
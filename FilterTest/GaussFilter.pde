class GaussFilter extends KernelFilter {
  
  GaussFilter(int size, float sd) {
    //run parent constructor
    super(size);
    
    //populate kernel   
    for(int i=0;i<size;i++) {
      for(int j=0;j<size;j++) {
        //populate matrix - how do we decide this?
        kernel[i][j] = gauss2d(i-ceil(size/2),j-ceil(size/2),sd);
      }
      printArray(kernel[i]);
    }
  }
  
  //calculates a point on a gauss distribution field
  private float gauss2d(int x,int y, float sd) {
    return (1/(2*PI*sd*sd))*pow(exp(1),-((x*x)+(y*y))/(2*sd*sd));
  }
}
class SharpenFilter extends KernelFilter {
  private int size = 3;
  
  SharpenFilter() {
    //run parent constructor
    super(3);
    
    //populate kernel
    int counter = 0;
    for(int i=0;i<size;i++) {
      for(int j=0;j<size;j++) {
        kernel[i][j] = -1;//gauss2d(i-ceil(size/2),j-ceil(size/2),sd);
        counter++;
      } 
    }
    kernel[centre][centre] = counter;
  }
  
}
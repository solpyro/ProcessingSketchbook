//create an array for the current frame's z value
// could this be a graphics objec encoded as colour?

//Zn+1 = Zn^2 + c
//Z0 == 0
//c = the currently number on the complex plane (x=R,y=I)
//function should return the number of steps it takes for |z|>=2
// or max iterations
final int MAX_ITER = 150;
final int POWER = 2;
final boolean MANDELBROT_MODE = true;
final boolean COLOR_MODE = true;
final boolean GRAD_MODE = true;

int iter = 10;
PVector tl, br;
Complex C;

void setup() {
  size(900, 900);
  tl = new PVector(-2,-2);
  br = new PVector(2,2);
  
  //tl = new PVector(-1,-2);
  //br = new PVector(1,0);
  
  //tl = new PVector(-1,-.5);
  //br = new PVector(-.5,0);
  
  //-0.7746806106269039 -0.1374168856037867i Range: 1.506043553756164E-12
  //float dif = 1.506043553756164/pow(10,5);//1e6 seems to be the limit of the float values
  //tl = new PVector(-0.7746806106269039-dif,-0.1374168856037867-dif);
  //br = new PVector(-0.7746806106269039+dif,-0.1374168856037867+dif);
    
  //fullScreen(); //1920,1080
  //tl = new PVector(-3.56,-2);
  //br = new PVector(3.56,2);
  
  //tl = new PVector(-1.78,-1);
  //br = new PVector(1.78,1);
  
  //tl = new PVector(-1.78,-1);
  //br = new PVector(0,0);
  
  //set julia C value
  C = new Complex(0.285, 0.01);
  // Other interesting values:
  C = new Complex(-0.8, 0.156);
  //C = new Complex(-0.7269, 0.1889);
  //C = new Complex(-0.4, 0.6);
  //C = new Complex(-.6,.5);
  //C = new Complex(.25, .55);
  //C = new Complex(-.74543, .11301);
  //C = new Complex(-.75, .11);
  //C = new Complex(-.1, .651);
  //C = new Complex(0, -.8);
  //C = new Complex(-.835, -.2321);
  //C = new Complex(.285, 0);
  //en.wikipedia.org/wiki/Julia_set#Quadratic_polynomials
  
  noStroke();
  fill(#00cc00);  
  
  //drawMandelbrot(MAX_ITER);
}

void draw() {
  if(iter<MAX_ITER) {
    drawMandelbrot(iter);
    iter += 1;
  }
  
  if(iter!=MAX_ITER)
    rect(0,height-2,width*(iter-1)/MAX_ITER,height);
}

void keyPressed() {
  if(key=='s')
    save(
      "data/"+(MANDELBROT_MODE ? "mandelbrot":"julia_"+C)+"_"+
      (COLOR_MODE ? "col" : "bw")+"_"+
      tl.x+','+tl.y+","+br.x+","+br.y+"_"+
      width+','+height+"_"+
      iter+".png"
    );
}

void drawMandelbrot(int max) {
  if(COLOR_MODE)
    colorMode(HSB,255);
  
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      float m = 0;
      if(MANDELBROT_MODE)
        m = calcMandelbrot(complexFromPixel(x, y, tl, br),max);
      else
        m = calcJulia(complexFromPixel(x, y, tl, br),max);
      //calcOther(complexFromPixel(x, y, tl, br),max);
      //println(x, y, m);
      if(COLOR_MODE)
        set(
          x, y, 
          color(
            m*255/max,
            255,
            m==max?0:255
          )
         );
       else
         set(x, y, color(255-(m*255/max)));
    }
  }
}

Complex complexFromPixel(int x, int y, PVector tl, PVector br) {
  //return new Complex(
  //  (x-(width/2))*4f/width, 
  //  (y-(height/2))*4f/width
  //);
  return new Complex(
    ((br.x-tl.x)*(x/float(width)))+tl.x,
    ((br.y-tl.y)*(y/float(height)))+tl.y
  );
}
float calcMandelbrot(Complex c, int max) {
  Complex z = new Complex();
  int n = 0;

  while (z.abs() <= 2f && n < max) {
    z = z.power(POWER).add(c);
    //println(z.abs());
    n++;
  }
  
  if(n==max) return max;
  
  if(GRAD_MODE)
    return n + 1 - log(logn(z.abs(),2));
  
  return n;
}
float calcJulia(Complex z, int max) {
  int n = 0;
  
  while (z.abs() <= 2f && n < max) {
    z = z.power(POWER).add(C);
    //println(z.abs());
    n++;
  }
  
  if(n==max) return max;
  
  if(GRAD_MODE)
    return n + 1 - log(logn(z.abs(),2));
  
  return n;  
}
float calcOther(Complex z, int max) {
  //(z^3-z)/(dz^2+1) mit d=1,001*e^(2pi/30)
  float d = 1.001*exp(2*PI/30);
  int n = 0;
  
  while (z.abs() <= 2f && n < max) {
    z = z.power(3).minus(z).div(z.power(2).mult(d).add(1));
    //println(z.abs());
    n++;
  }
  
  if(n==max) return max;
  
  if(GRAD_MODE)
    return n + 1 - log(logn(z.abs(),2));
  
  return n; 
};

float logn(float x,float n) {
  return (log(x)/log(n));
}

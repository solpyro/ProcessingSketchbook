//import Math;

class Complex {
  public float r, i;
  
  public Complex(){
    this.r = 0f;
    this.i = 0f;
  }
  public Complex(float real, float imaginary) {
    this.r = real;
    this.i = imaginary;
  }
  
  public Complex add(Complex b) {
    return new Complex(
      r+b.r,
      i+b.i
    );
  }
  public Complex minus(Complex b) {
    return new Complex(
      r-b.r,
      i-b.i
    );
  }
  public Complex mult(Complex b) {
    return new Complex(
      r*b.r - i*b.i,
      r*b.i + i*b.r
    );
  }
  public Complex div(Complex b) {
    float d = pow(b.r,2)+pow(b.i,2);
    return new Complex(
      ((r*b.r)+(i*b.i))/d,
      ((i*b.r)-(r*b.i))/d
    );
  }
  public Complex mult(float b) {
    return new Complex(
      r*b,
      i*b
    );
  }
  public Complex add(float b) {
    return new Complex(
      r+b,
      i
    );
  }
  public Complex power(int exp) {
    //this function cannot accept fractional or negative exponents
    if(exp <= 0)
      return new Complex(1,0);
    return this.mult(this.power(exp-1));
  }
  public float abs() {
    return sqrt(pow(r,2)+pow(i,2));
  }
  
  public String toString() {
    if(i<0)
      return r+i+"i";
    return r+"+"+i+"i";
  }
}

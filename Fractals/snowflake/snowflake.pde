int iterations = 10;
int i = 0;
float[] points_x = { 0f, 1000f }, 
  points_y = { 0f, 0f };
float step = 80.0;
float r3o2 = sqrt(3.0)/2.0;

void setup() {
  //build screen
  size(1000, 1000);
  fill(color(0, 0, 0), 255);
  rect(0, 0, width, height);
}

void draw() {
  while (++i<iterations) {
    //increase opacity
    stroke(color(255, 255, 255), (i*255)/iterations);

    //store a temp copy of points
    float[] temp_x = points_x;
    float[] temp_y = points_y;
    arrayCopy(points_x, temp_x);
    arrayCopy(points_y, temp_y);
    //set new points length
    points_x = new float[((temp_x.length-1)*4)+1];
    points_y= new float[((temp_x.length-1)*4)+1];

    for (int i=0; i<temp_x.length-1; i++) {
      //preserve existing points points
      //println(i+", "+i*4+", "+points_x.length+", "+temp_x.length);
      points_x[i*4] = temp_x[i];
      points_y[i*4] = temp_y[i] + step;

      //calculate new points
      if (points_x.length>(i*4)) {
        float dx = (temp_x[i+1]-temp_x[i]);
        float dy = (temp_y[i+1]-temp_y[i]);

        float dxo3 = dx/3;
        float dyo3 = dy/3;
        
        float a = dy/dx;
        float theta = atan(a);
        //float r = sqrt(pow(dxo3, 2)+pow(dyo3, 2))*r3o2; //equelateral
        float r = sqrt(pow(dxo3, 2)+pow(dyo3, 2))/2; //right-angled isosolese

        points_x[(i*4)+1] = temp_x[i]+dxo3;
        points_y[(i*4)+1] = temp_y[i]+dyo3 + step;
        
        //the +0,+5 needs to be replaced with the top of an equilateral triangle
        points_x[(i*4)+2] = temp_x[i]+(dx/2) + (r*cos(theta+(PI/2)));
        points_y[(i*4)+2] = temp_y[i]+(dy/2) + (r*sin(theta+(PI/2))) + step;

        points_x[(i*4)+3] = temp_x[i]+(2*dxo3);
        points_y[(i*4)+3] = temp_y[i]+(2*dyo3) + step;
      }
    }

    //add last position
    points_x[points_x.length-1] = temp_x[temp_x.length-1];
    points_y[points_x.length-1] = temp_y[temp_x.length-1] + step;

    //draw iteration , starting 1px higher
    for (int j=0; j<points_x.length-1; j++) {
      line(round(points_x[j]), (height-i)-round(points_y[j]), round(points_x[j+1]), (height-i)-round(points_y[j+1]));
    }
  }
}
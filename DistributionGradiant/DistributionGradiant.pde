int bucketCount = 250;
float full = 100;
int loss = 100;//amount removed per frame
float[] buckets;
float bucketWidth;

void setup() {

  //prep canvas
  size(500,100);
  background(255);
  
  //build buckets
  buckets = new float[bucketCount];
  for(int i=0;i<bucketCount;i++) {
    buckets[i]=full;
  }
  
  bucketWidth = width/bucketCount;
}

void draw() {
  //clear screen
  background(255);
  
  //remove items from first bucket
  //down to 0 items
  buckets[0] -= loss;
  buckets[0] = max(buckets[0],0);
 
  //update bucket values
  for(int i=1;i<bucketCount;i++) {
    if(buckets[i]!=buckets[i-1]) {
      //a bucket will try to balance with the previous bucket
      //by giving it half of their difference 
      float diff = (buckets[i]-buckets[i-1])/2;
      buckets[i]-=diff;
      buckets[i-1]+=diff;
    }
  }
  
  //draw buckets
  for(int i=0;i<bucketCount;i++) {
    noStroke();
    fill((buckets[i]/full)*255);
    rect(i*bucketWidth,0,bucketWidth,height);
  }  
}

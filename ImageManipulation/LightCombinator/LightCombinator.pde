String[] photos;
PImage pOut;
int i = 1; 

void setup() {
  //setup progress bar
  size(500,130);
  fill(0,128,0);
  noStroke();
  
  // gather list of photos from data folder
  File dir = new File(sketchPath()+"/data");
  //println(dir);
  photos = dir.list();
  
  // open first photo as base
  pOut = loadImage(photos[0]);
}

void draw() {
  // update the progress bar
  rect(0,0,i*(width/photos.length),height);
  
  PImage pNext = loadImage(photos[i]);
  takeBrightest(pOut,pNext);
  // check each pixel
    // compare light intensity & take brightest for output
  
  // if last image
  if(++i==photos.length) {
    // save output
    pOut.save("data/_output.jpg");
    
    exit();
  }
}

void takeBrightest(PImage output, PImage candidate) {
  for(int x = 0;x<output.width;x++){
    for(int y = 0;y<output.height;y++){
      if(candidateIsBrighter(candidate.get(x,y),output.get(x,y)))
        output.set(x,y,candidate.get(x,y)); 
    }
  }
}

boolean candidateIsBrighter(color candidate, color output) {
  return brightness(candidate)>brightness(output);
}

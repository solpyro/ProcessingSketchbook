PGraphics image;
color cBg, cColor;
int domain = 64; //column width for each automata
boolean[] seed;
int[] rule = {30,45,75,86,89,101,106,120,135,149,169,225};
int counter = 1;
int ulticounter = 0;


void setup() {
  size(768, 950);//64*12 - each rule gets it's own column
  
  //build random starting conditions
  seed = new boolean[domain];
    
  //Random seed
  //*/
  for (int i=0; i<domain; i++) {
    seed[i] = random(1)>.5;
  }
  //*/
  //Predefined string
  //seed = unhash("0000000000000000",domain); //empty
  //seed = unhash("0000000000000001",domain); //last pixel
  //seed = unhash("0000000080000000",domain); //middle pixel
  //seed = unhash("0123456789ABCDEF",domain);
  //seed = unhash("8000000000000000",domain); //first pixel
  //seed = unhash("FFFFFFFFFFFFFFFF",domain); //full
  
  //prepare colours
  cBg = color(255);
  cColor = color(0);
  
  //prime image
  image = createGraphics(domain*rule.length, height);
  image.beginDraw();
  image.background(cBg);
  //draw random seed
  for (int i=0; i<rule.length; i++) {
    for (int k=0; k<domain; k++) {
      if (seed[k])
        image.set((i*domain)+k, 0, cColor);
    }
  }
  image.endDraw();
  image(image, 0, 0);
}

void draw() {
  image.beginDraw();
  for (int i=0; i<rule.length; i++) {
    for (int k=0; k<domain; k++) {

      //build pattern - this algorythem wraps the domain as a cylinder
      int pattern = 0;
      
      int lastRow = counter-1;
      if(lastRow<0)
        lastRow = height-1;
        
      if ((k>0 && image.get((i*domain)+(k-1),lastRow)==cColor)
       || (k==0 && image.get((i*domain)+(domain-1), lastRow)==cColor))
        pattern |= 1 << 2;
      if (image.get((i*domain)+k, lastRow)==cColor)
        pattern |= 1 << 1;
      if ((k<domain-1 && image.get((i*domain)+(k+1), lastRow)==cColor)
       || (k==domain-1 && image.get((i*domain), lastRow)==cColor))
        pattern |= 1;

      //select colour of (counter, k) according
      if (patternResponse(pattern, rule[i]))
        image.set((i*domain)+k, counter, cColor);
      else
        image.set((i*domain)+k, counter, cBg);
    }
  }
  image.endDraw();
  image(image, 0, 0);
  
  //cancel the loop after all lines have been drawn
  if (++counter==height) {
    counter = 0;
    println(++ulticounter);
  }
}

boolean patternResponse(int pattern, int rule) {
  int mask = (1 << pattern);
  return (rule&mask) == mask;
}

boolean[] unhash(String hash, int arrlen) {
  boolean[] array = new boolean[hash.length()*4];
  //reinflate hex hash to boolean array
  for(int i=hash.length()-1;i>=0;i--) {
    int val = unhex(str(hash.charAt(i)));
    array[(i*4)+3] = (val&1)==1;
    array[(i*4)+2] = (val&(1<<1))==(1<<1);
    array[(i*4)+1] = (val&(1<<2))==(1<<2);
    array[(i*4)] = (val&(1<<3))==(1<<3);
  }

  //clip/expand array as required
  if(array.length>arrlen)
    array = subset(array,array.length-arrlen);
  while(array.length<arrlen)
    array = splice(array,false,0);

  return array;
}
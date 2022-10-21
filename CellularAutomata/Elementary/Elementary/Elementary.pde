PGraphics image;
color cBg, cColor;
int domain = 64; //square size for each automata
int count = 16;
boolean[] seed;
int counter = 1;
void setup() {
  size(1024, 1024);//16*64
  
  //build random starting conditions
  seed = new boolean[domain];
  
  //Random seed
  //*/
  for (int i=0; i<domain; i++) {
    seed[i] = random(1)>.5;
  }
  //*/
  
  //First cell only
  //seed[0] = true;
  //Centre cell only
  //seed[domain/2] = true;
  //Last cell only
  //seed[domain-1] = true;
  
  //Predefined string
  //seed = unhash("0123456789ABCDEF",domain);
  //seed = unhash("0000000000000000",domain);
  //seed = unhash("FFFFFFFFFFFFFFFF",domain);
  
  //prepare colours
  cBg = color(255);
  cColor = color(0);

  //prime image
  image = createGraphics(domain*count, domain*count);
  image.beginDraw();
  image.background(cBg);
  //draw random seed
  for (int i=0; i<count; i++) {
    for (int j=0; j<count; j++) {
      for (int k=0; k<domain; k++) {
        if (seed[k])
          image.set((i*domain)+k, j*domain, cColor);
      }
    }
  }
  image.endDraw();
  image(image, 0, 0);
}

void draw() {
  
  image.beginDraw();
  for (int j=0; j<count; j++) {
    for (int i=0; i<count; i++) {

      int rule = i+(j*count);

      for (int k=0; k<domain; k++) {

        //build pattern - this algorythem wraps the domain as a cylinder
        int pattern = 0;
        if ((k>0 && image.get((i*domain)+(k-1), (j*domain)+(counter-1))==cColor)
         || (k==0 && image.get((i*domain)+(domain-1), (j*domain)+(counter-1))==cColor))
          pattern |= 1 << 2;
        if (image.get((i*domain)+k, (j*domain)+(counter-1))==cColor)
          pattern |= 1 << 1;
        if ((k<domain-1 && image.get((i*domain)+(k+1), (j*domain)+(counter-1))==cColor)
         || (k==domain-1 && image.get((i*domain), (j*domain)+(counter-1))==cColor))
          pattern |= 1;

        //select colour of (counter, k) according
        if (patternResponse(pattern, rule))
          image.set((i*domain)+k, (j*domain)+counter, cColor);
      }
    }
  }
  image.endDraw();
  image(image, 0, 0);

  //cancel the loop after all lines have been drawn
  if (++counter==domain) {
    noLoop();
  
    //store image
    String name = hash(seed);
    save(name+".png");
  }
}

boolean patternResponse(int pattern, int rule) {
  int mask = (1 << pattern);
  return (rule&mask) == mask;
}

String hash(boolean[] seed) {
  String value = "";
  for(int i=seed.length-1;i>=0;i-=4) {
    int val = int(seed[i]);
    if(i-1>=0)
      val |= int(seed[i-1])<<1;
    if(i-2>=0)
      val |= int(seed[i-2])<<2;
    if(i-3>=0)
      val |= int(seed[i-3])<<3;
    
    if(val<10)
      value = str(val) + value;
    else {
      switch(val) {
        case 10:
          value = "A" + value;
          break;
        case 11:
          value = "B" + value;
          break;
        case 12:
          value = "C" + value;
          break;
        case 13:
          value = "D" + value;
          break;
        case 14:
          value = "E" + value;
          break;
        case 15:
          value = "F" + value;
          break;
      }
    } 
  }
  println(value);
  return value;
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
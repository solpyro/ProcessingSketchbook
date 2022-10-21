PGraphics field, last_field; //<>//
final color[] colors = {
  color(0), 
  color(255)
};

Turmite mite;

boolean showTurmite = true,
        showInfo = false;
int cycles = 0;
int rule = 0xA1D7;//-1;
void setup() {
  //create output
  size(500, 500);
  //fullScreen();
  //noCursor();

  //create field
  field = createGraphics(width, height);
  
  //create field_history
  last_field = createGraphics(width, height);
  
  restart();
}

void draw() {
  last_field.beginDraw();
  last_field.image(field,0,0);
  last_field.endDraw();
  
  field.beginDraw();
  mite.update(field);
  field.endDraw();
  
  if(cycles>2 && (match(field,last_field) || cycles == 100000)) {
    field.save("data/"+hex(rule,4)+"_"+cycles+".jpg");
    restart();
  }
  
  image(field, 0, 0);

  if(showTurmite) {
    fill(color(255, 0, 0));
    noStroke();
    circle(mite._x, mite._y, 5);
  }
  
  if(showInfo) {
    textSize(16);
    fill(color(0, 255, 0));
    text("Cycle: "+cycles, 16, 32);
    text("Turmite x:"+mite._x+", y:"+mite._y, 16, 50);
    text("Rule: "+hex(rule,4), 16, 68);
  }
  
  cycles++;
}

void keyPressed() {
  switch(key) {
    case 'i':
      showInfo = !showInfo;
      break;
    case 't':
      showTurmite = !showTurmite;
      break;
    default:
      println("no action for key '"+key+"'");
  }
}

boolean match(PGraphics a, PGraphics b) {
  boolean isMatch = true;
  a.loadPixels();
  b.loadPixels();
  for (int i = 0; isMatch && i < a.pixels.length; i++) {
    color c1 = a.pixels[i];
    color c2 = b.pixels[i];
    isMatch = match(c1, c2);
    //if(!isMatch) {
    //  println("Something changed: px"+i+", ("+i%width+","+int(i/width)+"), c1:"+c1+", c2:"+c2); //<>//
    //}
  }
  return isMatch;
}
boolean match (color a, color b) {
  boolean result = (red(a)==red(b))
      && (green(a)==green(b))
      && (blue(a)==blue(b));
  //if(!result)
  //  println("a("+red(a)+", "+green(a)+", "+blue(a)+") b("+red(b)+", "+green(b)+", "+blue(b)+")");
  return result;
}

void restart() {
  //increment rule counter
  rule++;  
  if(rule>0xFFFF)
    exit();
  
  //clear field
  field.beginDraw();
  field.background(colors[0]);
  field.endDraw();
  
  //init new turmite
  mite = new Turmite(
    width/2, 
    height/2, 
    //"1082", //0001 0000 1000 0010 //draws a cross, counts in binary
    //"10A6", //0001 0000 1010 0110 //Langton's Ant but more black
    //"10AB", //0001 0000 1010 1011 //Builds 2 kinds of highway in 4 different directions
    //"10C9", //binary counter
    //"11A5", //pinwheel
    //"1381",
    //"19FC", //Draws a perfect diamond
    //"1AD4", //Draws a solid paralellogram
    //"3085", //Random, then draws a triangle
    //"3192", //Roads within roads
    //"33A7", //Interesting cityscape
    //"36F2", //Square spiral, fibbonaci?
    //"36F8", //builds a triangle
    //"3AF6", //square spiral
    //"3B89", //frosty
    //"3F92", //marble slab
    //"57B2", //two distinct highways
    //"72B6", //stripy spiral
    //"8F0C", //interesting method to create a simple set of crosses
    //"8F78", //strange Tron
    //"906A", //builds incomplete highways
    //"90AE", //weird firey octogon
    //"90E4", //zigzag highway
    //"92AA", //box around a colony
    //"925A", //draws a ringroad
    //"92FA", //check this one as it grows
    //"95AB", //draws an actual box
    //"95AE", //worms on a field
    //"96B0", //square roundal with a weird growing method
    //"982E", //play button
    //"9AF0", //tries to make a circle
    //"9BB6", //equatorial hive & highway
    //"9FF2", //wave form
    //"9EB0", //1001 1110 1011 0000 //spiral
    //"A3C4", //figure 8
    //"AB01", //1010 1011 0000 0001 //random & structured
    //"B389", //1011 0011 1000 1001
    //"BFB2", //1011 1111 1011 0010
    //"EB27", //1110 1011 0010 0111
    //"FFB0", //1111 1111 1011 0000 //fibonacci
    //"FFC0", //1111 1111 1100 0000 //interesting random pattern, then highway
    hex(rule,4),
    colors
  );
  
  //reset counter
  cycles = 0;  
}

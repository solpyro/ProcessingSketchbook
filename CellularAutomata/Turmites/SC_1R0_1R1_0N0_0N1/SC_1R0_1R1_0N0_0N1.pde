//State<<1 & Color = Action Selection
//SC_Action1_Action2_Action3_Action4
//Action = WriteColor, Turn, NewState
//Turn = NoTurn, Right, UTurn, Left  (0123)
//Alt  = North, East, South, West    (0123)

//65536 (2^16) possible configurations for each turn set
//possibly encode the rule over 2 bytes:
//S D  C|S D  C|S D  C|S D  C
//0 00 0|0 00 0|0 00 0|0 00 0
//Rule can be sored as 5-fig hex nymber, including init state for turmite:
//Init 11 10 01 00
//A    4  D  E  F

//1010 0011 0110 0011 0110
//8A6A6
PGraphics image;
color cBg, cColor;

boolean bIsReletive = true;
int seedCount = 500;

int ant_x, ant_y, ant_d;
boolean ant_s;

Rule initState;
Rule[] ruleset;

void setup() {
  size(500,500);
    
  //initilise colours
  cBg = color(255);
  cColor = color(0);
  
  //create initial image
  image = createGraphics(width,height);
  
  //create ruleset
  ruleset = unhashRuleset("03636");//Langton's Ant
  //ruleset = unhashRuleset("8FFDD");
  
  //initilise ant
  ant_x = width/2;
  ant_y = height/2;
  ant_s = initState.state;
  ant_d = initState.direction; 
  

  image.beginDraw();
  image.background(cBg);
  image.set(ant_x,ant_y,(initState.colour)?cColor:cBg);
  /*
  //seed with random data
  for(int i=0;i<seedCount;i++) {
    image.set(round(random(width)),round(random(height)),cColor);
  }
  */
  image.endDraw();
  image(image,0,0);
  
  for(int i=0;i<ruleset.length;i++)
    println(ruleset[i].toString());
}

void draw() {
  //select rule
  color temp = image.get(ant_x,ant_y);
  int r = (int(ant_s)<<1)+int(temp==cColor);
  
  //turn ant
  if(bIsReletive) {
    //turn by amount
    ant_d += ruleset[r].direction;
    ant_d %= 4;
  } else {
    //point to new position
    ant_d = ruleset[r].direction;
  }
  
  //change cell
  image.beginDraw();
  image.set(ant_x,ant_y,(ruleset[r].colour)?cColor:cBg);
  image.endDraw();
  
  //change ant state
  ant_s = ruleset[r].state;
  
  //move ant
  switch(ant_d) {
    case 0://north
      ant_y-=1;
      break;
    case 1://east
      ant_x+=1;
      break;
    case 2://south
      ant_y+=1;
      break;
    case 3://west
      ant_x-=1;
      break;
  }
  
  //map grid onto a torus
  if(ant_x<0)ant_x=width-1;
  if(ant_x==width)ant_x=0;
  if(ant_y<0)ant_y=height-1;
  if(ant_y==height)ant_y=0;
  
  //draw image
  image(image,0,0);
}

class Rule {
  boolean colour;
  int direction;
  boolean state;
  
  Rule(boolean c,int d, boolean s) {
    this.colour = c;
    this.direction = d;
    this.state = s;
  }
  String toString() {
    return "color: "+this.colour+", direction:"+this.direction+", state:"+this.state;
  }
}

String hashRuleset() {
  String value = hashRule(initState);
  for(int i=0;i<ruleset.length;i++) {
    value += hashRule(ruleset[i]);
  }
  return value;
}
String hashRule(Rule rule) {
    int val = int(rule.state);
    val += ((rule.direction|3)<<1);//ensure any extra bits are stripped out
    val += (int(rule.colour)<<3);
    return hex(val,1);
}
Rule[] unhashRuleset(String hash) {
  initState = unhashRule(str(hash.charAt(0)));
  hash = hash.substring(1);
  Rule[] set = new Rule[hash.length()];
  while(hash.length()>0) {
    set[set.length-hash.length()] = unhashRule(str(hash.charAt(0)));
    hash = hash.substring(1);
  }
  return set;
}
Rule unhashRule(String hexRule) {
  int hex = unhex(hexRule);
  
  boolean c = (hex&1)==1;
  int d = (hex&(3<<1))>>1;
  boolean s = ((hex>>3)&1)==1;
  
  return new Rule(c,d,s);
}
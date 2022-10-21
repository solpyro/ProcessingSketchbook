//State<<1 & Color = Action Selection
//SC_Action1_Action2_Action3_Action4
//Action = WriteColor, Turn, NewState
//Turn = NoTurn, Right, UTurn, Left  (0123)
//Alt  = North, East, South, West    (0123)

//65536 (2^16) possible configurations for each turn set
//possibly encode the rule over 2 bytes:
//S D  C|S D  C|S D  C|S D  C
//0 00 0|0 00 0|0 00 0|0 00 0
//Rule can be sored as 5-fig hex number, including init state for turmite:
//Init 11 10 01 00
//A    4  D  E  F

//1010 0011 0110 0011 0110
//8A6A6
PGraphics image;
color cBg, cColor, cAnt;

boolean bIsRelative = true;
boolean bDrawAnt = true;
int seedCount = 500;

int ant_x, ant_y, ant_d;
boolean ant_s;

Rule initState;
Rule[] ruleset;

void setup() {
  size(512, 512);

  //initilise colours
  cBg = color(0);
  cColor = color(255);
  cAnt = color(0, 255, 0);

  //create initial image
  image = createGraphics(width, height);

  //create ruleset - unhashRuleset can take a boolean as a second argument to override isRelative, but non-relative is pretty dull 
  //ruleset = unhashRuleset("03636");//Langton's Ant
  ruleset = unhashRuleset("0BE10");
  //ruleset = unhashRuleset("0FEB6");
  //ruleset = unhashRuleset("0BA19");
  //ruleset = unhashRuleset("19A56");
  //ruleset = unhashRuleset("1FA63");
  //ruleset = unhashRuleset("07A73");

  /*/
  String hash = hex(round(random(1048575)), 5);
  println(hash);
  ruleset = unhashRuleset(hash);
  //Random 73671,43C0A,95A6F,75E12,B7868,F7C09,C7C30,D7D28,2867D,F90D6,D9A72,09BFA,8AF50,AB722,5BE00,4D263,4EB7A,BEFBE,4F813,AFAF2
  //Static shapes D8E34,E9D62,59D69
  //Binary counter C0A9A,F0CF8,41236,D1247,516BA,B1DF8,430AD,370E1,078B8,F7F9E,516BA,59812,0A574,4E512
  //Roads F1BF4,95A6F,47850,C851B,0922C,FAE14,8BD7E,9F121,DF421,AC492
  //Total painter E1B57
  //Spiral 594F2,DA7D0

  //82B5C,1A972
  /*//*
   ruleset = unhashRuleset("4F813");
   //*/

  //initilise ant
  ant_x = width/2;
  ant_y = height/2;
  ant_s = initState.state;
  ant_d = initState.direction; 


  image.beginDraw();
  image.background(cBg);
  image.set(ant_x, ant_y, (initState.colour)?cColor:cBg);
  /*
  //seed with random data
   for(int i=0;i<seedCount;i++) {
   image.set(round(random(width)),round(random(height)),cColor);
   }
   */
  image.endDraw();
  image(image, 0, 0);
}

void draw() {
  //select rule
  color temp = image.get(ant_x, ant_y);
  int r = (int(ant_s)<<1)+int(temp==cColor);

  //turn ant
  if (bIsRelative) {
    //turn by amount
    ant_d += ruleset[r].direction;
    ant_d %= 4;
  } else {
    //point to new position
    ant_d = ruleset[r].direction;
  }

  //change cell
  image.beginDraw();
  image.set(ant_x, ant_y, (ruleset[r].colour)?cColor:cBg);
  image.endDraw();

  //change ant state
  ant_s = ruleset[r].state;

  //draw image
  image(image, 0, 0);
  if (bDrawAnt)
    set(ant_x, ant_y, cAnt);

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
  if (ant_x<0)ant_x=width-1;
  if (ant_x==width)ant_x=0;
  if (ant_y<0)ant_y=height-1;
  if (ant_y==height)ant_y=0;
}

void keyPressed() {
  switch(key) {
  case ' ':
    bDrawAnt = !bDrawAnt;
    break;
  case 'p':
    saveFrame(hashRuleset()+"-"+frameCount+".png");
    break;
  }
}

class Rule {
  boolean colour;
  int direction;
  boolean state;

  Rule(boolean c, int d, boolean s) {
    this.colour = c;
    this.direction = d;
    this.state = s;
  }
}

String hashRuleset() {
  String value = hashRule(initState);
  for (int i=0; i<ruleset.length; i++) {
    value += hashRule(ruleset[i]);
  }
  return value;
}
String hashRule(Rule rule) {
  int val = int(rule.colour);
  val += ((rule.direction&3)<<1);//ensure any extra bits are stripped out
  val += (int(rule.state)<<3);
  return hex(val, 1);
}
Rule[] unhashRuleset(String hash, boolean isRelative) {
  bIsRelative = isRelative;
  return unhashRuleset(hash);
}
Rule[] unhashRuleset(String hash) {
  initState = unhashRule(str(hash.charAt(0)));
  hash = hash.substring(1);
  Rule[] set = new Rule[hash.length()];
  while (hash.length()>0) {
    set[set.length-hash.length()] = unhashRule(str(hash.charAt(0)));
    hash = hash.substring(1);
  }
  return set;
}
Rule unhashRule(String hexRule) {
  int hex = unhex(hexRule);

  boolean c = (hex&1)==1;
  int d = (hex&6)>>1;
  boolean s = ((hex>>3)&1)==1;

  return new Rule(c, d, s);
}
final float ROOT_3 = sqrt(3);

int[] sizes = {
  //2,
  //3,
  4,
  5,
  7,
  10,
  //20,
  //25,
  //50,
  //100
};
String[][] images = {
  // FILMS  4,5,7,10
  //{"2001aspaceoddyssey", "png"},
  //{"bladerunner", "png"},
  //{"blazingsaddles", "jpg"},
  //{"brave", "jpg"},
  //{"despicableme", "jpg"},
  //{"eventhorizon", "jpg"},
  //{"gremlins", "jpg"},
  //{"insideout", "jpg"},
  //{"minions", "jpg"},
  //{"scarface", "jpg"},
  //{"shrek", "jpg"},
  //{"starwars", "jpg"},
  //{"thebeach", "jpg"},
  //{"thefifthelement", "jpg"},
  //{"toystory3", "jpg"},
  //{"up", "jpg"},
  //{"walle", "jpg"},
  //{"ratatouille", "jpg"},
  //{"theincredibles", "jpg"},
  //{"armageddon", "jpg"},
  //{"fearandloathinginlasvegas", "jpg"},
  //{"gravity", "jpg"},
  //{"hellboy", "jpg"},
  //{"it", "jpg"},
  //{"labyrinth", "jpg"},
  //{"thedarkcrystal", "jpg"},
  //{"tremors", "jpg"},
  //{"vertigo", "jpg"},
  //{"iceage", "jpg"},
  //{"onehundredandonedalmations", "jpg"},
  //{"cars", "jpg"},
  //{"howtotrainyourdragon", "jpg"},
  //{"kungfupanda", "jpg"},
  //{"madagascar", "jpg"},
  //{"monstersinc", "jpg"},
  //{"spacejam", "jpg"},
  //{"theneverendingstory", "jpg"},
  //{"topgun", "jpg"},
  {"detectivepikachu", "jpg"},
  {"madmaxfuryroad", "jpg"},
  {"missionimpossible", "jpg"},
  {"themartian", "jpg"},
  {"thenightmarebeforechristmas", "jpg"},
  // ANIMALS 4,5,7,10
  //{"capybara", "jpg"},
  //{"caribbeanflamingo", "jpg"},
  //{"goldenmantella", "jpg"},
  //{"greathornbill", "jpg"},
  //{"humboldtpenguin", "jpg"},
  //{"komododragon", "jpg"},
  //{"redpanda", "jpg"},
  //{"sumatranorangutan", "jpg"},
  //{"twotoedsloth", "jpg"},
  //{"warthog", "jpg"},
  //{"bluefootedbooby", "jpg"},
  //{"highlandcow", "jpg"},
  //{"pangolin", "jpg"},
  //{"aardvark","jpg"},
  //{"ayeaye","jpg"},
  //{"greaterhedghoghenric","jpg"},
  //{"hyacinthmacaw","jpg"},
  //{"mandrill","jpg"},
  //{"easternbongo","jpg"},
  //{"giantanteater","jpg"},
  //{"meerkat","jpg"},
  //{"redruffedlemur","jpg"},
  // MUSIC
  //{"dookie-greenday", "jpg"},
  //{"nevermind-nirvana", "jpg"},
  //{"mezzanine-massiveattack", "png"},
  // GAMES
  //{"bioshockinfinite", "jpg"},
  //{"fallout", "jpg"},
  //{"godofwar", "jpg"},
  //{"halflife", "jpg"},
  //{"halo", "jpg"},
  //{"reddeadredemption", "jpg"},
  //{"simcity2000", "png"},
  //{"thelastofus", "jpg"},
  //{"tombraider", "png"},
  //{"uncharteddrakesfortune", "jpg"},
  //{"minecraft", "png"},
  //{"portal2", "jpg"},  
  // BOOKS
  //{"harrypotterandthephilosophersstone", "jpg"},
  //{"thehobbit", "jpg"},
  // ART
  //{"soupcans", "jpg"},
  //{"starrynight", "jpg"},
};
int i;

void setup() {
  size(500,130);
  i = 0;
  fill(0,128,0);
  noStroke();
}
  
void draw() {
  String[] image = images[i];
  PImage in = loadImage(image[0]+"."+image[1]); 
    
  for(int gridSize : sizes) {
    //swirlGrid(in, gridSize).save("data/"+image[0]+"_swirlgrid_"+gridSize+".jpg");
    swirlGridPacked(in, gridSize).save("data/"+image[0]+"_swirlpackedgrid_"+gridSize+".jpg");
  }
  
  if(++i<images.length)
    rect(0,0,i*(width/images.length),height);
  else
    exit();
}

PGraphics swirlGrid(PImage pIn, int gridSize) {
  int swirlR,xInit,yInit,xStep,yStep,xCount,yCount;
  if(pIn.width<pIn.height) {
    xCount = gridSize;
    swirlR = int(pIn.width/(2*gridSize));
    yCount = int(pIn.height/(2*swirlR));
  } else {
    yCount = gridSize;
    swirlR = int(pIn.height/(2*gridSize));
    xCount = int(pIn.width/(2*swirlR));
  }
  xStep = pIn.width/xCount;
  xInit = xStep/2;
  yStep = pIn.height/yCount;
  yInit = yStep/2;
  
  PGraphics pOut = createGraphics(pIn.width,pIn.height);
  pOut.beginDraw();
  pOut.image(pIn,0,0);
  pOut.endDraw();
  for(int x=0; x<xCount; x++) {
    for(int y=0;y<yCount;y++) {
      pOut = drawSwirl(
        new PVector(
          xInit+(x*xStep),
          yInit+(y*yStep)
        ), 
        swirlR, 
        (x%2==0^y%2==0)?1:-1, 
        pOut
      );
    }
  }
  
  return pOut;
}

PGraphics swirlGridPacked(PImage pIn, int gridSize) {
  int
    xCount = gridSize,
    swirlR = int(pIn.width/(2*gridSize)),
    xStep = swirlR*2,
    xInit = xStep/2,
    yStep = int(ROOT_3*swirlR),
    yInit = yStep/2,
    yCount = ceil(pIn.height/float(yStep));
  
  PGraphics pOut = createGraphics(pIn.width,pIn.height);
  pOut.beginDraw();
  pOut.image(pIn,0,0);
  pOut.endDraw();
  for(int y=0;y<yCount;y++) {
    int
      _xCount = xCount,
      _xInit = xInit;
    if(y%2==0) {
      _xCount += 1;
      _xInit = 0;
    }
    for(int x=0; x<_xCount; x++) {
      pOut = drawSwirl(
        new PVector(
          _xInit+(x*xStep),
          yInit+(y*yStep)
        ), 
        swirlR, 
        (x%2==0^y%2==0)?1:-1, 
        pOut
      );
    }
  }
  
  return pOut;
}
  
PGraphics drawSwirl(PVector c, int r, int dir, PGraphics pIn) {
  PGraphics pOut = createGraphics(pIn.width, pIn.height);
  pOut.beginDraw();
  pOut.image(pIn,0,0);
  
  PVector p = new PVector();
  for(int x = max(0, round(c.x-r));x<=min(pIn.width-1,c.x+r);x++) {
    for(int y = max(0, round(c.y-r));y<=min(pIn.height-1,c.y+r);y++) {
      p.set(x,y);
      float d = p.dist(c);
      if(d<r) {
        p.sub(c).rotate(dir*PI*(r-d)/r).add(c);
        pOut.set(x,y,pIn.get(constrain(round(p.x),0,pIn.width-1),constrain(round(p.y),0,pIn.height-1)));
      }
    }
  }
  
  pOut.endDraw();
  return pOut; 

}

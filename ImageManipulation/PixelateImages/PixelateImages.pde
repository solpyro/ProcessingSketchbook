int[] sizes = {
  10,
  20,
  //25,
  //40,
  50,
  100
};
String[][] images = {
  // ARCITECTURE
  //{"colesseum", "jpg"},
  //{"eiffeltower", "jpg"},
  //{"eiffeltower2", "jpg"},
  //{"elizabethtower", "jpg"},
  //{"elizabethtower2", "jpg"},
  //{"sydneyoperahouse", "jpg"},
  //{"tajmahal", "jpg"},
  //{"tajmahal2", "jpg"},
  // ART 50, 100
  //{"monalisa", "jpg"},
  //{"pearlearring", "jpg"},
  //{"starrynight", "jpg"},
  //{"thescream", "jpg"},
  //{"soupcans", "jpg"},
  // GAMES 20, 50
  //{"bioshock", "jpg"},
  //{"ico", "jpg"},
  //{"minecraft", "png"},
  //{"portal2", "jpg"},
  //{"sonic2", "jpg"},
  //{"worldofwarcraft", "jpg"},
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
  // ALBUMS 20, 25
  //{"abbeyroad", "jpg"},
  //{"darksideofthemoon", "png"},
  //{"masterofpuppets", "jpg"},
  //{"screamadelica", "jpg"},
  //{"ledzeppelin","png"},
  //{"sgtpepperslonelyheartclubband","jpg"},
  //{"thevelvetundergroundandnico","jpg"},
  //{"demondays","png"},
  // FILMS 10, 20
  //{"findingnemo", "jpg"},
  //{"homealone", "jpg"},
  //{"maleficent", "jpg"},
  //{"thematrix", "jpg"},
  //{"jurassicpark", "jpg"},
  //{"2001aspaceoddyssey","png"},
  //{"aclockworkorange","png"},
  //{"pulpfiction","jpg"},
  //{"scarface","jpg"},
  //{"avatar","jpg"},
  //{"titanic", "png"},
  //{"thesilenceofthelambs", "jpg"},
  //{"shaunofthedead", "jpg"},
  //{"amélie", "jpg"},
  //{"bladerunner", "png"},
  //{"ettheextraterrestrial", "jpg"},
  //{"jaws", "jpg"},
  //{"Harry_Potter_and_the_Chamber_of_Secrets_movie", "jpg"},
  //{"Harry_Potter_and_the_Deathly_Hallows_–_Part_1", "jpg"},
  //{"Harry_Potter_and_the_Deathly_Hallows_–_Part_2", "jpg"},
  //{"Harry_Potter_and_the_Goblet_of_Fire_Poster", "jpg"},
  //{"Harry_Potter_and_the_Half-Blood_Prince_poster", "jpg"},
  //{"Harry_Potter_and_the_Order_of_the_Phoenix_poster", "jpg"},
  //{"Harry_Potter_and_the_Philosopher's_Stone_banner", "jpg"},
  //{"Prisoner_of_azkaban_UK_poster", "jpg"},
  //{"blazingsaddles", "jpg"},
  //{"brave", "jpg"},
  //{"despicableme", "jpg"},
  //{"eventhorizon", "jpg"},
  //{"gremlins", "jpg"},
  //{"insideout", "jpg"},
  //{"shrek", "jpg"},
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
  // DOGS 10, 20
  //{"bassethound", "jpg"},
  //{"bernesemountaindog", "jpg"},
  //{"corgi", "jpg"},
  //{"dalmation", "jpg"},
  //{"dalmations", "jpg"},
  //{"englishspringerspaniel", "jpg"},
  //{"shetlandsheepdog", "jpg"},
  //{"shihtzu", "jpg"},
  // DOGS 50, 100
  //{"oldenglishsheepdog", "jpg"},
  //{"pug", "jpg"},
  //{"tibetanmastiff", "jpg"},
  // ANIMALS
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
  {"easternbongo","jpg"},
  {"giantanteater","jpg"},
  {"meerkat","jpg"},
  {"redruffedlemur","jpg"},
  // BOOKS 10, 20
  //{"harrypotterandthephilosophersstone", "jpg"},
  //{"thehobbit", "jpg"},
};
int i;

void setup() {
  size(500,120);
  i = 0;
  fill(0,128,0);
  noStroke();
}
  
void draw() {
  String[] image = images[i];
  PImage in = loadImage(image[0]+"."+image[1]); 
    
  for(int pixelSize : sizes)
    pixelate(in, pixelSize).save("data/"+image[0]+"_"+pixelSize+".jpg");
  
  if(++i<images.length)
    rect(0,0,i*(width/images.length),height);
  else
    exit();
}


PGraphics pixelate(PImage pIn, int pixelSize) {
  PGraphics pg = createGraphics(pIn.width, pIn.height);
  pg.beginDraw();
  pg.noStroke();
  
  for(int x=0; x<pIn.width;x+=pixelSize) {
    for(int y=0; y<pIn.height;y+=pixelSize) {
      int tileW = min(pixelSize, pIn.width-x);
      int tileH = min(pixelSize, pIn.height-y);
      PImage tile = pIn.get(x,y,tileW,tileH);
      pg.fill(averageColor(tile.pixels));
      pg.rect(x,y,tileW,tileH);
    }
  }
  
  pg.endDraw();
  return pg;
}

color averageColor(color[] arr) {
  int r=0,g=0,b=0;
  
  for(color c : arr) {
    r += c >> 020 & 0xFF;
    g += c >> 010 & 0xFF;
    b += c        & 0xFF;
  }
  
  r /= arr.length;
  g /= arr.length;
  b /= arr.length;
  
  return color(r,g,b);
}

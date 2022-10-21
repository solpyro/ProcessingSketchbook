Filter g3_5, /*g7_4, g35_8,*/ s, m60_10_0, i, bu60, m0, bl, e, mb60;
PImage img;

void setup() {
  //build screen of correct size & load image
  size(320, 240);
  img = loadImage("photo3.jpg");
  
  //size(664, 960);
  //img = loadImage("data/12108848_10153626174309320_2557837029634148967_n.jpg");
  
  //size(415, 300);
  //img = loadImage("data/aerialviewofgarden.jpg");
  
  
  //generate filters
  g3_5 = new GaussFilter(3,.5);
  //g7_4 = new GaussFilter(7,4.0);
  s = new SharpenFilter();
  m60_10_0 = new MonochromeFilter(color(62,10,0));
  i = new InverseFilter();
  bu60 = new BumpFilter(60);//degrees
  m0 = new MonochromeFilter();
  bl = new BloomFilter(3,240);
  e = new EdgeFilter();//n=1, e=4, s=16, w=64
  mb60 = new MotionBlurFilter(0);
  
  //display inital image
  image(img,0,0);
}

void keyPressed() {
  switch(key) {
    case '1':
      image(img,0,0);
      break;
    case '2':
      image(g3_5.applyFilter(img),0,0);
      break;
    case 'w':
      image(mb60.applyFilter(img),0,0);
      break;
    case '3':
      //image(g7_4.applyFilter(img),0,0);
      break;
    case '4': //This doesn't work well...
      image(s.applyFilter(img),0,0);
      break;
    case '5':
      image(m60_10_0.applyFilter(img),0,0);
      break;
    case '6':
      image(i.applyFilter(img),0,0);
      break;
    case '7':
      image(bu60.applyFilter(img),0,0);
      break;
    case 'u':
      image(m0.applyFilter(bu60.applyFilter(img)),0,0);
      break;
    case '8':
      image(bl.applyFilter(img),0,0);
      break;
    case '9':
      image(e.applyFilter(g3_5.applyFilter(m0.applyFilter(img))),0,0);
      break;
    case 'o':
      image(e.applyFilter(m0.applyFilter(img)),0,0);
      break;
    case 'l':
      image(e.applyFilter(g3_5.applyFilter(img)),0,0);
      break;
  }
}

void draw() {
  
}
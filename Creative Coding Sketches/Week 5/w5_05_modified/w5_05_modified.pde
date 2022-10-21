/*
 * Creative Coding
 * Week 5, 05 - Text agents
 * by Indae Hwang and Jon McCormack
 * Copyright (c) 2014 Monash University
 *
 * This sketch creates a simple agent-based simulation using text and objects
 * The sketch reads in characters from the keyboard and dynamically creates
 * new objects for each character.
 *
 */
ArrayList<AniCharacter> aniChars;

PFont myFont;

int currentWord;
color[] wordColors;

void setup() {
  size(700, 700);
  myFont = loadFont("HelveticaNeue-UltraLight-200.vlw");
  textFont(myFont);
  //textMode(SHAPE);
  
  currentWord = 1;
  wordColors = new color[20];
  wordColors[0]  = color(#6e0053);
  wordColors[1]  = color(#965e00);
  wordColors[2]  = color(#072d63);
  wordColors[3]  = color(#6c8e00);
  wordColors[4]  = color(#842d6e);
  wordColors[5]  = color(#b3863d);
  wordColors[6]  = color(#074498);
  wordColors[7]  = color(#8eaa3a);
  wordColors[8]  = color(#aa0080);
  wordColors[9]  = color(#e79000);
  wordColors[10] = color(#2f4d76);
  wordColors[11] = color(#a6db00);
  wordColors[12] = color(#e500ac);
  wordColors[13] = color(#ff9f00);
  wordColors[14] = color(#1167dd);
  wordColors[15] = color(#bdfa00);
  wordColors[16] = color(#db45b6);
  wordColors[17] = color(#ffbd50);
  wordColors[18] = color(#4e85d0);
  wordColors[19] = color(#cff84e);
  
  aniChars = new ArrayList<AniCharacter>();

  //smooth(8); // enable antialiasing
}


void draw() {

  background(255);

  for (int i = aniChars.size()-1; i >= 0; i--) {
    AniCharacter tempObj = aniChars.get(i);
    tempObj.run(aniChars); // run each char
  }
}


void keyReleased() {
  //restrict the key presses to stop broken AniCharacters being added to the list
  if (8 == int(key) && aniChars.size() > 0) {
    if(currentWord!=aniChars.get(aniChars.size()-1).word)
      //delete space
      currentWord--;
    else {
      //delete the latest character
      println("deleted "+aniChars.get(aniChars.size()-1).letter);
      aniChars.remove(aniChars.size()-1);
    }
  } else if(32 == int(key)) {
   //add a space
    currentWord++;
    println("word "+currentWord);
  } else if((int(key)>=33&&int(key)<=126)||  //[!"#$%&'()*+,-./0-9:;<=>?@A-Z[\]^_`a-z{|}~]
            (int(key)==8364)||               //€
            (int(key)==163)||                //£
            (int(key)==166)||                //¦
            (int(key)==172)) {               //¬
    //add the new character
    aniChars.add( new AniCharacter(random(width), random(height), key, currentWord, wordColors[currentWord%wordColors.length]) );
    println(int(key)+" ("+key+") created");
  } else if((keyCode>=16&& keyCode<=18)||  //[ctrl|alt|sft]
            (keyCode>=112&& keyCode<=123)|| //[f1-f12]
            (int(key)==127)||              //del
            (keyCode>=9&& keyCode<=10)) {  //[\t\n]
    //ignore these keys
  } else {
    //println(char(123));
    println(int(key)+" ("+key+") not recognised");
  }
}


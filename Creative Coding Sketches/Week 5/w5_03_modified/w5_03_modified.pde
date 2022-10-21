/*
 * Creative Coding
 * Week 5, 03 - Moving balls
 * by Indae Hwang and Jon McCormack
 * Copyright (c) 2014 Monash University
 *
 * This sketch shows the basics of classes and objects in Processing
 * It defines a class called "Ball" with member functions that move and display
 *
 */

/* @pjs preload="CourierNewPSMT-48.vlw"; */

// declare array of Balls
Ball theBalls[];
int numBalls = 100;

//0001(1) = draw balls
//0010(2) = vector arrow
//0100(4) = vector text
//1000(8) = draw to image
int iDisplayType = 11;

PFont myFont;
PGraphics myImage;

void setup() {
  size(500, 500);
  
  //load the font
  myFont = loadFont("CourierNewPSMT-48.vlw");
  textFont(myFont);
  textSize(15);
  
  //prepare the image
  myImage = createGraphics(width, height);
  myImage.beginDraw();
  myImage.background(0);
  myImage.stroke(255,20);
  myImage.endDraw();
  
  // initialise array and fill it with balls
  theBalls = new Ball[numBalls];
  for (int i = 0; i < numBalls; ++i) {
    float ballSize = constrain(20 + (randomGaussian() * 4), 1, 100);
    theBalls[i] = new Ball(random(width), random(height), ballSize, myImage);
    theBalls[i].randomiseDirection();
  }
  background(0);
}

void draw() {
  //background(0);
  myImage.beginDraw();
  for (int i = 0; i < numBalls; ++i) {
    theBalls[i].move(iDisplayType);
  }
  myImage.endDraw();
  
  image(myImage, 0, 0);
  
  for (int i = 0; i < numBalls; ++i) { 
    theBalls[i].display(iDisplayType);
  }
}  

void keyPressed() {
  switch(key) {
    case '1':
      if ((iDisplayType&1)>0) {
        //unset 1
        iDisplayType -= 1;
      } else {
        //set 1
        iDisplayType += 1;
      }
      break;
    case '2':
      if ((iDisplayType&2)>0) {
        //unset 1
        iDisplayType -= 2;
      } else {
        //set 1
        iDisplayType += 2;
      }
      break;
    case '3':
      if ((iDisplayType&4)>0) {
        //unset 1
        iDisplayType -= 4;
      } else {
        //set 1
        iDisplayType += 4;
      }
      break;
    case '4':
      if ((iDisplayType&8)>0) {
        //unset 1
        iDisplayType -= 8;
      } else {
        //set 1
        iDisplayType += 8;
      }
      break;
  }
}

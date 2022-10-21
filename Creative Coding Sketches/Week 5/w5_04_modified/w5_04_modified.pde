/*
 * Creative Coding
 * Week 5, 04 - Moving balls 2
 * by Indae Hwang and Jon McCormack
 * Copyright (c) 2014 Monash University
 *
 * This sketch shows the basics of classes and objects in Processing
 * It defines a class called "Ball" with one member function: "display()"
 *
 */
MovingBall centre;
MovingBall[] arounds;

int numOfObjects;
int currentObj;

void setup() {
  size(600, 600);

  numOfObjects = 100;
  currentObj = 0;
  
  centre = new MovingBall(width/2, height/2);

  arounds = new MovingBall[numOfObjects];

  for (int i=0; i < arounds.length; i++ ) {
    arounds[i] = new MovingBall();
  }

  background(0);
}

void draw() {
  // background(0);

  centre.run();

  for (int i=0; i < arounds.length; i++ ) {
    arounds[i].run();
  }
}

void keyPressed() {
  switch(key) {
    case '+':
      background(0);
      centre.updateDirections(1);
      centre.begin(width/2, height/2);
      for (int i=0; i < arounds.length; i++ ) {
        arounds[i].updateDirections(1);
        arounds[i].reset();
      }
      break;
    case '-':
      background(0);
      centre.updateDirections(-1);
      centre.begin(width/2, height/2);
      for (int i=0; i < arounds.length; i++ ) {
        arounds[i].updateDirections(-1);
        arounds[i].reset();
      }
      break;
    case '\n':
      for (int i=0; i < arounds.length; i++ )
        arounds[i].recall();
      currentObj = 0;
      break;
    default:
      //do nothing
      println(key);
  }
}

void mouseClicked() {
  arounds[currentObj].begin(float(mouseX),float(mouseY));
  currentObj = ++currentObj%numOfObjects;
}

PGraphics board;
Shark[] shark;
Fish[] fish;

int sharkLife = 10; //10 steps before a shark dies
int sharkBreed = 10; //10 steps before a shark reproduces
int fishBreed = 10; //10 steps before a fish reproduces
int fishEnergy = 2; //10 steps added to a shark's life when it eats a fish

int initShark = 2048;
int initFish = 4096;

color cShark = color(255, 0, 0);
color cFish = color(0, 255, 0);
color cWater = color(0, 0, 0);

void setup() {
  size(256, 256);

  background(cWater);

  //init arrays
  fish = new Fish[0];
  shark = new Shark[0];

  //seed shark and fish arrays
  for (int i=0; i<initFish; i++) {
    fish = (Fish[])splice(fish, new Fish(), fish.length); 
    set(fish[i].x, fish[i].y, cFish);
  }
  for (int i=0; i<initShark; i++) {
    shark = (Shark[])splice(shark, new Shark(), shark.length); 
    set(shark[i].x, shark[i].y, cShark);
  }
}

void draw() {
  //move fish
  for (int i=0; i<fish.length; i++) {
    //update breed counter
    fish[i].breedCounter++;
    //find space to move to
    Point[] neighbours = fish[i].findSpace();
    if (neighbours.length>0) {
      //give breed birth
      if (fish[i].breedCounter==fishBreed) {
        fish = (Fish[])splice(fish, new Fish(fish[i].x, fish[i].y), i);
        i++;
      }
      //update position
      int n = floor(random(neighbours.length));
      fish[i].x = neighbours[n].x;
      fish[i].y = neighbours[n].y;
    }
    //revert counter
    if (fish[i].breedCounter==fishBreed)
      fish[i].breedCounter = 0;
  }

  //move sharks
  for (int i=0; i<shark.length; i++) {
    //update counters
    shark[i].breedCounter++;
    shark[i].health--;
    
    if(shark[i].health!=0) {
      int oldX = shark[i].x;
      int oldY = shark[i].y;
      //find fish to eat
      Point[] fishNeighbours = shark[i].findFish();
      if (fishNeighbours.length>0) {
        int n = floor(random(fishNeighbours.length));
        shark[i].x = fishNeighbours[n].x;
        shark[i].y = fishNeighbours[n].y;
        removeFish(fishNeighbours[n].x, fishNeighbours[n].y);
        shark[i].health += fishEnergy;
        shark[i].health = min(sharkLife,shark[i].health);
      } else {
        Point[] openNeighbours = shark[i].findSpace();
        //find space to move to
        if (openNeighbours.length>0) {
          int n = floor(random(openNeighbours.length));
          shark[i].x = openNeighbours[n].x;
          shark[i].y = openNeighbours[n].y;
        }
      }
      //give birth
      if (shark[i].breedCounter == sharkBreed) {
        if (shark[i].x!=oldX && shark[i].y!=oldY) {
          shark = (Shark[])splice(shark, new Shark(oldX, oldY), i);
          i++;
        }
        shark[i].breedCounter = 0;
      }
    } else {
      arrayCopy(shark, i+1, shark, i, shark.length-(i+1));
      shark = (Shark[])shorten(shark);
      i--;
    }
  }

  //draw image
  background(cWater);
  for (int i=0; i<fish.length; i++) {
    set(fish[i].x, fish[i].y, cFish);
  }
  for (int i=0; i<shark.length; i++) {
    set(shark[i].x, shark[i].y, cShark);
  }

  //println("sharks: "+shark.length+", fish: "+fish.length);

  if (fish.length==0 && shark.length==0)
    noLoop();
}

boolean isEmpty(int x, int y) {
  for (int i=0; i<shark.length; i++) {
    if (shark[i].x==x && shark[i].y==y)
      return false;
  }
  for (int i=0; i<fish.length; i++) {
    if (fish[i].x==x && fish[i].y==y)
      return false;
  }
  return true;
}

void removeFish(int x, int y) {
  for (int i=0; i<fish.length; i++) {
    if (fish[i].x==x && fish[i].y==y) {
      arrayCopy(fish, i+1, fish, i, fish.length-(i+1));
      fish = (Fish[])shorten(fish);
    }
  }
}

class Creature {
  int x, y, breedCounter;

  void setPosition() {
    //find an empty space for the creature
    do {
      this.x = int(random(width));
      this.y = int(random(height));
    } while (!isEmpty(this.x, this.y));
  }
  Point[] findSpace() {
    Point[] p = new Point[0];
    for (int i=this.x-1; i<this.x+2; i++) {
      for (int j=this.y-1; j<this.y+2; j++) {
        if (i!=this.x&&j!=this.y) {
          int _i = (i<0)?width-1:(i==width)?0:i;
          int _j = (j<0)?height-1:(j==height)?0:j;
          if (isEmpty(_i, _j)) {
            p = (Point[])splice(p, new Point(_i, _j), p.length);
          }
        }
      }
    }
    return p;
  }
}
class Shark extends Creature {
  int health;

  Shark() {
    this.setPosition();
    this.health = sharkLife;
    //initilise the breed counter
    this.breedCounter = int(random(sharkBreed));
  }
  Shark(int x, int y) {
    this.x = x;
    this.y = y;
    this.health = sharkLife;
    //initilise the breed counter
    this.breedCounter = int(random(sharkBreed));
  }
  Point[] findFish() {
    Point[] p = new Point[0];
    for (int i=this.x-1; i<this.x+2; i++) {
      for (int j=this.y-1; j<this.y+2; j++) {
        if (i!=this.x&&j!=this.y) {
          int _i = (i<0)?width-1:(i==width)?0:i;
          int _j = (j<0)?height-1:(j==height)?0:j;
          for (int k=0; k<fish.length; k++) {
            if (fish[k].x==_i && fish[k].y==_j)
              p = (Point[])splice(p, new Point(_i, _j), p.length);
          }
        }
      }
    }
    return p;
  }
}
class Fish extends Creature {
  Fish() {
    this.setPosition();

    //initilise the breed counter
    this.breedCounter = int(random(fishBreed));
  }
  Fish(int x, int y) {
    this.x = x;
    this.y = y;

    //initilise the breed counter
    this.breedCounter = int(random(fishBreed));
  }
}

class Point {
  int x, y;

  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
}
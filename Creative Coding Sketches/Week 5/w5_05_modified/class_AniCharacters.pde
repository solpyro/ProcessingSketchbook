// AniCharacter class
//
// 
class AniCharacter {

  float x, y;
  float nOff_x;
  float nOff_y;
  float dynamic;
  float dynamic_c;
  float size_font;
  float size_shape;
  char letter;
  int word;
  color wordColor;
  int speed;

  AniCharacter(float x_, float y_, char c_, int word_, color wordColor_) {

    x = x_;
    y = y_;
    nOff_x = 0;//random(3000);
    nOff_y = 0;//random(3000);

    letter = c_;
    word = word_;
    wordColor = wordColor_;

    // speed of motion
    speed = 4;

    size_font = random(50, 200);
    size_shape = size_font + random(10, 50);
    dynamic_c = random(-0.1, 0.1);
  }

  void run(ArrayList<AniCharacter> aniChrs) {

    switch(letter) {
    case '!':case '"':case '£':case '$':case '%':case '^': case '&':case '*':
    case '(':case ')':case '_':case '-':case '+':case '=': case '{':case '[':
    case '}':case ']':case ':':case ';':case '@':case '\'':case '~':case '#':
    case '<':case ',':case '>':case '.':case '?':case '/': case '|':case '\\':
    case '`':case '¬':case '¦':case '€':
      dynamic += dynamic_c*4;
      break;
    case 'g':case 'G':
    case 'l':case 'L':
    case 'o':case 'O':
    case 'r':case 'R':
    case 's':case 'S':
    case 'u':case 'U':
      dynamic += dynamic_c*0.5;
      break;
    default:
      dynamic += dynamic_c;
    }

    //implement gravity!
    for (int i = 0; i<aniChrs.size (); i++) {
      if (aniChrs.get(i)!=this) {
        if (aniChrs.get(i).word==this.word) {
          float fDist = dist(aniChrs.get(i).x, aniChrs.get(i).y, this.x, this.y);
          fDist = (fDist<10*speed)?0:1/fDist;
          float fX = (aniChrs.get(i).x-this.x);
          float fY = (aniChrs.get(i).y-this.y);
          float fAtan = atan2(fY, fX);

          nOff_x += fDist*cos(fAtan);
          nOff_y += fDist*sin(fAtan);
        }
      }
    }

    x += constrain(nOff_x, -speed, speed);
    y += constrain(nOff_y, -speed, speed);
    if (x<0||x>width) {
      x = constrain(x, 0, width);
      nOff_x *= -1;
    }
    if (y<0||y>width) {
      y = constrain(y, 0, width);
      nOff_y *= -1;
    }


    visual();
  }

  /*
   * visual
   * draw the char with special cases for some letters
   */
  void visual() {

    textSize(size_font);
    float textW =  textWidth(letter);
    float ascent = textAscent() * 0.75;

    switch(letter) {
//vowels
      case 'a':case 'A':
        fill(wordColor);
        noStroke();
        text(letter, x-textW/2, y+ascent/2);
  
        stroke(wordColor);
        noFill();
        pushMatrix();
        translate(x, y);
        rotate(dynamic);
        arc(0, 0, size_shape, size_shape, HALF_PI, PI+HALF_PI);
        popMatrix();
        break;
      case 'e':case 'E':
        rectMode(CENTER);
        fill(wordColor);
        rect(x, y, textW, size_shape*sin( radians(dynamic) ));
        rectMode(CORNER);
  
        fill(255);
        noStroke();
        text(letter, x-textW/2, y+ascent/2);
        break;
      case 'i':case 'I':
        pushMatrix();
        translate(x, y);
        rotate(dynamic);
        fill(wordColor);
        noStroke();
        text(letter, -textW/2, ascent/2);
        popMatrix();
        break;
      case 'o':case 'O':
        fill(wordColor);
        noStroke();
        float fD = map(sin(dynamic),-1,1,size_shape/2,size_shape);
        ellipse(x, y, fD, fD);
  
        fill(255);
        text(letter, x-textW/2, y+ascent/2);
        break;
      case 'u':case 'U':
        textSize(size_font+map(sin(dynamic), -1, 1, -size_font*0.2, size_font*0.2));
        textW =  textWidth(letter);
        ascent = textAscent() * 0.75;
  
        fill(wordColor);
        text(letter, x-textW/2, y+ascent/2);
        break;
        
//consonents
      case 'c':case 'C':
        fill(wordColor);
        noStroke();
        text(letter, x-textW/2, y+ascent/2);
        float tempx = x + size_shape*cos(dynamic*0.5);
        float tempy = y + size_shape*sin(dynamic*0.5);
        fill(wordColor);
        stroke(wordColor, 140);
        line(x, y, tempx, tempy);
        noStroke();
        ellipse(tempx, tempy, 10, 10);
        break;
      case 'g':case 'G':
        fill(wordColor);
        noStroke();
        float dX = textW/2*sin(dynamic);
        float dY = textW/2*cos(dynamic);
        text(letter, (x+dX)-textW/2, y+dY+ascent/2);
        break;
      case 'k':case 'K':
        fill(wordColor);
        noStroke();
        pushMatrix();
        translate(x,y);
        scale(sin(dynamic),1);
        text(letter, -textW/2, ascent/2);
        popMatrix();
        break;
      case 'l':case 'L':
        fill(wordColor);
        noStroke();
        text(letter, x-textW/2, y+ascent/2);
        stroke(wordColor);
        noFill();
        pushMatrix();
        translate(x, y);
        rotate(dynamic);
        float lastX = (size_shape/2)*cos(radians(0));
        float lastY = (size_shape/2)*sin(radians(0));
        for(int i=5;i<=180;i+=5) {
          float addition = 0;
          if(i%2!=0) addition = size_shape*.1;
          float thisX = ((size_shape/2)+addition)*cos(radians(i));
          float thisY = ((size_shape/2)+addition)*sin(radians(i));
          line(lastX,lastY,thisX,thisY);
          lastX = thisX;
          lastY = thisY;
        }
        popMatrix();
        break;
      case 'm':case 'M':
        fill(wordColor);
        noStroke();
        pushMatrix();
        translate(x,y);
        scale(1+map(sin(dynamic),-1,1,0,1),1);
        text(letter, -textW/2, ascent/2);
        popMatrix();
        break;
      case 'q':case 'Q':
        fill(wordColor);
        noStroke();
        pushMatrix();
        translate(x,y);
        rotate(dynamic);
        scale(1,sin(dynamic));
        text(letter, -textW/2, ascent/2);
        popMatrix();
        break;
      case 'r':case 'R':
        pushMatrix();
        translate(x,y);
        rotate(lerp(0,HALF_PI,1-abs(sin(dynamic))));
        noStroke();
        fill(wordColor);
        text(letter, -textW/2, ascent/2);
        popMatrix();
        break;
      case 's':case 'S':
        pushMatrix();
        translate(x,y);
        rotate(constrain(lerp(0,TWO_PI*2,sin(dynamic)),0,TWO_PI));
        noStroke();
        fill(wordColor);
        text(letter, -textW/2, ascent/2);
        popMatrix();
        break;
      case 'w':case 'W':
        pushMatrix();
        translate(x,y);
        rotate(lerp(0,TWO_PI,map(sin(constrain(loopRange(dynamic,0,TWO_PI),HALF_PI,PI+HALF_PI)),-1,1,0,1)));
        noStroke();
        fill(wordColor);
        text(letter, -textW/2, ascent/2);
        popMatrix();
        break;
      case 'x':case 'X':
        fill(wordColor);
        noStroke();
        pushMatrix();
        translate(x,y);
        scale(1+map(sin(dynamic),-1,1,0,1),1+map(sin(dynamic),-1,1,1,0));
        text(letter, -textW/2, ascent/2);
        popMatrix();
        break;
      case 'y':case 'Y':
        fill(wordColor);
        noStroke();
        text(letter, x-textW/2, y+ascent/2);
        float r = size_shape*abs(sin(dynamic*0.5))/2;
        float armx = x + r*cos(dynamic*0.5);
        float army = y + r*sin(dynamic*0.5);
        fill(wordColor);
        stroke(wordColor, 140);
        line(x, y, armx, army);
        noStroke();
        ellipse(armx, army, 10, 10);
        armx = x + r*cos(dynamic*0.5+PI);
        army = y + r*sin(dynamic*0.5+PI);
        fill(wordColor);
        stroke(wordColor, 140);
        line(x, y, armx, army);
        noStroke();
        ellipse(armx, army, 10, 10);
        armx = x + r*cos(dynamic*0.5-HALF_PI);
        army = y + r*sin(dynamic*0.5-HALF_PI);
        fill(wordColor);
        stroke(wordColor, 140);
        line(x, y, armx, army);
        noStroke();
        ellipse(armx, army, 10, 10);
        armx = x + r*cos(dynamic*0.5+HALF_PI);
        army = y + r*sin(dynamic*0.5+HALF_PI);
        fill(wordColor);
        stroke(wordColor, 140);
        line(x, y, armx, army);
        noStroke();
        ellipse(armx, army, 10, 10);
        break;        

//punctuation
      case '!':case '"':case '£':case '$':case '%':case '^': case '&':case '*':
      case '(':case ')':case '_':case '-':case '+':case '=': case '{':case '[':
      case '}':case ']':case ':':case ';':case '@':case '\'':case '~':case '#':
      case '<':case ',':case '>':case '.':case '?':case '/': case '|':case '\\':
      case '`':case '¬':case '¦':case '€':
        float fAlpha = map(sin(radians(dynamic)), -1, 1, 0, 255);
        fill(color(255-red(wordColor), 255-green(wordColor), 255-blue(wordColor)), 255-fAlpha);
        text(letter, x-textW/2, y+ascent/2);
        fill(wordColor, fAlpha);
        text(letter, x-textW/2, y+ascent/2);
        break;
        
//numbers
      case '0':case '1':case '2':case '3':case '4':case '5': case '6':case '7':
      case '8':case '9':
        pushMatrix();
        fill(wordColor);
        translate(x,y);
        scale(sin(dynamic),cos(dynamic));
        text(letter, -textW/2, ascent/2);
        popMatrix();
        break;
        
//default
      default://bdfhjnptvz
        fill(wordColor,127);//these letters don't do anything
        noStroke();
        text(letter, x-textW/2, y+ascent/2);
        break;
    }

    //ellipse(x, y, 10, 10);
  }
  
  float loopRange(float val, float min, float max) {
    if(val>=min&&val<=max) return val;
    
    float fMaxMin = max-min;
    
    while(val>max) val -=fMaxMin;
    while(val<min) val +=fMaxMin;
    
    return val;
  }
}


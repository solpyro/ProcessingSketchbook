//prepare variables
int iX = 250;
int iY = 250;
int iD = 200;
int iOffset = 8;

int iR = iD/2;

//prepare canvas
size(500,500);

background(255);
stroke(0);
noFill();

//draw initial circle
ellipse(iX,iY,iD,iD);

//draw 5 intersecting circles
for(int i=0;i<5;i++) {
  ellipse(iX+((iR+iOffset)*cos(radians(72*i)+HALF_PI)),iY+((iR+iOffset)*sin(radians(72*i)+HALF_PI)),200,200);
}



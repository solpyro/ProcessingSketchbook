final int M_PARTICLE = 0;
final int M_TAIL = 1;
final int M_WIREFRAME = 99;

void drawParticle(PVector position) {
  stroke(255);
  strokeWeight(1);
  point(position.x, position.y);
}

void drawTail(Particle particle) {
  stroke(255);
  strokeWeight(2);
  line(particle.position.x,particle.position.y,particle.position.x+particle.velocity.x,particle.position.y+particle.velocity.y);
}

void drawWireframe(Particle particle) {
  //color c = color(30, 105, 0);
  color c = color(255, 255, 255);
  //draw the position
  fill(c);
  noStroke();
  circle(particle.position.x, particle.position.y, 10);

  //draw the vector
  stroke(c);
  float speed = particle.velocity.mag();
  PVector direction = particle.velocity.normalize(null);
  PVector start = PVector.add(particle.position, (PVector.mult(direction, 5)));
  //PVector endMS = PVector.add(start, (PVector.mult(d, 4*ms)));
  PVector endS = PVector.add(start, (PVector.mult(direction, 4*speed)));
  //strokeWeight(2);
  //line(start.x, start.y, endMS.x, endMS.y);
  strokeWeight(4);
  line(start.x, start.y, endS.x, endS.y);

  //draw the sense areas
  noFill();
  strokeWeight(2);
  circle(particle.position.x, particle.position.y, particle.viewRange*2);
  circle(particle.position.x, particle.position.y, particle.personalSpace*2);
}

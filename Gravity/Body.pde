float scale  = .03;

class Body {
  PVector
    position, 
    velocity, 
    gravity;
  float mass;

  Body(int maxX, int maxY) {
    position = new PVector(random(maxX), random(maxY));
    mass = random(10, 15);
    velocity = new PVector();
    gravity = new PVector();
  }

  void updateHeading(Body[] bodies) {
    if (mass==0)return;

    PVector com = new PVector();

    for (int i=0; i<bodies.length; i++) {
      if (bodies[i]==this) continue;
      if (bodies[i].mass==0) continue;

      PVector dist = ToroidalDist(position, bodies[i].position);
      if (dist.magSq()<((mass+bodies[i].mass)*(scale/2))) {
        velocity = PVector.add(
          velocity.mult(mass), 
          bodies[i].velocity.mult(bodies[i].mass)
          ).div(mass+bodies[i].mass);
        mass += bodies[i].mass;
        bodies[i].mass = 0;
        position.add(bodies[i].position).div(2);
      } else {
        PVector f = dist.normalize(null).mult((1/dist.magSq())*bodies[i].mass);
        com = com.add(f);
      }
    }

    gravity = com;
  }

  void draw() {
    if (mass==0)return;

    fill(255);
    noStroke();
    circle(position.x, position.y, PI*mass*scale);
  }

  void drawTrail(int dt, PGraphics map) {
    if (mass==0)return;

    PVector v = PVector.add(velocity, PVector.mult(gravity, dt/100));
    PVector e = PVector.add(position, v);

    map.line(position.x, position.y, e.x, e.y);
  }

  void move(int dt) {
    if (mass==0)return;

    velocity.add(gravity.div(dt));
    position.add(velocity);

    if (position.x<0)position.x += width;
    if (position.x>width)position.x -= width;
    if (position.y<0)position.y += height;
    if (position.y>height)position.y -= height;
  }
}

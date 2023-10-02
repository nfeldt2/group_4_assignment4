Planet p1;
Planet p2;

void setup() {
  size(800, 400);
  p1 = new Planet(-200, 100, 40, color(31, 61, 212), 2, 80);
  p1.satellite = new Satellite(p1, 80);
  p2 = new Planet(-200, 300, 80, color(201, 28, 12), 1, 60);
  p2.satellite = new Satellite(p2, 60);
}

void draw() {
  background(0);
  
  // planet 1 with satellite
  p1.display();
  p1.move();
  p1.satellite.display();
  p1.satellite.orbit();
  
  // planet 2 with satellite
  p2.display();
  p2.move();
  p2.satellite.display();
  p2.satellite.orbit();
}

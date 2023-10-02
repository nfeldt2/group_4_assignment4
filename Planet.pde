class Planet {
  Satellite satellite;
  float x, y, diameter, angle, speed;
  color planetColor;

  Planet(float x, float y, float diameter, color planetColor, float speed, float orbitRadius) {
    this.x = x;
    this.y = y;
    this.diameter = diameter;
    angle = 0;
    this.planetColor = planetColor;
    this.speed = speed;
    satellite = new Satellite(this, orbitRadius);
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    fill(planetColor);
    ellipse(0, 0, diameter, diameter);
    popMatrix();
  }

  void move() {
    x += speed;
    angle += radians(speed);
    if (x > width + diameter/2 + 200) {
      x = -diameter/2 - 200; // reset the position when planet is 200px off-screen
    }
  }
}

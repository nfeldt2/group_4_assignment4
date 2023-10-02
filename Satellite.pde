class Satellite {
  Planet planet;
  float orbitRadius, angle, satelliteDiameter, speed;
  color satelliteColor;

  Satellite(Planet planet, float orbitRadius) {
    this.planet = planet;
    this.orbitRadius = orbitRadius;
    angle = random(TWO_PI); // start from a random angle
    satelliteDiameter = random(10, 20);
    float grayScale = random(100, 255);
    satelliteColor = color(grayScale, grayScale, grayScale, 150); // satellite will have transparency
    speed = random(1, 3);
  }

  void display() {
    float newX = planet.x + orbitRadius * cos(angle); // relative to the planet's center
    float newY = planet.y + orbitRadius * sin(angle);

    pushMatrix();
    translate(newX, newY);
    fill(satelliteColor);
    ellipse(0, 0, satelliteDiameter, satelliteDiameter);
    popMatrix();
  }

  void orbit() {
    angle += radians(speed);
  }
}

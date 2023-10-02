Planet p1;
Planet p2;
ArrayList<Meteor> meteors = new ArrayList<Meteor>();
ArrayList<Trail> trails = new ArrayList<Trail>();

Star star1 = new Star(50, 50);
Star star2 = new Star(100, 100);
Star star3 = new Star(200, 200);
Star star4 = new Star(100, 400);

void setup() {
  size(800, 600);
  p1 = new Planet(-200, 200, 60, color(31, 61, 212), 2);
  p1.satellite = new Satellite(p1, 80);
  p2 = new Planet(-200, 400, 100, color(201, 28, 12), 1);
  p2.satellite = new Satellite(p2, 100);
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

  star1.display();
  star2.display();
  star3.display();
  star4.display();

  // Random chance to spawn a meteor
  if (random(1) < 0.01) {
    meteors.add(new Meteor(width, random(height)));
  }
  
  // Display the trails first so they appear behind the meteors
  for (int i = trails.size() - 1; i >= 0; i--) {
    Trail t = trails.get(i);
    t.update();
    t.display();
    
    if (alpha(t.meteorColor) <= 0) {
      trails.remove(i);
    }
  }

  // Then update and display the meteors
  for (int i = meteors.size() - 1; i >= 0; i--) {
    Meteor m = meteors.get(i);
    m.update();
    m.display();
    
    // Set the amplitude to be slightly greater than the diameter of the meteor
    float amplitude = m.size/2.7;  // You can adjust the "+ 5" for how much greater you want the amplitude to be
    
    float yOscillationSin = sin(frameCount * TWO_PI / 5) * amplitude;  // Adjust for vertical oscillation using sine
    float yOscillationCos = cos(frameCount * TWO_PI / 5) * amplitude;  // Adjust for vertical oscillation using cosine
    
    trails.add(new Trail(m.position.x, m.position.y + yOscillationSin));  // Sine wave trail
    trails.add(new Trail(m.position.x, m.position.y + yOscillationCos));  // Cosine wave trail
    
    if (m.position.x + m.size < 0) {
      meteors.remove(i);
    }
  }
}

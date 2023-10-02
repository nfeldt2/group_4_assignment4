Planet p1;
Planet p2;
float t;
int rev;
ArrayList<Meteor> meteors = new ArrayList<Meteor>();
ArrayList<Trail> trails = new ArrayList<Trail>();

Star s1, s2, s3, s4;

void setup() {
  size(800, 600);
  p1 = new Planet(-200, 200, 60, color(31, 61, 212), 2);
  p1.satellite = new Satellite(p1, 80);
  p2 = new Planet(-200, 400, 100, color(201, 28, 12), 1);
  p2.satellite = new Satellite(p2, 100);
  t = 0;
  s1 = new Star(80, 150);
  s2 = new Star(300, 500);
  s3 = new Star(500, 200);
  s4 = new Star(700, 350);
  rev = 1;
}

void draw() {
  background(0);
  
  
  s1.display(t);
  s2.display(t);
  s3.display(t);
  s4.display(t);
  t = t + (rev * 0.01);
  if (t > 1){ rev = -1;}
  if (t < 0) { rev = 1;}
  
  
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

  // random chance to spawn a meteor
  if (random(1) < 0.01) {
    meteors.add(new Meteor(width, random(height)));
  }
  
  
  for (int i = trails.size() - 1; i >= 0; i--) {
    Trail t = trails.get(i);
    t.update();
    t.display();
    
    if (alpha(t.meteorColor) <= 0) {
      trails.remove(i);
    }
  }

 
  for (int i = meteors.size() - 1; i >= 0; i--) {
    Meteor m = meteors.get(i);
    m.update();
    m.display();
    
    
    float amplitude = m.size/3;  // changles amplitude to match astroid
    
    float oscillationSin = sin(frameCount * TWO_PI / 5) * amplitude;  
    float oscillationCos = cos(frameCount * TWO_PI / 5) * amplitude;  
    
    trails.add(new Trail(m.position.x, m.position.y + oscillationSin));  
    trails.add(new Trail(m.position.x, m.position.y + oscillationCos)); 
    
    if (m.position.x + m.size < 0) {
      meteors.remove(i);
    }
  }
}

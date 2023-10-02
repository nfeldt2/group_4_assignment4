void setup() {
  size(800, 600);
}

// lists for trails and meteors
ArrayList<Meteor> meteors = new ArrayList<Meteor>();
ArrayList<Trail> trails = new ArrayList<Trail>();

void draw() {
  background(0);
  
  // spawn meteor
  if (random(1) < 0.02) {
    meteors.add(new Meteor(width, random(height)));
  }
  
  // update alpha and size of trail
  for (int i = trails.size() - 1; i >= 0; i--) {
    Trail t = trails.get(i);
    t.update();
    t.display();
    
    // remove trails that no longer are visible
    if (alpha(t.meteorColor) <= 0) {
      trails.remove(i);
    }
  }

  for (int i = meteors.size() - 1; i >= 0; i--) {
    Meteor m = meteors.get(i);
    m.update();
    m.display();
    
    float amplitude = m.size/3;
    
    // multiple oscillations makes the fire trail look more 'full'
    float oscillationSin = sin(frameCount * TWO_PI / 5) * amplitude;  
    float oscillationCos = cos(frameCount * TWO_PI / 5) * amplitude;  
    
    // adds new 'trail' every frame (really just one dot at a position)
    // 'trail' is removed after the alpha is 0
    trails.add(new Trail(m.position.x, m.position.y + oscillationSin));  
    trails.add(new Trail(m.position.x, m.position.y + oscillationCos));  
    
    if (m.position.x + m.size < 0) {
      meteors.remove(i);
    }
  }
}

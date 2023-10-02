class Meteor {
  PVector position;
  PVector velocity;
  float size;
  color meteorColor;
  ArrayList<Dot> textureDots;
  float rotationAngle;  // Property for rotation
  
  Meteor(float x, float y) {
    position = new PVector(x, y);
    float angle = PI + random(-0.2, 0.2);
    float speed = random(3, 5);
    velocity = new PVector(cos(angle) * speed, sin(angle) * speed);
    size = random(20, 50);
    meteorColor = color(150, 150, 150);
    textureDots = new ArrayList<Dot>();
    int numDots = int(random(5, 15));
    for (int i = 0; i < numDots; i++) {
      textureDots.add(new Dot());
    }
    rotationAngle = random(TWO_PI);  // Initialize with a random rotation
  }

  void update() {
    position.add(velocity);
    rotationAngle += .45;  // Adjust for desired rotation speed
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);  // Move the origin to the meteor's center
    rotate(rotationAngle);  // Apply the rotation
    fill(meteorColor);
    ellipse(0, 0, size, size);  // Draw the meteor at the origin (because we've moved the origin)
    for (Dot d : textureDots) {
      d.display();
    }
    popMatrix();  // Restore the original transformation state
  }
  
  // Inner class to represent each dot of the texture
  class Dot {
    float xOff;  // X offset from the center of the meteor
    float yOff;  // Y offset from the center of the meteor
    float dotSize;
    
    Dot() {
      float angle = random(TWO_PI);
      float radius = random(size / 2);  // Ensure dot remains within meteor
      xOff = cos(angle) * radius;
      yOff = sin(angle) * radius;
      dotSize = random(2, 5);
    }
    
    void display() {
      fill(100, 100, 100);  // Darker gray for the texture dots
      ellipse(xOff, yOff, dotSize, dotSize);
    }
  }
}


class Trail extends Meteor {
  
  Trail(float x, float y) {
    super(x, y);
    size = 20;
    meteorColor = color(255, 100, 0, 150); // Semi-transparent fiery color
  }

  @Override
  void display() {
    fill(meteorColor);
    ellipse(position.x, position.y, size, size);
    // No dots for the trail
  }

  @Override
  void update() {
    // Gradually fade out the trail and decrease its size
    meteorColor = color(red(meteorColor), green(meteorColor), blue(meteorColor), alpha(meteorColor) - 3);
    size *= 0.95;
  }
}


ArrayList<Meteor> meteors = new ArrayList<Meteor>();
ArrayList<Trail> trails = new ArrayList<Trail>();

void setup() {
  size(800, 600);
}

void draw() {
  background(0);
  
  // Random chance to spawn a meteor
  if (random(1) < 0.02) {
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

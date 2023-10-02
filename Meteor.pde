class Meteor {
  PVector position;
  PVector velocity;
  float size;
  color meteorColor;
  ArrayList<Dot> textureDots;
  float rotationAngle;  
  Meteor(float x, float y) {
    position = new PVector(x, y);
    float angle = PI + random(-0.2, 0.2);
    float speed = random(3, 5);
    velocity = new PVector(cos(angle) * speed, sin(angle) * speed);
    size = random(10, 35);
    meteorColor = color(150, 150, 150);
    textureDots = new ArrayList<Dot>();
    int numDots = int(random(5, 1));
    for (int i = 0; i < numDots; i++) {
      textureDots.add(new Dot());
    }
    rotationAngle = 0;  
  }

  void update() {
    position.add(velocity);
    // rotate meteor
    rotationAngle += .45; 
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y); 
    rotate(rotationAngle);  
    fill(meteorColor);
    ellipse(0, 0, size, size);  
    for (Dot d : textureDots) {
      d.display();
    }
    popMatrix();  
  }
  
  // class within meteor that gives texture
  class Dot {
    float xOff;  
    float yOff;  
    float dotSize;
    
    Dot() {
      // calculate size of meteor
      float angle = random(2*PI);
      float radius = random(2, size / 2);  
      xOff = cos(angle) * radius;
      yOff = sin(angle) * radius;
      dotSize = random(2, 5);
    }
    
    void display() {
      fill(100, 100, 100); 
      ellipse(xOff, yOff, dotSize, dotSize);
    }
  }
}


class Trail extends Meteor {
  float trailSize;
  
  Trail(float x, float y) {
    super(x, y);
    trailSize = 15;
    meteorColor = color(255, 100, 0, 150); 
  }

  @Override
  void display() {
    fill(meteorColor);
    ellipse(position.x, position.y, trailSize, trailSize);

  }

  @Override
  void update() {
    
    meteorColor = color(red(meteorColor), green(meteorColor), blue(meteorColor), alpha(meteorColor) - 3);
    trailSize *= 0.95;
  }
}

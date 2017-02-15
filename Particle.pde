class Particle
{
  PVector location;
  color body_color;
  float max_speed;
  float noise_value;
  float angle;
  float size;
  
  Particle(float x, float y, float c)
  {
    location = new PVector(x, y);
    float color_value = (c + random(30)) % 255;
    body_color = color(color_value, 255, 255);
    max_speed = 8;
    noise_value = random(10);
    angle = random(360);
    size = 25;
  }
  
  void run()
  {
    update();
    display();
  }
  
  void update()
  {
    float x = max_speed * cos(radians(angle));
    float y = max_speed * sin(radians(angle));
    
    location.add(x, y, 0);
    
    size -= 0.3;
  }
  
  void display()
  {
    noStroke();
    fill(body_color);
    ellipse(location.x, location.y, size, size);
  }
  
  boolean isDead()
  {
    if(size < 0)
    {
      return true;
    }
    return false;
  }
}
import java.util.*;
import de.voidplus.leapmotion.*;

LeapMotion _leap;
ArrayList<Particle> _particles;

void setup()
{
  size(800, 800);
  frameRate(30);
  colorMode(HSB);
  blendMode(ADD);
  
  _leap = new LeapMotion(this);
  _particles = new ArrayList<Particle>();
}

void draw()
{
  background(0);
  
  for(Hand hand : _leap.getHands())
  {
    float max_distance = 0;
    PVector max_point = new PVector(0, 0);
    PVector thumb_point = hand.getThumb().getPosition().copy();
    
    for(Finger finger : hand.getFingers())
    {
      //ellipse(finger.getPosition().x, finger.getPosition().y, 10, 10);
      if(finger.getTypeName() != "thumb")
      {        
        PVector distance = PVector.sub(thumb_point, finger.getPosition());
        if(max_distance < distance.mag())
        {
          max_distance = distance.mag();
          max_point = finger.getPosition().copy();
        }
      }
    }
    
    PVector distance = PVector.sub(thumb_point, max_point);
    PVector center = PVector.sub(thumb_point, PVector.div(distance, 2));
    
    noFill();
    //ellipse(center.x, center.y, distance.mag(), distance.mag());
    
    println(distance.mag());
    if(distance.mag() > 150)
    {
      float angle = degrees(atan2(thumb_point.y - center.y, thumb_point.x - center.x)) + 180;
      for(int i = 0; i < 5; i++)
      {
        _particles.add(new Particle(center.x, center.y, angle / 360 * 255));
      }
    }
  }
  
  Iterator<Particle> it = _particles.iterator();
  while(it.hasNext())
  {
    Particle p = it.next();
    p.run();
    if(p.isDead())
    {
      it.remove();
    }
  }
}
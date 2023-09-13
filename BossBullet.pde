// Boss bullet subclass

class BossBullet extends Laser {
  
  float angle; // angle of boss bullets to aim at player
  
  BossBullet(PVector pos, PVector vel) {
    super(pos,vel);
    
    dim = new PVector(20,20);
    isAlive=true;
    
    // Represents the direction from the boss bullet towards the player
    // guiding a projectile towards the player's position
    angle = atan2(player.pos.y - pos.y, player.pos.x - pos.x);    
  }
  
  @Override void update() {
    move();
    drawMe();
  }
  
  // Angle provides the direction in which the object should move
  // velocity scales the movement according to how fast the object is currently moving
  @Override void move() {
    PVector vel2 = PVector.fromAngle(angle);
    vel2.mult(vel.x);
    pos.add(vel2);
  }
  
  @Override void drawMe() {
    pushMatrix();
    translate(-player.pos.x + width/2 + pos.x, -player.pos.y + height/2 + pos.y);
    fill(255,0,0);
    ellipse(0,0,dim.x,dim.y);
    popMatrix();
  }
  
  @Override boolean hit(Character c) {
    return abs(pos.x - c.pos.x) < dim.x/2 + c.dim.x/2 
        && abs(pos.y - c.pos.y) < dim.y/2 + c.dim.y/2;
  }
}

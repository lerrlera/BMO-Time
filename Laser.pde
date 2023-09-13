// Laser class

class Laser {
  
  PVector pos, vel, dim;
  boolean isAlive;
  color lColor = color(0,255,0);
  
  Laser(PVector pos, PVector vel) {
    this.vel = vel;
    this.pos = pos;
  
    if (lastKeyPressed == LEFT || lastKeyPressed == RIGHT) {
          dim = new PVector(35,5);
    } else {
      dim = new PVector(5,35);
    }
    isAlive=true;
  }
  
  void update() {
    move();
    checkWalls();
    drawMe();
  }
  
  // draw laser
  void drawMe() {
    pushMatrix();
    translate(pos.x, pos.y);
    if (player.powerUp) {
      fill(70,213,255);
      rect(0,0,dim.x,dim.y);
    } else {
      fill(lColor);
      ellipse(0,0,dim.x,dim.y);
    }
    popMatrix();
  }
  
  // move laser
   void move() {
   pos.add(vel);
 }
   
  // check walls method that checks if laser has gone out of the screen
  void checkWalls() {
   if (abs(pos.x-width/2)>width/2||abs(pos.y-height/2)>height/2) {
     isAlive=false;
   }
  }
  
  // check if this laser hit a Character 
  // based on on the updated character x and y positions relative to player (not against it as translated)
  boolean hit(Character c) {
    float charX = c.pos.x - player.pos.x + width/2;
    float charY = c.pos.y - player.pos.y + height/2;

    return pos.x + dim.x/2 > charX - c.dim.x/2
      && pos.x - dim.x/2 < charX + c.dim.x/2
      && pos.y + dim.y/2 > charY - c.dim.y/2
      && pos.y - dim.y/2 < charY + c.dim.y/2;
  }
}

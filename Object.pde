// Generic object class 

class Object {
  PVector pos, dim;
  PImage object;
  boolean isAlive;
  int boost;
  
  int activationTime;
  int duration;

  Object(PVector pos) {
    this.pos = pos;
  }
  
  void update() {
  }
  
  void drawObject() {
    pushMatrix();
    rect(0,0,10,10);
    popMatrix();
  }
  
  // detect when object has collided with any Character
  boolean collision(Character c) {
    return dist(pos.x,pos.y,c.pos.x,c.pos.y)<(dim.x/2+c.dim.x/2);
  }
}

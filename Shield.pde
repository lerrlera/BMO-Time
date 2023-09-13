// Shield subclass (invincible for 15 seconds)

class Shield extends Object {
  
  Shield(PVector pos) {
    super(pos);
    dim = new PVector(50,50);
    object = loadImage("data/shield.png");
    
    duration = 15000; 
    isAlive = true;
  }
  
  @Override
  void update() {
    drawObject();
    addShield();
  }
  
  @Override
   void drawObject() {
    if (isAlive) {
    pushMatrix();
    translate(-player.pos.x + width/2 + pos.x, 
    -player.pos.y + height/2 + pos.y);
    imageMode(CENTER);
    image(object, 0, 0, dim.x, dim.y);
    popMatrix();
    }
  }
  
  void addShield() {
    if (collision(player) && isAlive) {
      player.isShielded = true;
      isAlive = false;
      playSound(POWERUP);
      activationTime = millis();
    }
  }
}

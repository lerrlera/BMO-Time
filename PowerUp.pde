// Powerup subclass (increase lassr strength for 15 seconds)

class PowerUp extends Object {
  
  PowerUp(PVector pos) {
    super(pos);
    dim = new PVector(60,60);
    
    duration = 15000; 
    object = loadImage("data/powerup.png");
    isAlive = true;
  }
  
  @Override
  void update() {
    drawObject();
    addPowerUp();
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
  
  void addPowerUp() {
    if (collision(player) && isAlive) {
      player.powerUp = true;
      isAlive = false;
      playSound(POWERUP);
      activationTime = millis();
    }
  }
}
  

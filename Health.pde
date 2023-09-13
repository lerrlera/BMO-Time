// Health pack subclass

class Health extends Object {
 
  Health(PVector pos) {
    super(pos);
    dim = new PVector(50,50);
    boost = 2;
    object = loadImage("data/health.png");
    
    isAlive = true;
  }
  
  @Override
  void update() {
    addHealth();
    drawObject();
    if (!isAlive) delete();
  }
  
  @Override
   void drawObject() {
    pushMatrix();
    translate(-player.pos.x + width/2 + pos.x, 
    -player.pos.y + height/2 + pos.y);
    imageMode(CENTER);
    image(object, 0, 0, dim.x, dim.y);
    popMatrix();
  }
  
  void addHealth() {
    if (collision(player) && isAlive) {
      if (player.health <= player.maxHealth-boost) {
        player.health+=boost;
      } else {
        player.health = player.maxHealth;
      }
      isAlive = false;
      playSound(HEALTH);
    }
  }
  
  void delete() {
    for (int i = 0; i<healths.size();i++) {
      Health h = healths.get(i);
      if (!h.isAlive) healths.remove(h);
    }
  }
}

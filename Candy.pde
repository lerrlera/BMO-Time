// Candy subclass (collectibles)

class Candy extends Object {
  
  Candy(PVector pos) {
    super(pos);
    dim = new PVector(80,80);
    
    isAlive = true;
    
    object = loadImage("data/candy.png");
  }
  
  @Override
  void update() {
    drawObject();
    candyCollected();
    
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
  
  void candyCollected() {
    if (collision(player)){
      isAlive = false;
      player.candyCount++;
    }
  }
  
  void delete() {
    for (int i = 0; i<candies.size();i++) {
      Candy c = candies.get(i);
      if (!c.isAlive) candies.remove(c);
      playSound(CANDY);
    }
  }
}

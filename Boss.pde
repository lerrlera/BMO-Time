// Boss enemy class

class Boss extends BasicEnemy {
  
  PImage img;
  ArrayList<BossBullet> bossbullets = new ArrayList<BossBullet>();
  
  Boss(PVector pos, PVector vel) {
    super(pos,vel);
    
    dim = new PVector(130,130);
    img = loadImage("data/enemy/boss.png");
    
    super.health = 15;
    super.maxHealth = 15; 
    super.healthPercentage = 1;
  }
  
  @Override void update() {
    if (!this.isDead) {
      drawHealthBar();
    } 
    
    checkBullets();
    if (frameCount % 50 == 0) fire();
  }
  
  void fire() {
    bossbullets.add(new BossBullet(new PVector(pos.x, pos.y), new PVector(5,5)));
}

  void checkBullets() {
    for (int i = bossbullets.size() - 1; i >= 0; i--) {
      BossBullet bb = bossbullets.get(i);
      bb.update();
      bb.drawMe();
  
      // Check if boss bullet hits the player
      if (bb.hit(player) && !player.isShielded) {
          player.decreaseHealth(1);
          bossbullets.remove(i);
      }
    }
  }
  
  
  @Override
  void drawCharacter() {
    pushMatrix();
    translate(-player.pos.x + width/2 + pos.x, 
    -player.pos.y + height/2 + pos.y);
    imageMode(CENTER);
    image(img, 0, 0, dim.x, dim.y);
    popMatrix();
  }
  
  @Override void drawHealthBar() {
    int healthBarWidth = 50;
    pushMatrix();
    fill(0,64);
    translate(-player.pos.x + width/2 + pos.x + 60, 
    -player.pos.y + height/2 + pos.y - 50);
    strokeWeight(3);
    rect(0,0,healthBarWidth, 10);
    if (healthPercentage < 0.60 && healthPercentage > 0.30) {
      fill(255, 165, 0);
    } else if (healthPercentage < 0.40) {
      fill(255,0,0);
    } else {
      fill(0,255,0);
    }
    rect(0, 0, healthBarWidth * healthPercentage, 10);
    popMatrix();
    }
}

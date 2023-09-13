// Basic Enemy subclass

class BasicEnemy extends Character {
  
  // images
  PImage armsup;
  PImage armsdown;
  
  // animation
  int animationSpeed = 20;

  PVector dim;
  float eSpeed = 3;
  float eSpeed2 = 5;
  boolean isDead = false;
  
  BasicEnemy(PVector pos, PVector vel) {
    super(pos,vel);
    dim = new PVector(90,90);
    
    super.health = 5;
    super.maxHealth = 5; 
    super.healthPercentage = 1;
    
    armsdown = loadImage("data/enemy/enemy0.png");
    armsup = loadImage("data/enemy/enemy1.png");
  }
  
  @Override
  void update() {
    moveCharacter();
    
    if (!this.isDead) {
      drawHealthBar();
    } 
  }
  
  @Override
  void moveCharacter() {
    pos.add(vel);
    if (current_level == LEVEL_ONE) {
      if (vel.x > 0 && -player.pos.x + width/2+pos.x > 400) {
        vel.x = -eSpeed;
      } else if (vel.x < 0 && -player.pos.x + width/2 + pos.x <= 0) {
        vel.x = eSpeed;
      }
    } else if (current_level == LEVEL_TWO || current_level == LEVEL_THREE) {
        if (vel.x > 0 && -player.pos.x + width/2+pos.x > 600) {
          vel.x = -eSpeed2;
        } else if (vel.x < 0 && -player.pos.x + width/2 + pos.x <= 0) {
          vel.x = eSpeed2;
      }
    }
  }

  void killed() {
    enemies.remove(this);
  }

  @Override
  void drawCharacter() {
    pushMatrix();
    translate(-player.pos.x + width/2 + pos.x, 
    -player.pos.y + height/2 + pos.y);    
    imageMode(CENTER);
    int frameIndex = frameCount % (2 * animationSpeed);
    PImage currentImg;
    if (frameIndex < animationSpeed) {
      currentImg = armsdown;
    } else {
      currentImg = armsup;
    }

    // Display the current image
    image(currentImg, 0, 0, dim.x, dim.y);
    popMatrix();
  }
  
  @Override
  void drawHealthBar() {
    int healthBarWidth = 50;
    pushMatrix();
    fill(0,64);
    translate(-player.pos.x + width/2 + pos.x + 30, 
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
    
  @Override
  Rectangle boundingBox() {
    return new Rectangle((int) pos.x - 40, (int) pos.y-45, 70, 80);
  }
  
  void destroy() {
    this.isDead = true;
  }
}

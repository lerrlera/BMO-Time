// Player subclass (BMO)

class Player extends Character {
  
  // img arrays for player's animation in moving states
  PImage[] standing = new PImage[1];
  PImage[] front_walking = new PImage[2];
  PImage[] side_walking = new PImage[2];
  PImage[] back_walking = new PImage[2];
  PImage[] back_still = new PImage[1];
  PImage[] side_still = new PImage[1];
  
  //player's projectiles
  ArrayList<Laser> lasers = new ArrayList<Laser>();
  
  int candyCount;
  boolean isShielded;
  boolean powerUp;
    
  Player (PVector pos, PVector vel) {
    super(pos,vel);
    vel = new PVector();
    dim = new PVector(70,70);
    
    candyCount = 0;
    isAlive = true;
    super.maxHealth = 10; 
    super.health = 10;
    super.healthPercentage = 1;
    
    isShielded = false;
    powerUp = false;
    
    standing[0] = loadImage("data/player/front-still.png");
    imgState = standing;
    
    back_still[0] = loadImage("data/player/back-still.png");
    side_still[0] = loadImage("data/player/side-still.png");

    for (int i = 0;i < front_walking.length; i++) {
      front_walking[i] = loadImage("data/player/front-walk" + i + ".png");
      side_walking[i] = loadImage("data/player/side-walk" + i + ".png");
      back_walking[i] = loadImage("data/player/back-walk" + i + ".png");
    }
  }
  
  @Override
  void update() {
    super.update();
    showDirection(); 
    drawHealthBar();
    updateLasers();
    checkCollisions();
    dead();
    moveToNextLevel();
  }
  
  void checkCollisions() {
   for (int j=0; j<enemies.size(); j++) {
     BasicEnemy e = enemies.get(j);
     if (hitCharacter(e) && !isShielded) {      // if player's bounding box collides with the enemy
       decreaseHealth(1);
       e.pos.x = e.pos.x + 100;
     }
   }
  }
  
  void fire() {
  PVector laserVelocity = new PVector();
  // determine the direction the player is facing and set the laser's velocity accordingly
  if (lastKeyPressed == UP) {
    // facing up
    laserVelocity = new PVector(0, -10);
  } else if (lastKeyPressed == DOWN) {
    // facing down
    laserVelocity = new PVector(0, 10);
  } else if (lastKeyPressed == LEFT) {
    // facing left
    laserVelocity = new PVector(-10, 0);
  } else if (lastKeyPressed == RIGHT) {
    // facing right
    laserVelocity = new PVector(10, 0);
  }
  
  lasers.add(new Laser(new PVector(width/2, height/2), laserVelocity));
  playSound(LASER);
}
  
  void updateLasers() {
    for (int i = 0; i < lasers.size(); i++) {
      Laser laser = lasers.get(i);
      laser.update();
      
      for (int j = 0; j<enemies.size(); j++) {
        BasicEnemy e = enemies.get(j);
        if (laser.hit(e)) {
          if (player.powerUp) e.decreaseHealth(5);
          else { 
            e.decreaseHealth(1);
          }
          e.healthPercentage = (float) e.health/e.maxHealth;
          
          laser.isAlive = false;
          if (e.health <= 0) e.killed();
        }
      }
      if (!laser.isAlive) {
        lasers.remove(i);
      }
    }
  }

  void drawCharacter() {
    pushMatrix();
    if (isShielded) {
      fill(254,255,44,127);
      ellipse(width/2,height/2,100,100);
    }
    
    imageMode(CENTER);
    PImage img = imgState[currImgindex];
    if (vel.x < 0) {
      scale(-1.0,1.0); // flip image if going to the left
      image(img, -width/2,height/2,dim.x,dim.y);
    }
    else if (vel.x == 0) { 
      if (lastKeyPressed == LEFT) {
        scale(-1.0,1.0); // flip image if standing still and last key pressed was LEFT
        image(img, -width/2,height/2,dim.x,dim.y);
      }
      else {
        image(img,width/2,height/2,dim.x,dim.y);
      } 
    } else {
      image(img, width/2,height/2,dim.x,dim.y);
    }
    
    popMatrix();
  }
  
  //for animating player moving and switching depending on the way they are facing
  void showDirection() {
    if (frameCount % 5 == 0 ) {
      currImgindex++;
      
      switch(movingState) {
        case 1:
          if(currImgindex == front_walking.length) {
            currImgindex = 0;
          }
          imgState = front_walking;
          break;
        case 2:
          if(currImgindex == side_walking.length) {
            currImgindex = 0;
          }
          imgState = side_walking;
          break;
        case 3:
          if(currImgindex == back_walking.length) {
            currImgindex = 0;
          }
          imgState = back_walking;
          break;
        case 4:
          currImgindex = 0;
          imgState = back_still;
          break;
        case 5:
          currImgindex = 0;
          imgState = side_still;
          break;
        default: //standing
          currImgindex = 0;
          imgState = standing;
      }
    }
  }
  
  void dead() {
    if (player.health == 0) {
      isAlive = false;
      current_level = LOST;
    }
  }
  
  // if 3 candies collected => move to the next level
  void moveToNextLevel(){
    if (player.candyCount == 3) {
      current_level++;
      playSound(BMO);
    }
  }
  
  @Override
  void decreaseHealth(int d) {
    health = health - d;
    playSound(HURT);
  }
  
  @Override
  Rectangle boundingBox() {
  // return a box for my Player to determine bounds
   return new Rectangle((int) pos.x-30, (int) pos.y-35, 60, 70);
  }
}

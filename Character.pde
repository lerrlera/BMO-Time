// a class to describe a generic Character

import java.awt.Rectangle;

class Character {
  
  //fields for motion
  PVector pos,vel,dim;
  float damp = 0.6; // constant dumping factor to control velocity
  float speed;
  
  boolean isAlive; // check if character is alive
  int maxHealth; // max health the character can have
  int health;
  float healthPercentage;
  
  boolean isInvincible;
  int invincibilityDuration;
  int invincibilityTimer;

  
  // character animation
  PImage[] imgState;
  int currImgindex = 0;

  //constructor
  Character(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
    dim = new PVector(40,40);
    
    health = maxHealth;
    }
  
  //move character, multiply velocity by dampening factor 
  //and add velocity to position
  void moveCharacter() {
    vel.mult(damp);
    pos.add(vel);
  }
  
  //change Character's velocity using an accelerator
  void accelerate(PVector acc) {
    vel.add(acc);
  }
  
  //draw method to draw a placeholder
  void drawCharacter() {
    fill(0);
    ellipse(width/2+dim.x/2,height/2+dim.y/2,dim.x,dim.y);
  }
  
  //decrease the health of Character
  void decreaseHealth(int d) {
    health = health - d;
  }
  
  //call move
  void update() {
    moveCharacter();
  }
  
  //detect when 2 Characters have collided
  boolean hitCharacter(Character c) {
    return (this.boundingBox().intersects(c.boundingBox()) ||
    c.boundingBox().intersects(this.boundingBox()));
  }
  
  Rectangle boundingBox() {
  // return a box for Character to determine bounds
   return new Rectangle((int) pos.x -(int) dim.x/2, (int) pos.y - (int) dim.y/2, (int) dim.x, (int) dim.y);
  }
  
  void drawBoundingBox() {
    Rectangle r = boundingBox();
    noFill();
    stroke(255, 0, 0);  // red color
    rect(r.x, r.y, r.width, r.height);
  } 
  
  
  void drawHealthBar() {
    healthPercentage = (float) health/maxHealth;
    int healthBarWidth = 200;
    pushMatrix();
    fill(0,64);
    translate(20,20);
    strokeWeight(3);
    rect(0,0,healthBarWidth, 20);
    if (healthPercentage < 0.60 && healthPercentage > 0.30) {
      fill(255, 165, 0);
    } else if (healthPercentage < 0.40) {
      fill(255,0,0);
    } else {
    fill(0,255,0);
    }
    rect(0, 0, healthBarWidth * healthPercentage, 20);
    popMatrix();
  }
  
  void updateInvincibilityStatus() {
  if (isInvincible) {
    int currentTime = millis();
    if (currentTime - invincibilityTimer >= invincibilityDuration) {
      isInvincible = false;
    }
  }
}
}

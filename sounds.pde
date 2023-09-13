// sound methods

//loading the audio files 
void loadSound() {
  minim = new Minim(this);
  gameplay = minim.loadFile(GAMEPLAY);
  gameplay3 = minim.loadFile(GAMEPLAY3);
  laser = minim.loadFile(LASER);
  health = minim.loadFile(HEALTH);
  candy = minim.loadFile(CANDY);
  bmo = minim.loadFile(BMO);
  powerup = minim.loadFile(POWERUP);
  hurt = minim.loadFile(HURT);
  win = minim.loadFile(WIN);
  lose = minim.loadFile(LOSE);
}

//for playing the sound effect files
void playSound(String file) {
  AudioPlayer sound = null;
  switch(file) {
    case LASER:
      sound = laser;
      break;
    case CANDY: 
      sound = candy;
      break;
    case HEALTH:
      sound = health;
      break;
    case BMO:
      sound = bmo;
      break;
    case POWERUP:
      sound = powerup;
      break;
    case HURT:
      sound = hurt;
      break;
    default: //do nothing
  }
  sound.play(0);
}

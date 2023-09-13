// Key controls

PVector upAcc = new PVector(0,-4);
PVector downAcc = new PVector(0,4);
PVector leftAcc = new PVector(-4,0);
PVector rightAcc = new PVector(4,0);

boolean up, down, left, right;

int lastKeyPressed = 0; // track the last key pressed

void keyPressed() {
  if (key == CODED) {
    
    if (keyCode == LEFT) {
      movingState = 2;
      left = true;
    }
    if (keyCode == RIGHT) {
      movingState = 2;
      right = true;
    }
    if (keyCode == UP) {
      movingState = 3;
      up = true;
    }
    if (keyCode == DOWN) {
      movingState = 1;
      down = true;
    }
     lastKeyPressed = keyCode; 
  }
  
  if (key== ' ') {
    player.fire();
  }
 
}

void keyReleased() {
   if (key == CODED) {
    if (keyCode == LEFT) {
      left = false;
      movingState = 5;
    }
    if (keyCode == RIGHT){
      right = false;
      movingState = 5;
    }
    if (keyCode == UP) {
      up = false;
      movingState = 4;
    }
    if (keyCode == DOWN) {
      down = false;
      movingState = 0;
    }
   }
}

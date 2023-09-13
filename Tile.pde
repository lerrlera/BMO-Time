// Class for a Tile object (based on Marek Hatala's slides - Fall 2022)

class Tile {
  PVector pos, absDiff;
  PImage img;
  boolean block;
   
  Tile(String path, PVector pos, boolean block) {
    img = loadImage(path);
    this.pos = pos;
    this.block = block;
  }
  
  // check if character collides with blocked tiles
  // if yes => block character from moving 
  void collision(Character c) {
    PVector diff = PVector.sub(c.pos, pos);
    absDiff = new PVector(abs(diff.x), abs(diff.y));
    if (block &&
      absDiff.x < c.dim.x/2 + img.width/2 && 
      absDiff.y < c.dim.y/2 + img.height/2) {
        
        //make character to be blocked by the tile
        c.pos.x += diff.x * 0.02;
        c.pos.y += diff.y * 0.02;
        c.vel.mult(0.0);
      }
  }
  
  // check if the distance b/w character and tile is within the bound of the window
  boolean inWindow() {
    if (absDiff.x < width && absDiff.y < height) {
      return true;
    }
    return false;
  }
 
  // drawing the tile
  void drawMe(Character player) {
      pushMatrix();
      translate(-player.pos.x + width/1.6 + pos.x, 
     -player.pos.y + height/1.6 + pos.y);
      // scale to fill the gaps
      scale(1.04,1.04);
      image(img, -img.width/2, -img.height/2);
      popMatrix();
    } 
}

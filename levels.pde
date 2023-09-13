// game setup: levels/states

void intro() {
  PImage intro = loadImage("data/intro.png");
  background(intro);
  gameplay.pause();
  gameplay3.pause();
  cp5.getController("start").show();
  cp5.getController("next").hide();
  cp5.getController("back").hide();
  setup1 = false;
  setup2 = false;
  setup3 = false;
  setupWon = false;
  setupLost = false;
  setupHowto = false;
  clearLists();
}

void howto() {
  PImage howto = loadImage("data/how-to.png");
  background(howto);
  gameplay.pause();
  gameplay3.pause();
  cp5.getController("next").show();
  cp5.getController("back").show();
  setup1 = false;
  setup2 = false;
  setup3 = false;
  setupWon = false;
  setupLost = false;
  setupIntro = false;
}

void level1() {
  if (!setup1) {
    setup1 = true;
    time = millis();
    cp5.getController("back").hide();
    clearLists();
    generateMap(map1);
    
    // sounds
    gameplay.play();
    gameplay.loop();
  
    Tile startTile = tiles.get(playerInit1); // start position
    player = new Player(new PVector(startTile.pos.x, startTile.pos.y),new PVector());
    
    generateEnemies(enemyInit1);
    
    Tile healthTile = tiles.get(healthInit1);
    healths.add(new Health(new PVector(healthTile.pos.x, healthTile.pos.y)));
 
    generateCandies(candyInit1);
    }
    update();
  
    introText1();
    levelText(1);
    displayCandies();
}

void level2() {
  if (!setup2) {
    setup2 = true;
    time = millis();
    clearLists();
    generateMap(map2);
  
    Tile startTile = tiles.get(playerInit2); // start position
    player = new Player(new PVector(startTile.pos.x, startTile.pos.y),new PVector());
    
    generateEnemies(enemyInit2);
    
    Tile healthTile = tiles.get(healthInit2);
    healths.add(new Health(new PVector(healthTile.pos.x, healthTile.pos.y)));
    
    Tile shieldTile = tiles.get(shieldInit2);
    shields.add(new Shield(new PVector(shieldTile.pos.x, shieldTile.pos.y)));
 
    generateCandies(candyInit2);
    }
    update();
  
    introText2();
    levelText(2);
    displayCandies();
}

void level3() {
  if (!setup3) {
    setup3 = true;
    time = millis();
    clearLists();
    generateMap(map3);
    
    
    gameplay.pause();
    gameplay3.play();
    gameplay3.loop();
    
  
    Tile startTile = tiles.get(playerInit3); // start position
    player = new Player(new PVector(startTile.pos.x, startTile.pos.y),new PVector());
    
    Tile enemyTile = tiles.get(bossInit3);
    enemies.add(new Boss(new PVector(enemyTile.pos.x, enemyTile.pos.y), new PVector()));
    
    generateEnemies(enemyInit3);
    generateStaticEnemies(staticEnemyInit3);
    
    
    Tile healthTile = tiles.get(healthInit3);
    healths.add(new Health(new PVector(healthTile.pos.x, healthTile.pos.y)));
    
    Tile shieldTile = tiles.get(shieldInit3);
    shields.add(new Shield(new PVector(shieldTile.pos.x, shieldTile.pos.y)));
 
    Tile powerupTile = tiles.get(powerupInit3);
    powerups.add(new PowerUp(new PVector(powerupTile.pos.x, powerupTile.pos.y)));
    
    generateCandies(candyInit3);
    
    }
    update();
  
    introText3();
    levelText(3);
    displayCandies();
}

void lost() {
  if (!setupLost) {
    setupLost = true;
    gameplay.pause();
    gameplay3.pause();
    lose.play();
  }
  PImage lost = loadImage("data/lost.png");
  background(lost);
  cp5.getController("restart").show();
  clearLists();
  player.health = player.maxHealth;
  player.candyCount = 0;
}

void won() {
  setupWon = true;
  gameplay3.pause();
  win.play();
  PImage won = loadImage("data/won.png");
  background(won);
  cp5.getController("restart").show();
  clearLists();
  player.health = player.maxHealth;
  player.candyCount = 0;
}

//clearing the arraylists or enemies, tiles, keys and powerups
void clearLists() {
  enemies.clear();
  tiles.clear();
  candies.clear();
  healths.clear();
  shields.clear();
  powerups.clear();
}

void update() {
  for (int i = 0; i< tiles.size();i++) {
    Tile t = tiles.get(i);
    t.collision(player);
    
    if (t.inWindow()) {
      t.drawMe(player);
    }
  }
  
  // draw enemies
   for (int i=0;i<enemies.size();i++) {
    enemies.get(i).update();
    enemies.get(i).drawCharacter();
  }
  
  // draw player
  player.update();
  player.drawCharacter();
  
  // draw health
  for (int i=0;i<healths.size();i++) {
    healths.get(i).update();
  }
  
  // draw candies
  for (int i=0;i<candies.size();i++) {
    candies.get(i).update();
  }
  
  // draw shields
  for (int i=0;i<shields.size();i++) {
    shields.get(i).update();
    if (player.isShielded && millis() > shields.get(i).activationTime + shields.get(i).duration) {
      player.isShielded = false; // Deactivate shield
    }
  }
  
  // draw powerups
  for (int i=0;i<powerups.size();i++) {
    powerups.get(i).update();
    if (player.powerUp && millis() > powerups.get(i).activationTime + powerups.get(i).duration) {
      player.powerUp = false; // Deactivate powerup
    }
  }
    // key controls
  if (up) player.accelerate(upAcc);
  if (down) player.accelerate(downAcc);
  if (right) player.accelerate(rightAcc);
  if (left) player.accelerate(leftAcc);
}


// generating enemies based on initial int[] list
void generateEnemies(int[] eList) {
  for (int i = 0; i< eList.length; i++) {
    Tile enemyTile = tiles.get(eList[i]);
    enemies.add(new BasicEnemy(new PVector(enemyTile.pos.x, enemyTile.pos.y), new PVector(random(0,5),0)));
  }
}

// generating enemies based on initial int[] list
void generateStaticEnemies(int[] eList) {
  for (int i = 0; i< eList.length; i++) {
    Tile enemyTile = tiles.get(eList[i]);
    enemies.add(new BasicEnemy(new PVector(enemyTile.pos.x, enemyTile.pos.y), new PVector()));
  }
}

// generating enemies based on initial int[] list
void generateCandies(int[] cList) {
  for (int i = 0; i< cList.length; i++) {
    Tile candyTile = tiles.get(cList[i]);
    candies.add(new Candy(new PVector(candyTile.pos.x, candyTile.pos.y)));
  }
}

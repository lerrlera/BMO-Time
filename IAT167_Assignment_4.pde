// IAT 167 - Final Assignment 4
// by Valeriya Ten (ID: 301572044)

/*
This is a tile based game called BMO Time (based on Adventure Time animated series) where the player (aka BMO) 
explores the world, shoots enemies, and collects candies as valuable items. The main goal is to collect all 
candies in each level. Once all items are collected, the player automatically progresses to the next level. 
The player can pick up health packs, shields and powerups.

All graphics were made by me.

Sounds:
https://www.zapsplat.com/
https://pixabay.com/

Youtube (sounds):
Ouch: https://www.youtube.com/watch?v=0UQK3ozq0Mk&ab_channel=Soundlaboratory
Yay BMO: https://www.youtube.com/watch?v=y4f2ZsRCK0g&t=197s&ab_channel=NoorVerkroost
Level 1: https://www.youtube.com/watch?v=kKLzVv4hb8w&t=362s&ab_channel=OSC
Level 3: https://www.youtube.com/watch?v=wlKiWvLejmY&ab_channel=Inthehollowhills
*/

// libraries
import controlP5.*;
import ddf.minim.*;

// objects
Player player;
ArrayList<BasicEnemy> enemies = new ArrayList<BasicEnemy>();
ArrayList<Tile> tiles = new ArrayList<Tile>();
ArrayList<Health> healths = new ArrayList<Health>();
ArrayList<Candy> candies = new ArrayList<Candy>();
ArrayList<Shield> shields = new ArrayList<Shield>();
ArrayList <PowerUp> powerups = new ArrayList<PowerUp>();

// game states/levels
final int HOW_TO      = -1;
final int INTRO       = 0;
final int LEVEL_ONE   = 1;
final int LEVEL_TWO   = 2;
final int LEVEL_THREE = 3;
final int WON         = 4;
final int LOST        = 5;
int current_level;

// whether each state/level has been intialized yet
// prevents setup from being executed more than once 
boolean setup1 = false;
boolean setup2 = false;
boolean setup3 = false;
boolean setupIntro = false;
boolean setupWon = false;
boolean setupLost = false;
boolean setupHowto = false;

// buttons
ControlP5 cp5;
Button start;
Button restart;
Button next;
Button back;
color buttonColor = color(123,64,252);

// sounds
Minim minim;        
AudioPlayer gameplay, gameplay3, win, lose;
AudioPlayer laser, health, candy, powerup, bmo, hurt;
final String GAMEPLAY = "data/gameplay.mp3";
final String GAMEPLAY3 = "data/gameplay3.mp3";
final String LASER = "data/laser.mp3";
final String HEALTH = "data/health.mp3";
final String CANDY = "data/candy.mp3";
final String BMO = "data/bmo.mp3";
final String POWERUP = "data/powerup.mp3";
final String HURT = "data/hurt.mp3";
final String WIN = "data/win.mp3";
final String LOSE = "data/lose.mp3";

// misc
int tileSize = 200;
int movingState = 0;
int time = 0;
color boxColor = color(243,255,77);

// initial positions
int playerInit1 = 67;
int[] enemyInit1 = {41,126,74};
int healthInit1 = 109;
int[] candyInit1 = {48,113,119};
int playerInit2 = 68;
int[] enemyInit2 = {31,140,110,100,70,55,126};
int healthInit2 = 126;
int[] candyInit2 = {30,121,86};
int shieldInit2 = 81;
int playerInit3 = 46;
int[] enemyInit3 = {75,126,170};
int[] staticEnemyInit3 = {75, 91, 109};
int bossInit3 = 92;
int healthInit3 = 89;
int shieldInit3 = 121; // fix it
int[] candyInit3 = {55,93,186};
int powerupInit3 = 70;

void setup() {
  size(750,750);
  
  // setup buttons
  cp5 = new ControlP5(this);
  start = cp5.addButton("start")
    .setValue(0)
    .setPosition(120,height-250)
    .setSize(170,80)
    ;
  cp5.getController("start").hide();
  
  next = cp5.addButton("next")
    .setValue(0)
    .setPosition(width-130,height-60)
    .setSize(100,50)
    ;
  cp5.getController("next").hide();
  
  back = cp5.addButton("back")
    .setValue(0)
    .setPosition(30,height-60)
    .setSize(100,50)
    ;
  cp5.getController("back").hide();
  
  restart = cp5.addButton("restart")
    .setValue(0)
    .setPosition(width/2.7,height/1.5)
    .setSize(170,80)
    ;
  cp5.getController("restart").hide();
  
  // style buttons
  buttons();
  
  // sound
  loadSound();
}

void draw() {
  background(255);
  
  switch (current_level) {
    case INTRO:
      intro();
      break;
    case HOW_TO:
      howto();
      break;
    case LEVEL_ONE:
      level1();
      break;
    case LEVEL_TWO:
      level2();
      break;
    case LEVEL_THREE:
      level3();
      break;
    case WON:
      won();
      break;
    case LOST:
      lost();
      break;
    default:
      print("wrong state");
  }
}

// styling buttons
void buttons() {
  PFont font = loadFont("GTPressuraMonoTrial-Md-25.vlw");
  start.getCaptionLabel().setFont(font);
  start.setColorForeground(color(buttonColor)); //color when the mouse hovers
  start.setColorBackground(color(0));
  
  next.getCaptionLabel().setFont(font);
  next.setColorForeground(color(buttonColor)); //color when the mouse hovers
  next.setColorBackground(color(0));
  
  back.getCaptionLabel().setFont(font);
  back.setColorForeground(color(buttonColor)); //color when the mouse hovers
  back.setColorBackground(color(0));
  
  restart.getCaptionLabel().setFont(font);
  restart.setColorForeground(color(buttonColor)); //color when the mouse hovers
  restart.setColorBackground(color(0));
}

// control event (current_level) for buttons
void controlEvent(ControlEvent event) {
  
  // start button is pressed start instructions
  if (event.getController().getName() == "start") {
    current_level = HOW_TO;
    cp5.getController("start").hide();
  }
  
  // next button is pressed start level one
  if (event.getController().getName() == "next") {
    current_level = LEVEL_ONE;
    cp5.getController("next").hide();
  }
  
  // back button is pressed return back to start
  if (event.getController().getName() == "back") {
    current_level = INTRO;
    cp5.getController("back").hide();
  }
  
  
  // restart button is pressed return to intro
  if (event.getController().getName() == "restart") {
    current_level = INTRO;
    cp5.getController("restart").hide();
  }
}

// display candies at the top right
void displayCandies() {
  PImage candy = loadImage("data/candy.png");
  fill(boxColor);
  rect(450,20,280,40);
  image(candy,480,40,40,40);
  fill(0);
  textSize(20);
  text("CANDIES COLLECTED: " + player.candyCount,610,47);
}

// LEVEL 1: add intro text box at the beginning
void introText1() {
  setFontSettings();
  if(millis() < time + 9000) {
    fill(255,193,248);
    rect(width-725,height-90,700,70);
    fill(0);
    textAlign(CENTER);
    textSize(15);
    text("Welcome to LEVEL 1! Collect all purple candies in the forest in order to\nsave BMO's friends. BE CAREFUL!!! Lumpy Space Princesses are in a bad mood...",width/2,height-60);
    }
}

// LEVEL 2: add intro text box at the beginning
void introText2() {
  setFontSettings();
  if(millis() < time + 9000) {
    fill(255,193,248);
    rect(width-725,height-90,700,70);
    fill(0);
    textAlign(CENTER);
    textSize(15);
    text("You made it to LEVEL 2!! Find all candies once again but be extra careful.\nSeems like it's more dangerous here...Good luck!",width/2,height-60);
    }
}

// LEVEL 3: add intro text box at the beginning
void introText3() {
  setFontSettings();
  if(millis() < time + 9000) {
    fill(255,106,106);
    rect(width-725,height-90,700,70);
    fill(0);
    textAlign(CENTER);
    textSize(15);
    text("WELCOME TO THE UNDERWORLD!! Find 3 last candies and defeat the Peppermint Butler!\nHe is your final boss!",width/2,height-60);
    }
}

// print level at the start of each level
void levelText(int level) {
  setFontSettings();
  if(millis() < time + 5000) {
    text("LEVEL " + level, width-200,height/2);
  }
}

void setFontSettings()
{
  PFont font = loadFont("GTPressuraMonoTrial-Md-48.vlw");
  textFont(font, height/20);
}

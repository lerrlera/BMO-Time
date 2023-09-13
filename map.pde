// Storing maps for each level

static final int TILE_TREE = 0;
static final int TILE_GRASS = 1;
static final int TILE_PATH = 2;
static final int TILE_PATH_D = 3;
static final int TILE_RIVER = 4;
static final int TILE_RED_TREE = 5;
static final int TILE_RED_RIVER = 6;
static final int TILE_DARK_PATH = 7;
static final int TILE_BLACK_TREE = 8;

// level 1 map
int[][] map1 = 
{
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 1, 1, 0, 1, 0, 0, 2, 0, 0, 0},
  {0, 0, 1, 2, 1, 1, 2, 2, 2, 2, 0, 0, 0},
  {0, 0, 1, 2, 0, 0, 2, 1, 0, 1, 1, 0, 0},
  {0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0 ,0},
  {0, 0, 0, 0, 2, 0, 0, 2, 0, 0, 0, 0, 0},
  {0, 0, 1, 1, 2, 0, 0, 2, 1, 1, 0, 0, 0},
  {0, 0, 1, 0, 2, 2, 0, 2, 0, 1, 0, 0 ,0},
  {0, 0, 1, 0, 2, 2, 2, 2, 2, 1, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}    // 13x13
};

// level 2 map
int[][] map2 = 
{
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0},
  {0, 0, 4, 3, 4, 4, 3, 3, 3, 0, 1, 0, 0},
  {0, 0, 4, 3, 3, 3, 3, 3, 3, 3, 1, 1 ,0},
  {0, 0, 3, 3, 0, 0, 0, 1, 0, 1, 0, 0, 0},
  {0, 0, 4, 3, 3, 0, 1, 0, 1, 1, 0, 0, 0},
  {0, 0, 4, 3, 3, 3, 0, 2, 0, 1, 1, 0 ,0},
  {0, 0, 4, 0, 1, 3, 1, 3, 3, 3, 3, 0, 0},
  {0, 0, 4, 0, 1, 3, 3, 3, 0, 1, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}    // 13x13
};

// level 3 map
int[][] map3 = 
{
  {5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5},
  {5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5},
  {5, 5, 7, 6, 6, 6, 6, 7, 7, 5, 7, 5, 5, 5, 5},
  {5, 5, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 5, 5},
  {5, 5, 7, 6, 6, 6, 8, 8, 7, 8, 7, 7, 7, 5, 5},
  {5, 5, 7, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 5 ,5},
  {5, 5, 7, 7, 7, 7, 7, 8, 8, 7, 7, 6, 6, 5, 5},
  {5, 5, 7, 6, 6, 6, 7, 7, 7 ,8, 6, 6, 6, 5, 5},
  {5, 5, 7, 6, 6, 6, 8, 7, 7, 7, 7, 7, 6, 5, 5},
  {5, 5, 7, 6, 7, 7, 7, 7, 7, 7, 6, 6, 6, 5, 5},
  {5, 5, 7, 7, 7, 5, 6, 6, 7, 5, 6, 6, 5, 5, 5},
  {5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5},
  {5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5}    // 15x13
};

// generate maps with corresponding tiles
void generateMap(int[][] map) {
  boolean block;
  
  // iterate through rows
  for (int i = 0; i< map.length; i++) {
    // iterate through columns
    for (int j = 0; j < map[i].length; j++) {
      String path = "data/tile/tile" + map[i][j] + ".png";
      
      // if we are not on the edge of the map
      if (i != 0 && j !=0 && i !=map.length - 1 && j != map[i].length-1) {
        switch(map[i][j]) {
          // if Tree tile => block player from moving onto it
          case TILE_TREE:
            block = true;
            tiles.add(new Tile(path, new PVector(j * tileSize, i * tileSize), block));
            break;
          case TILE_GRASS:
            block = false;
            tiles.add(new Tile(path, new PVector(j * tileSize, i * tileSize), block));
            break;
          case TILE_PATH:
            block = false;
            tiles.add(new Tile(path, new PVector(j * tileSize, i * tileSize), block));
            break;
          case TILE_PATH_D:
            block = false;
            tiles.add(new Tile(path, new PVector(j * tileSize, i * tileSize), block));
            break;
          case TILE_RIVER:
            block = true;
            tiles.add(new Tile(path, new PVector(j * tileSize, i * tileSize), block));
            break;
          case TILE_RED_TREE:
            block = true;
            tiles.add(new Tile(path, new PVector(j * tileSize, i * tileSize), block));
          case TILE_RED_RIVER:
            block = true;
            tiles.add(new Tile(path, new PVector(j * tileSize, i * tileSize), block));
            break;
          case TILE_DARK_PATH:
            block = false;
            tiles.add(new Tile(path, new PVector(j * tileSize, i * tileSize), block));
            break;
          case TILE_BLACK_TREE:
            block = true;
            tiles.add(new Tile(path, new PVector(j * tileSize, i * tileSize), block));
            break;
          default:
            break;
        }
      }
      else {
        block = true;
        tiles.add(new Tile(path, new PVector(j * tileSize, i * tileSize), block));
      }
    }
  }
}

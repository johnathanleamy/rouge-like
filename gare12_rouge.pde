/* 
** gare12_rouge.java
** 
** Johnathan Leamy
** Comp Sci ICS 4U1
** ISP - Rouge
** 23 June 2021
**
** This is the game rouge which is similar to a turn based pacman with a randomly generated level
*/

// the spawn rates are in the Floor constructor
// i'm pretty bad at this game and didn't really play test
// the values so it might be either way too hard or way too easy
// they only value that cant be changed is the key spawn rate 

//

//the amount if treasure needed  to win
int treasureNeeded = 5;
int treasure = 0;
int pots = 0;
int potsHeld = 0;
IntList avalibleRooms;
Rooms[] floor;
Floor board;
Visuals v;
ArrayList<Enemy> enemys = new ArrayList<Enemy>();
boolean started = false;


final int oSize = 1;

int playerX;
int playerY;
int xOffset = 0;
int yOffset = 0;

int size = oSize;//has to start at atleast 3 cause
              //otherwise you might just get 3 total rooms and there arnt enough keys

/*
** setup
**
** runs when the prgram first loads
** creates the frst game and the visuals object
*/
void setup(){
  // creates the canvas
  size(1000,1000);
  // creates the floor
  newGame(); //<>//
  // creates the object that handles visuals
  v = new Visuals();
  
  v.drawStart();
  
}

/*
** draw
** 
** runs every frame
** draws the board
*/
void draw(){
  if(started){
  // sets the position of the player on the board
  board.floorPlan[playerX][playerY] = 2;
  // visual things
  background(255);
  fill(0);
  // uses the visuals class to draw the floor
  v.drawFloor(board,xOffset,yOffset);
  
  }
}

int ran;
int off = 0;// 1200 with 40 tile size
int[][]maze;
int O = 0;
int W = Integer.MAX_VALUE;

/*
** makeMaze
**
** creates the version of the board used for pathfinding
*/
void makeMaze(){
  // array to store the maze
  maze = new int[90][90];
  
  // loops through every tile
  for(int i = 0; i<90;i++){
    for(int j = 0; j<90;j++){
      // sets the value of the maze so that it matches the floorplan
      if(board.floorPlan[i][j] > 4
          ||board.floorPlan[i][j] == 3){
        maze[i][j] =W;
      } else {
        maze[i][j] =O;
      }
    }
  }

}
ArrayList< int[] > toLook;
ArrayList< int[] > toRemove;
ArrayList< int[] > toAdd;
int[] start = {0,0};

/*
** solveMaze
**
** really is just used to start off the recusive method
** that does the heavy lifting
*/
void solveMaze(int[] s){
  // starts the algo of useing the player cords
  start = s;
  toLook.add(start);
  adder();
  
}

/*
** adder
**
** recursive function that finds the number of moves away each node on the 
** board is from the player
** Used for pathfinding
*/
void adder(){
  for(int[] poss:toLook){
    
    int i = poss[0];
    int j = poss[1];
    int[] up = {i+1,j};
    int[] down = {i-1,j};
    int[] left = {i,j+1};
    int[] right = {i,j-1};
    
    // looks at every tile adjacent to the tile that already haas a value
    // if that tile is a floor tile it is given a value 1 more then the one adjacent to it
    if(maze[i+1][j] == O){maze[i+1][j] =
      maze[i][j] + 1;toAdd.add(up);}
    if(maze[i-1][j] == O){maze[i-1][j] = 
      maze[i][j] + 1;toAdd.add(down);}
    if(maze[i][j+1] == O){maze[i][j+1] = 
      maze[i][j] + 1;toAdd.add(left);}
    if(maze[i][j-1] == O){maze[i][j-1] = 
      maze[i][j] + 1;toAdd.add(right);}
    
    // removes all the tiles have already been checked for adjacent tiles
    toRemove.add(poss);
    
    /*Explanation
      
      by starting with the player cords each tile is going to be given a value 
      that will represent the number a tiles away it is from the player.
      any open tile adjacent to a tile that was just given a value will have 
      a value one greater since it is one move away.
      Since this a dept-first search and values are given away radiating from player 
      only the tiles that were just assigned a value will be given a value on the next run through
      
      the values also dont have to know the postion of the enemy since the enemy can later
      check what adjacent square has the lowest value
      
      
    */
    
 
    
    
  }

  toLook.addAll(toAdd);
  toLook.removeAll(toRemove);

  if(toLook.size()>0){
    // reruns the method
    // this could be done with a while loop but now i can say that i used recution
    // even if it doesnt really make sence to use
    // normaly i would do this with a while loop
    adder();
  }

}


int[][] savedPlan = new int[100][100];
int keysHeld = 0;
int wall = 8;// if its 8 the end is blocked otherwise its 9
boolean enemyTurn = true;

/*
** keyPressed
**
** runs when a key is pressed
** used for the player movement
*/
void keyPressed() {
  print(pots);
  
  // checks if the enemys will move
  // if they do this move they wont the next
  if(pots == 0 && (key == 'w'||key == 'a'||key == 's'||key == 'd')){
    pots++;
    enemyTurn = true;
  }else if(key == 'w'||key == 'a'||key == 's'||key == 'd'){
    enemyTurn = false;
    pots--;
  }else{
     enemyTurn = false;
  }
  
  // if the player has gotten three keys they will be able to walk over the blue squares
  // the blues have a original value of 8 while the walls have a value of 9
  // only values that are equal or greater to wall are considered walls
  // thus if wall is 9 then the blues will not be viewed as walls
  if(keysHeld == 3){
    wall = 9;//it needs to be changed back when the level is done
  }
  // checks what key the player pressed and changes the values of the player cords based off that
  // the cords will only change if the value of the tile is not a wall
  // also changes the offset to adject the 'camera' besed on how much the player moved
  if(started && key == 'd' && board.floorPlan[playerX+1][playerY] < wall){
    board.floorPlan[playerX][playerY] = 0;
    playerX++;
    xOffset -= v.tileSize;
  }
  if(started && key == 'w' && 
      board.floorPlan[playerX][playerY-1] < wall){
    board.floorPlan[playerX][playerY] = 0;
    playerY--;
    yOffset += v.tileSize;
  }
  if(started && key == 'a' &&
      board.floorPlan[playerX-1][playerY] < wall){
    board.floorPlan[playerX][playerY] = 0;
    playerX--;
    xOffset += v.tileSize;
  }
  if(started && key == 's' &&
      board.floorPlan[playerX][playerY+1] < wall){
    board.floorPlan[playerX][playerY] = 0;
    playerY++;
    yOffset -= v.tileSize;
  }
  
  // starts the game
  if(key == ' ' && !started){
    started = true;
    newMatch();
    newGame();
  }
  
  // when the player uses a pot
  if(key == ' ' && started && potsHeld > 0){
    pots++;
    potsHeld--;
  }
  
  // a few methods for menu control
  if(key == 'r' && started){
    newMatch();
    newGame();
  }
  
  if(key == 't' && started){
    started = false;
    newMatch();
    newGame();
    v.drawStart();
  }
  
  if(key == 'y'){
    exit();
  }
  
  // a few methods for when a player collects something
  
  // check to see if the player got a key
  if(board.floorPlan[playerX][playerY] == 3){
    keysHeld++;
    print(keysHeld);
  }
  
  if(board.floorPlan[playerX][playerY] == 5){
    treasure++;
    print(treasure);
    if(treasure == treasureNeeded){
      started = false;
      v.drawEnd();
    }
  }
  
  if(board.floorPlan[playerX][playerY] == 6){
    potsHeld++; 
  }
  
  if(board.floorPlan[playerX][playerY] == 8){// the level is over
    newGame();
   }
   
   
  
  toLook = new ArrayList<int []>();
  toAdd = new ArrayList<int []>();
  toRemove = new ArrayList<int []>();
  
  // remakes the enemy pathing every time the player moves
  makeMaze();
  
  int[] playerCords = {playerX, playerY};
  
  solveMaze(playerCords);
  
  // moves each enemy
  for(Enemy enemy:board.addEne()){
    
    // checks if the player dies
    if(enemy.x == playerY && enemy.y == playerX){
      newMatch();
      newGame();
      break;
    }
    
    board.floorPlan[enemy.y][enemy.x] = 0;
  
    if(enemyTurn){
      enemy.move(maze,board.floorPlan);
    }
    
    board.floorPlan[enemy.y][enemy.x] = 4;
    
    // checks if the player dies
    if(enemy.x == playerY && enemy.y == playerX){
      newMatch();
      newGame();
      break;
    }
  }

}

/*
** newMatch
**
** resets variable that only change after the player dies
*/
void newMatch(){
size = oSize;// probably needs more variables that i cant think of right now
treasure = 0;
pots = 0;
potsHeld = 0;
}

/*
** resetVars
**
** resets variable after the player makes it to the next room
*/
void resetVars(){
  
  // resets values that need to be a certain vale at the start of a level
  wall = 8;
  keysHeld = 0;
  playerX = 42;
  playerY = 42; 
  
  xOffset = 0;
  yOffset = 0;
  
  toLook = new ArrayList<int []>();
  toAdd = new ArrayList<int []>();
  toRemove = new ArrayList<int []>();
  enemys.clear();
  
}

/*
** newGame
**
** used for after the player makes it to the next room
*/
void newGame(){
  // creats a new floor plan that is 2 rooms larger
  resetVars();
  size += 2;
  board = new Floor(size);
}

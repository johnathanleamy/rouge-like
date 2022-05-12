/* 
** Visuals.java
** 
** Johnathan Leamy
** Comp Sci ICS 4U1
** ISP - Rouge
** 23 June 2021
**
** handles all the visual aspects
*/

class Visuals{
  int tileSize  = 40;
  
  /*
  **  drawFloor
  **
  ** draws the main floor
  */
  void drawFloor(Floor f, int xOffset, int yOffset){// if i move offset into the floor class 
                                                    // chance the vars to f.xOffset
  int off = 1200;// 1200 with 40 tile size  
   
  
  for(int i =0; i<f.floorPlan.length;i++){
       for(int j = 0; j<f.floorPlan.length;j++){
         if(f.floorPlan[i][j] == 9){//wall
           rect(i*tileSize-off+xOffset,j*tileSize-off
         +yOffset,tileSize,tileSize);}
         else if (f.floorPlan[i][j] == 2){//player
           fill(255,0,0);
           rect(i*tileSize-off+xOffset,j*tileSize-off
           +yOffset,tileSize,tileSize);
           fill(0);
         }else if (f.floorPlan[i][j] == 3){//key
           fill(0,255,0);
           rect(i*tileSize-off+xOffset,j*tileSize-off
           +yOffset,tileSize,tileSize);
           fill(0);
         }else if (f.floorPlan[i][j] == 8){//door
           fill(0,0,255);
           rect(i*tileSize-off+xOffset,j*tileSize-off
           +yOffset,tileSize,tileSize);
           fill(0);
         }else if (f.floorPlan[i][j] == 4){//enemy
           fill(0,100,100);
           rect(i*tileSize-off+xOffset,j*tileSize-off
           +yOffset,tileSize,tileSize);
           fill(0);
         }else if (f.floorPlan[i][j] == 5){//treasure
           fill(100,100,100);
           rect(i*tileSize-off+xOffset,j*tileSize-off
           +yOffset,tileSize,tileSize);
           fill(0);
         }else if (f.floorPlan[i][j] == 6){//potion
           fill(221,160,221);
           rect(i*tileSize-off+xOffset,j*tileSize-off
           +yOffset,tileSize,tileSize);
           fill(0);
         }
       }
    }
    
    //shows the user the number of things they have
    fill(255,0,0);
    text("treasure: "+ treasure, 15,100);
    text("Keys: "+ keysHeld, 15,120);
    text("Potions: " + potsHeld,15,140);
  
    
  }
  
  /*
  ** drawStart
  **
  ** draws the start screen
  */
  void drawStart(){
    
    background(255);
    
    int x = width/10;
    float y = height/2.4;
    
    int lineSpace = 40;
    
    PFont font = createFont("SimSun", 32);
    
    fill(0);
    
    textFont(font);
    
    textSize(14);
    
    text("Rouge", width/2, height/5);
    
    text("Press r to start a new game\nPress t to return to start screen"+
    "\nPress y to exit the program", width/1.4, height/8);
    
    text("How to play:", width / 10, height/2.8);
    
    text("- The goal of the game is to collect all the tresure"+
        " that is placed randomly around the map", x, y);
        
    text("- You will be placed on a radomly generted floor"+
    " and your goal is to collect all three keys and return back to the door", 
    x, y + lineSpace);
    
    text("- You can move up, down, left, or right once every turn using wasd", x, y + lineSpace*2);
    
    text("- Monsters can also move once every 2 turns"+
    " and if a monster touches you all progress is lost", x, y + lineSpace*3);
    
    text("- You can delay a mosters turn"+
    " by one move by pressing space while holding a potion",x,y + lineSpace*4);
    
    text("- Inorder to enter the door you must collect each of the 3 keys", x, y + lineSpace*5);
    
    text("- Every time you go through a door"+
    " the floor will become larger and more mosters will spawn", x, y + lineSpace*6);
    
    text("- To win the game you must collect"+
    " 5 piecesses of treasure",x,y+lineSpace*7);
    
    text("Press SPACE to begin", x, y+lineSpace * 8);
    
    text("Every object is represented by"+
    " a rectangle with a different colour", x, y + lineSpace * 9);
    
    text("Player: ", x + 100, y + lineSpace * 11);     
    fill(255,0,0);    
    rect(x + 150,y + lineSpace * 11 - 20,tileSize,tileSize);
   
    fill(0);    
    text("Monster: ", x + 200, y + lineSpace * 11);     
    fill(0,100,100);    
    rect(x + 270,y + lineSpace * 11 - 20,tileSize,tileSize);
        
    fill(0);    
    text("Monster: ", x + 200, y + lineSpace * 11);    
    fill(0,100,100);    
    rect(x + 270,y + lineSpace * 11 - 20,tileSize,tileSize);
    
    fill(0);    
    text("Door: ", x + 320, y + lineSpace * 11);    
    fill(0,0,255);    
    rect(x + 365,y + lineSpace * 11 - 20,tileSize,tileSize);
    
    fill(0);    
    text("Key: ", x + 420, y + lineSpace * 11);    
    fill(0,255,0);    
    rect(x + 450,y + lineSpace * 11 - 20,tileSize,tileSize);
    
    fill(0);
    text("Treasure: ", x + 520, y + lineSpace * 11); 
    fill(100,100,100);
    rect(x + 590,y + lineSpace * 11 - 20,tileSize,tileSize);
    
    fill(0);
    text("Potion: ", x + 640, y + lineSpace * 11); 
    fill(221,160,221);
    rect(x + 690,y + lineSpace * 11 - 20,tileSize,tileSize);
  }
  
  /* 
  ** drawEnd
  **
  ** draws the you win screen
  */
  void drawEnd(){
    fill(255,0,0);
    textSize(50);
    text("          YOU WIN\npress space to play again",300,height/2);
    
    fill(0);   
    textSize(14);
  }


}

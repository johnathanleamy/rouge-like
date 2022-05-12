/* 
** Enemy.java
** 
** Johnathan Leamy
** Comp Sci ICS 4U1
** ISP - Rouge
** 23 June 2021
**
** holds x any values for enemys and handles the movment
*/
class Enemy{
  int W = Integer.MAX_VALUE;
  int x;
  int y;
  int[][] maze;
  //constructor
  Enemy(int xs, int ys){
    x = xs;
    y = ys;
  }
  int[] nextMove;
  
  /*
  ** move
  **
  ** finds the adjacent square that is closest to the player
  */
  void move(int[][] maze, int[][] plan){
  
    int value = maze[y][x];
    
         if((value-1 == maze[y+1][x] && plan[y+1][x] != 4)
         || plan[y+1][x] == 2){y++;}//the check for 1 could be done in main
    else if((value-1 == maze[y-1][x] && plan[y-1][x] != 4) ||
            plan[y-1][x] == 2){y--;}
    else if((value-1 == maze[y][x-1] && plan[y][x-1] != 4) ||
            plan[y][x-1] == 2){x--;}
    else if((value-1 == maze[y][x+1] && plan[y][x+1] != 4) ||
            plan[y][x+1] == 2){x++;}
    value = maze[y][x];
  }  //<>//
}

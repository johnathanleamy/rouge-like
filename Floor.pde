/* 
** Floor.java
** 
** Johnathan Leamy
** Comp Sci ICS 4U1
** ISP - Rouge
** 23 June 2021
**
** creates the floor that the player must go through
*/

class Floor{
  int [][] floorPlan;
  Rooms[] floor;
      //construcor
      Floor(int s){
        floor = new Rooms[99];
        floorPlan = new int[90][90];
        createFloor(s);
        createFloorPlan();
        createThings(3,3);//three keys
        createThings(4,s-2);//enemy  
        createThings(5,int(random(size *1.5)));//treasure
        createThings(6,int(random(size))); //<>//
      }
  
  /*
  ** createFloor
  **
  ** creates the way that the rooms join together
  */
  void createFloor(int size){// asume that the mid point is 55 and the floor is 10 by 10
  
    floor[55] = new Rooms(1,5,5);
    avalibleRooms = new IntList();
    for(int i = 0; i<=size;i++){
      // get all the rooms avalible
      for(int j = 0; j<floor.length;j++){
        if(floor[j] !=null){
          avalibleRooms.append(j+1);
          avalibleRooms.append(j-1);
          avalibleRooms.append(j+10);
          avalibleRooms.append(j-10);
        }
      
     }
    // pick a random room to add
    for(int q = 0;q<avalibleRooms.size();q++){
      // removes rooms that already exist
        if(floor[avalibleRooms.get(q)]!=null){
          avalibleRooms.remove(q);
        }
    }
    int pos = avalibleRooms.get(int(random(avalibleRooms.size()-1)));
    floor[pos] = new Rooms(int(random(8)),pos%10,pos/10);
    }
  }
  
  
  /*
  ** createFloorPlan
  **
  ** adds a layout to each room from the create floor meathod
  */
  void createFloorPlan(){
    
    for(Rooms room:floor){  
      for(int i =0; i<8;i++){
        for(int j = 0; j<8;j++){
          if(room!=null){
            floorPlan[room.StartY*8+i][room.StartX*8+j] = room.layout[i][j];
          }
        }
      }
      // drawing walls
      int y = 0;
      int x = 0;
      for(int i = 0; i<floor.length;i++){ 
        if(floor[i]!=null && floor[i+1] == null){//to the bottom
                x = (floor[i].StartX+1)*8-1;
                y = floor[i].StartY*8+3;
                floorPlan[y][x] = 9;
                floorPlan[y+1][x] = 9;
        }
        if(floor[i]!=null && floor[i-1] == null){//to the top
                x = floor[i].StartX*8;
                y = floor[i].StartY*8+3;
                floorPlan[y][x] = 9;
                floorPlan[y+1][x] = 9;
        }
        if(floor[i]!=null && floor[i-10] == null){//to the left
                y = floor[i].StartY*8;
                x = floor[i].StartX*8+3;
                floorPlan[y][x] = 9;
                floorPlan[y][x+1] = 9;
        }
        if(floor[i]!=null && floor[i+10] == null){//to the top
                y = floor[i].StartY*8+7;
                x = floor[i].StartX*8+3;
                floorPlan[y][x] = 9;
                floorPlan[y][x+1] = 9;
        }
      }
    }
  }
  
  /*
  ** createThings
  **
  ** makes it so that there is a certain number of specific objects
  */
  void createThings(int type, int num){
    int count = 0;
    // find the number of keys
    for(int i = 0; i<90;i++){
      for(int j = 0; j<90;j++){
        if(floorPlan[i][j] == type){
          count++;
        }  
      }  
    }
    int r;
    int keyNum = 0;
    while(count>num){
      
      keyNum = 0;
      r = int(random(1,count));// get the key number to remove
      
      for(int h = 0; h<90;h++){
        for(int j = 0; j<90;j++){
          if(floorPlan[h][j] == type){
            keyNum++;
            if(r == keyNum){
              floorPlan[h][j] = 0;
            }
          }  
        }  
      }
    
    count--;
    }
    
  }
  
  /*
  ** addEne
  **
  ** adds all enemys to an arrayList so that
  ** they can be used in a loop
  */
  ArrayList<Enemy> addEne(){
    
    ArrayList<Enemy> enemys = new ArrayList<Enemy>();
    for(int i = 0; i<90; i++){
      for(int j = 0; j<90; j++){
        if(board.floorPlan[i][j] == 4){
          //goes through each tile and
          //if it is an enemy adds it to the array
          enemys.add(new Enemy(j,i));
        }
      }
    }
    return enemys;
  }
  
}

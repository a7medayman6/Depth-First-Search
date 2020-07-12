import java.util.Vector;


class Cell
{
   //coordinates
   int i;
   int j;
   //dimisions
   int w;
   int h;
   //grid
   int rows;
   int cols;
   //wall or not
   boolean wall = false; 
   //color
   color col;
   //visited or not
   boolean visited = false;
   //parent
   Cell parent;
   Vector<Cell> neighbours;
   
   public Cell(int i, int j, int w, int h, int rows, int cols)
   {
     col = color(255);
     this.i = i;
     this.j = j;
     this.w = w;
     this.h = h;
     this.rows = rows;
     this.cols = cols;
     this.neighbours = new Vector<Cell>();
   }
   
   public void show()
   {
      fill(this.col);
      stroke(0);
      rect(this.j * h, this.i * w, h - 1, w - 1); 
   }
   public boolean explore_Neighbours(Cell[][] grid, Stack<Cell> s, Cell end)
   {
     int di[] = { -1, 1, 0, 0, -1, -1, 1, 1};
     int dj[] = { 0, 0, 1, -1, 1, -1, -1, 1};
      
      for(int k=0; k<di.length; k++)
      {
          int new_i = this.i + di[k];
          int new_j = this.j + dj[k];

          if(new_i < 0 || new_j < 0)
              continue;
          if(new_i >= this.rows || new_j >= this.cols)
              continue;
          
          Cell neighbour = grid[new_i][new_j];
          if(neighbour.visited == true)
              continue;
          if(neighbour.wall == true)
              continue;
          
          s.push(neighbour);
          this.neighbours.add(neighbour);
          neighbour.setVisited(true);
          neighbour.setParent(this);
          if(neighbour == end)
              return true;
      }
      return false;
   }
   
   
   //SETTERS
   public void setParent(Cell parent)
   {
      this.parent = parent; 
   }
   public void setCol(color col)
   {
      this.col = col; 
   }
   public void setVisited(boolean visited)
   {
      this.visited = visited;
      this.col = color(255,255,0);
   }
   public void setWall(boolean wall)
   {
      this.wall = wall;
      this.col = color(0);
   }
   
   
   
   
   
   
   
   
   
   
}

import java.util.LinkedList; 
import java.util.Stack;
import java.util.Set;
import java.util.HashSet;
import java.util.Random;
import javafx.util.Pair;

int cols = 20;
int rows = 20;
int w, h;
int start_i=0, start_j=0;
int target_i = rows-1, target_j=cols-1;

Stack<Cell> s;
Set<Pair<Integer, Integer>> walls;
Cell root, end;
Cell grid[][];
Cell child;
boolean found;
boolean target_identified;
boolean start_identified;
boolean clicked;
boolean finished;

void setup()
{
  
   size(800, 800);
   background(255);
   target_identified = false;
   start_identified = false;
   clicked = false;
   finished = false;
   found = false;
   w = width / rows;
   h = height / cols;
   grid = new Cell[rows][cols];
   randomize_walls();
   init();
   end = grid[target_i][target_j];
   child = null;
   s = new Stack<Cell>(); 
   
}
int screenState = 0;
final int menuScreen = 0;
final int bfsScreen = 1;

void draw()
{
    if(screenState == menuScreen)
    {
       
       drawMenu();
    }
    else if(screenState == bfsScreen)
    {
       drawDFS(); 
    }
  
  
  
}
void drawMenu()
{
   
   
   background(255);
   fill(0);
   textSize(32);
   text(" MAZE SOLVER USING DEPDTH FIRST SEARCH \n", 50, 200);
   textSize(22);
   text("First Choose a Cell to be the Start Cell,\n"+
        "Then Choose another to be the Target Cell",100, 300);
   
   display("START");
  
}


void drawDFS()
{
  
  if(!clicked && mousePressed && !start_identified)
  {
     start_i = mouseY / w;
     start_j = mouseX / h;
      
     start_identified = true;
     root = grid[start_i][start_j];
     
     if(root.wall)
     {
        start_identified = false;
        clicked = false;
     }  
     else
     {
       root.parent = null;
       root.setVisited(true);
       root.col = color(0, 255, 0);
       s.push(root);
     }
     println(start_i);
     println(start_j);  
  }
  else if(clicked && mousePressed && !target_identified)
  {
    target_i = mouseY / w;
    target_j = mouseX / h;
    target_identified = true;
    end = grid[target_i][target_j];
    
    if(end.wall) 
      target_identified = false;
    else
      end.col = color(255, 0, 0);
    println(target_i);
    println(target_j);
  }
  
  if(start_identified && target_identified)
  {
    
    if(!s.isEmpty() && !found)
    {
      Cell current = s.pop();
      if(current == end)
      {
          found = true;
          child = end;
          end.setCol(color(0, 255, 0));
          println("Found\n" + end.i + "\t" + end.j);
      }
      else
      {
          if(current.explore_Neighbours(grid, s, end))
          {
              found = true;
              child = end;
              end.setCol(color(0, 255, 0));
              println("Found\n" + end.i + "\t" + end.j);
          }
      }
    }
    else if(s.isEmpty())
    {
       finished = true;
    }
    else if(found)
    {
        
        child = find_parent(child);
        
        
    } 
    
  }
  
  show();
  if(finished)
      display("AGAIN");
  
}

Cell find_parent(Cell temp)
{
   Cell current = temp;
   if(current.parent != null)
   {
       current = current.parent;
       current.setCol(color(0, 255, 0));
   }
   else
   {
     current.setCol(color(0, 192, 255));
     end.col = color(255, 0, 0);
     finished = true;
   }
   return current;
}

void show()
{
  for(int i=0; i<rows; i++)
  {
     for(int j=0; j<cols; j++)
     {
        grid[i][j].show();
     }
  } 
}

void init()
{
  for(int i=0; i<rows; i++)
  {
     for(int j=0; j<cols; j++)
     {
        grid[i][j] = new Cell(i, j, w, h, rows, cols);
        if(walls.contains(new Pair(i, j)))
          grid[i][j].setWall(true);
     }
  }
}

void randomize_walls()
{
   walls = new HashSet<Pair<Integer, Integer>>();
   Pair<Integer, Integer> p;
   int number_of_walls = ((rows*cols) / 3);
   Random rnd = new Random();
   
   for(int n=0; n<number_of_walls; n++)
   {
       int i = rnd.nextInt(rows);
       int j = rnd.nextInt(cols);
       p = new Pair(i, j);
       if(walls.contains(p))
       {
         n--;
       }
       else
         walls.add(p);
         
   }
   
}
void display(String msg)
{
       delay(100);
       float x = 300;
       float y = 400;
       float w = 120;
       float h = 80;
       fill(255);
       rect(300, 400,w,h);
       fill(0);
       textSize(26);
       text(msg,320, 450);
       
       if(mousePressed)
       {
          if(mouseX>x && mouseX <x+w && mouseY>y && mouseY <y+h)
          {
             fill(0);
             finished = false;
             setup();
             screenState = bfsScreen;
          } 
       }
}
  
void mouseClicked()
{
  if(!clicked && start_identified)
  {
    clicked = true;    
  }
  
}

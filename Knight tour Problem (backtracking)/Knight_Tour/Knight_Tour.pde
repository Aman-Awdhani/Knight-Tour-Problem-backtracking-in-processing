
int size = 6;
int space;

ArrayList<PVector> linesPosition ;

int[][] movesBoard = new int[size][size];

void setup() {


  linesPosition = new ArrayList<PVector>(size*size);

  //adding zero vector in linesPosition
  for (int i=0; i<size*size; i++) {

    linesPosition.add(i, new PVector(0, 0));
  }

  size(400, 400);
  background(0);
  space = width/size;

  solve();
}

void solve() {

  grid();

  movesBoard[0][0] = 1;
  linesPosition.set(0, new PVector(0, 0));

  //invoking recursion
  if (knightMove(movesBoard, 0, 0, 2)) {
    printNumbers();
    drawLine();
  } else print("no solution");
}

//check for legal move
boolean isLegalMove(int xPos, int yPos) {
  if (xPos >= 0 && yPos >= 0 && xPos < size && yPos < size) {
    if (movesBoard[xPos][yPos] == 0)
    {
      return true;
    }
  }
  return false;
}

boolean knightMove(int[][] board, int x, int y, int count) {

  if (count == size*size+1)
    return true;         

  //going through all knight moves
  for (int i=-2; i<3; i++) { 
    for (int j=-2; j<3; j++) {

      int xPos = x+i;
      int yPos = y+j;          

      //checking for the knight moves
      if (abs(i) != abs(j) && i != 0 && j != 0 )
      {      

        if (isLegalMove(xPos, yPos)) {               

          board[xPos][yPos] = count;

          //knightMove call itselfs ( recursion )
          if (knightMove(board, xPos, yPos, count+1)) {
            return true;
          } else {        
            //setting value back to 0
            board[xPos][yPos] = 0;
          }
        }
      }
    }
  }

  return false;
}

//makingGrid
void grid() {

  stroke(255);
  strokeWeight(3);

  for (int i=0; i<=height; i+=space) { 
    for (int j=0; j<=width; j+=space) {

      line(i, j, i+space, j);
      line(i, j, i, j+space );
    }
  }
}

//drawing lines between moves
void drawLine() {

  stroke(255, 0, 0);
  strokeWeight(1);
  for (int i=0; i<size*size; i++) {

    if (i+1<size*size)
      line(linesPosition.get(i).x, linesPosition.get(i).y, linesPosition.get(i+1).x, linesPosition.get(i+1).y  );
  }
}

//display numbers
void printNumbers() {

  textSize(20);

  for (int i=0; i<size * space; i+=space) {         
    for (int j=0; j<size * space; j+=space) { 

      linesPosition.set(movesBoard[i/space][j/space]-1, new PVector(j + space/2, i + space/2));
      text( movesBoard[i/space][j/space], j + space/2, i + space/2);
    }
  }
}

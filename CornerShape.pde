// FILE CONTAINING METHODS TO DRAW CORNER SHAPES.
// based on value retrieved based on the hashmap key (option), draw the shape using coordinates x and y.
void drawCornerShape(int option, float x, float y, int colour){
  fill(colour); // draw shape in colour of rectangle it is associated with by default.
  if (option == 0){
    drawRoundel(x,y); // napped on train.
  }
  else if (option == 1){
    drawTriangle(x,y); // napped in bed.
  }
  else if (option == 2){
    drawSquare(x,y); // napped on bed.
  }
  else if (option == 3){
    drawBook(x,y); // napped in library.
  }
}

// method to draw underground symbol.
void drawRoundel(float x, float y){
  // arguments passed in: x and y coordinate variables 
  // (top-left corner of rectangle to draw on passed as variable, center of the roundel shape).
  
  colorMode(RGB, 255, 255, 255); // change colour mode.
  strokeWeight(0.5); // make stroke weight more delicate so shape detail can be seen better.
  
  // Red outer circle.
  fill(255,0,0);
  circle(x, y, 10);
  
  // White inner circle.
  fill(255);
  circle(x, y, 6);
  
  // Indigo rectangle
  fill(0,0,255);
  // Set rectMode to CENTER (x and y coordinates are now taken from center instead of top-left corner)
  rectMode(CENTER);  
  rect(x, y, 13, 2);
  rectMode(CORNER);
  
  colorMode(HSB,1,1,1); // revert colour mode (for consistency).
  strokeWeight(1); // revert stroke weight (so it doesn't affect other drawings outside this method).
}

// method to draw triangle.
void drawTriangle(float x, float y){
  triangle(x-5, y+5, x, y-5, x+5, y+5);
}

// method to draw square.
void drawSquare(float x, float y){
  rectMode(CENTER); 
  square(x,y,10);
  rectMode(CORNER);
}

// method to draw book-like rectangle.
void drawBook(float x, float y){
  // outside rectangle of book.
  rectMode(CENTER);
  rect(x, y, 10,8);
  
  // inside rectangles of book (pages).
  colorMode(RGB, 255, 255, 255); // change colour mode.
  strokeWeight(0);
  fill(255,200);
  rect(x-2, y, 4,8);
  rect(x+2, y, 4,8);
  
  colorMode(HSB,1,1,1); // revert colour mode (for consistency).
  strokeWeight(1); // revert stroke weight (so it doesn't affect other drawings outside this method).
  rectMode(CORNER);
}

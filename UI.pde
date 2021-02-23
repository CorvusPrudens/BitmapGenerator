void drawGrid() {

  int offset = 5;
  float ratio = (float)gridWidth/ (float) gridHeight;
  float tempw = 0;
  float temph = 0;
  
  float maxw = width - 100;
  float maxh = height - 200;
  if (ratio >= 1) {
     tempw = maxw;
     temph = maxw/ratio;
     if (temph > maxh) {
       ratio = maxh/temph;
       temph = maxh;
       tempw *= ratio;
     }
  } else {
     temph = maxh;
     tempw = maxh*ratio;
     if (tempw > maxw) {
       ratio = maxw/tempw;
       tempw = maxw;
       temph *= ratio;
     }
  }
  
  int side = 0;
  
  if (gridWidth < gridHeight) {
    side = int((temph/gridHeight) - offset);
  } else {
    side = int((tempw/gridWidth) - offset);
  }
  
  //println(tempw, temph);
  
  int x = int(((float)width - (side + offset)*gridWidth)/2.0);
  int y = int(((float)(height - 100) - (side + offset)*gridHeight)/2.0);

  fill(0);
  stroke(255);
  
  int count = 0;
  
  for (int j = 0; j < gridWidth; j++) {
    for (int i = 0; i < gridHeight; i++) {
      if (pressed) {
        int lx = x + offset*j + side*j;
        int ly = y + offset*i + side*i;
        if (mouseX < lx || mouseX > lx + side || mouseY < ly || mouseY > ly + side) {
        } else {
          if (init){
            if (grid[i][j] == false){
             start = false; 
            }else{
             start = true; 
            }
          }
          if (grid[i][j] == false && start == false){
            grid[i][j] = true;
          }else if (grid[i][j] == false && start == true){
            grid[i][j] = false;
          }
          
          if (grid[i][j] == true && start == false){
            grid[i][j] = true;
          }else if (grid[i][j] == true && start == true){
            grid[i][j] = false;
          }
        }
      }
      if (released){
        int lx = x + offset*j + side*j;
        int ly = y + offset*i + side*i;
        if (mouseX < lx || mouseX > lx + side || mouseY < ly || mouseY > ly + side) {
        } else {
          if (grid[i][j] == true){
            grid[i][j] = true;
          }else{
            grid[i][j] = false;
          }
        }
      }
      if (grid[i][j] == false) {
        fill(0);
      } else {
        fill(255);
      }
      rect(x + offset*j + side*j, y + offset*i + side*i, side, side);
      
      fill(255);
      text(count, x + offset*j + side*j + 12, y + offset*i + side*i + 12);
      count++;
    }
  }
}

void clearButton(int x, int y, int w, int h) {
  fill(255);
  rect(x, y, w, h);
  textAlign(CENTER, CENTER);
  fill(0);
  text("Clear", x + w/2, y + h/2);

  if (pressed) {
    if (mouseX < x || mouseX > x + w || mouseY < y || mouseY > y + h) {
    } else {
      cp5.get(Textfield.class,"Character Name").setText("");
      for (int i = 0; i < gridWidth; i++){
       for (int j = 0; j < gridHeight; j++){
         grid[j][i] = false;
       }
      }
    }
  }
}

void saveButton(int x, int y, int w, int h){
  
  fill(255);
  rect(x, y, w, h);
  textAlign(CENTER, CENTER);
  fill(0);
  text("Save", x + w/2, y + h/2);
  
  if (init) {
    if (mouseX < x || mouseX > x + w || mouseY < y || mouseY > y + h) {
    } else {
      textValue = cp5.get(Textfield.class,"Character Name").getText();
      //writeCharacter(textValue);
      writeSpriteStatic(textValue, gridWidth, gridHeight);
    }
  }
}

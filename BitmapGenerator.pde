import controlP5.*;

int gridWidth = 8;
int gridHeight = 16;

int wordLen = 8;

boolean grid[][] = new boolean[gridHeight][gridWidth];
boolean pressed = false;
boolean reset = true;
boolean released = false;
boolean init = false;
boolean start = false;

String textValue = "";

ControlP5 cp5;

PrintWriter pw = null;

String path = "sprites.cor";

void settings() {
  float ratio = (float) gridWidth/ (float) gridHeight;
  float tempw = 0;
  float temph = 0;
  
  float maxw = 1920;
  float maxh = 900;
  
  float minx = 800;
  float miny = 500;
  if (ratio >= 1) {
     tempw = maxw;
     temph = maxw/ratio;
     if (temph > maxh) {
       ratio = maxh/temph;
       temph = maxh;
       tempw *= ratio;
     }
     if (temph < miny) {
        temph = miny; 
     }
  } else {
     temph = maxh;
     tempw = maxh*ratio;
     if (tempw > maxw) {
       ratio = maxw/tempw;
       tempw = maxw;
       temph *= ratio;
     }
     if (tempw < minx) {
       tempw = minx;
     }
  }
  
  size((int)tempw, (int)temph + 100);
  println(width, height);
}


void setup() {
  for (int i = 0; i < gridHeight; i++) {
    for (int j = 0; j < gridWidth; j++) {
      grid[i][j] = false;
    }
  }
  
  //size(1000, 800);
  
  cp5 = new ControlP5(this);
  
  PFont font = createFont("arial", 20);
  
  cp5.addTextfield("Character Name")
     .setPosition(width/2 - 100, height - 100)
     .setSize(200,40)
     .setFont(font)
     .setFocus(false)
     .setColor(color(255))
     ;
}

void draw() {
  background(0);
  drawGrid();
  clearButton(width/2 - 200 - 100, height - 100, 100, 50);
  saveButton(width/2 + 200, height - 100,  100, 50);
  
  init = false;
}

void mousePressed(){
  pressed = true;
  init = true;
}

void mouseReleased(){
  pressed = false;
  released = true;
}

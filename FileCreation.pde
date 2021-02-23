int idx(int x, int y, int w) {
  return  x + y*w;
}

void writeCharacter(String charName) {

  if (charName != "") {

    boolean found = false;
    int charWidth = 0;
    int charHeight = 0;

    for (int i = gridWidth - 1; i > -1; i--) {
      for (int j = gridHeight - 1; j > -1; j--) {
        if (grid[j][i] == true) {
          found = true;
          break;
        }
      }
      if (found) {
        charWidth = i + 1;
        break;
      }
    }

    found = false;
    for (int j = 0; j < gridHeight; j++) {
      for (int i = 0; i < gridWidth; i++) {
        if (grid[j][i] == true) {
          found = true;
          break;
        }
      }
      if (found) {
        charHeight = gridHeight - j;
        break;
      }
    }

    int flatgrid[] = new int[charWidth*charHeight];

    //println(charWidth, charHeight);

    //for (int j = gridHeight - 1; j > -1; j--) {
    //  println(grid[j]);
    //  println();
    //}

    int count = 0;
    for (int j = gridHeight - 1; j > -1; j--) {
      for (int i = 0; i < gridWidth; i++) {
        if ((gridHeight - 1) - j < charHeight && i < charWidth) {
          flatgrid[count] = grid[j][i] ? 1 : 0;
          count++;
        }
      }
    }

    //println(flatgrid);

    String line1 = "$ " + charName + "[] = {";
    String line2 = "  " + str(charWidth) + ",";
    String line3 = "  " + str(charHeight) + ",";
    String linen = "}";

    StringList values = new StringList();

    values.append(line1);
    values.append(line2);
    values.append(line3);

    if (flatgrid.length > 8) {
      for (int i = 0; i < (flatgrid.length/8) + 1; i++) {
        String tempString = "  0b";
        for (int j = 0; j < 8; j++) {
          if (j + i*8 < flatgrid.length) {
            String p1 = tempString.substring(0, 4);
            String p2 = tempString.substring(4);
            tempString = p1 + flatgrid[j + i*8] + p2;
          } else {
            String p1 = tempString.substring(0, 4);
            String p2 = tempString.substring(4);
            tempString = p1 + "0" + p2;
          }
        }
        tempString += ",";
        values.append(tempString);
      }
    } else {
      String tempString = "  0b";
      for (int j = 0; j < 8; j++) {
        if (j < flatgrid.length) {
          String p1 = tempString.substring(0, 4);
          String p2 = tempString.substring(4);
          tempString = p1 + flatgrid[j] + p2;
        } else {
          String p1 = tempString.substring(0, 4);
          String p2 = tempString.substring(4);
          tempString = p1 + "0" + p2;
        }
      }
      tempString += ",";
      values.append(tempString);
    }

    values.append(linen);
    values.append("");

    for (int i = 0; i < values.size(); i++) {
      println(values.get(i));
    }

    String temp1[] = loadStrings(path);
    saveStrings(path, concat(temp1, values.array()));

    cp5.get(Textfield.class, "Character Name").setText("");
    for (int i = 0; i < gridWidth; i++) {
      for (int j = 0; j < gridHeight; j++) {
        grid[j][i] = false;
      }
    }
  }
}

void writeSpriteStatic(String spriteName, int w, int h) {
   if (spriteName != "") {
    
    int tempval = 0;
    if (h > 0 && (h & (wordLen - 1)) == 0) {
      tempval = 1 + ((h - 1)/wordLen);
    } else {
      tempval = 1 + h/wordLen;
    }
    
    // temporary solution for now
    int chars[] = new int[gridWidth];
    for (int i = 0; i < chars.length; i++) {
      chars[i] = 0; 
    }
    for (int j = 0; j < gridHeight; j++) {
      for (int i = 0; i < gridWidth; i++) {
        if (grid[j][i]) chars[i] |= 1 << j;
      }
    }
    
    String lines[] = new String[1 + tempval];
    
    // lines[0] = "  // Bitmap " + str(i) + " (" + str(i % gridx) + ", " + str(i/gridx) + ")";
    lines[0] = "rom " + spriteName + "[] = {";
    for (int k = 0; k < tempval; k++) {
      String line = "  ";
      for (int j = 0; j < w; j++) {
        //println(idx(j + 1, k, w));
        print(idx(j, k, w));
        line += "0x" + hex(chars[idx(j, k, w)], round(2*(wordLen/8))) + ", ";
      }
      lines[1 + k] = line;
    }
  
    boolean done = false;
    int i = 0;
    while (!done) {
      int index = 0;
      if (lines[i].length() > 82) {
        for (int j = 81; j > -1; j--){
          if (lines[i].charAt(j) == ','){
            index = j;
            break;
          }
        }
        String newShorterLine = lines[i].substring(0, index + 1);
        String newLine = " " + lines[i].substring(index + 1, lines[i].length());
        lines[i] = newShorterLine;
        lines = splice(lines, newLine, i + 1);
      }
      i++;
      if (i == lines.length){
       done = true;
      }
    }
    String templines[] = {"}\n"};
    lines = concat(lines, templines);

    String temp1[] = loadStrings(path);
    saveStrings(path, concat(temp1, lines));

    cp5.get(Textfield.class, "Character Name").setText("");
    for (i = 0; i < gridWidth; i++) {
      for (int j = 0; j < gridHeight; j++) {
        grid[j][i] = false;
      }
    }
  }
}

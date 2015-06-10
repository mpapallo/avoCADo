import controlP5.*;

PImage avo;
ControlP5 cp5;
MultiList menu;
ListBox open;
MultiListButton del, DRect, DCirc, DLine, xform, move, MRect, MLine, MCirc;
Textarea text;
String textValue = "";
String fileName = "";
ArrayList<Rectangle> creationsR = new ArrayList<Rectangle>(); 
ArrayList<Circle> creationsC = new ArrayList<Circle>();
ArrayList<Line> creationsL = new ArrayList<Line>();
final int BOUNDARYV1 = 100, BOUNDARYV2 = 450, BOUNDARYH = 350;
final int ENDX = 800, ENDY = 700;
final int BUTTON_W = 20;
boolean SELECT_MODE = false, FIRST_CLICK = true;
boolean MENU_SCREEN = true;
boolean setup = true;
boolean gotIt = false;
int CRT_RECT = 0, CRT_LINE = 0, CRT_CIRC = 0, CRT_FILE = 0, MV_SHAPE = 0;
int temp1 = -1, temp2 = -1, tempX = -1, tempY = -1, tempZ = -1;
int tempX2 = -1, tempY2 = -1, tempM = -1;
int width = -1, length = -1, radius = -1;
String[] files;

void setup() {
  size(ENDX, ENDY);
  frame.setTitle("avoCADo");

  cp5 = new ControlP5(this);
  cp5.setColorBackground(color(150));
  cp5.setColorCaptionLabel(0);
  createMenu();
  //output = createWriter("config.txt");

  avo = loadImage("avocado.png");

  setup = false;
}

void createMenu() {
  menu = cp5.addMultiList("Menu", 0, 5, BOUNDARYV1, BUTTON_W);
  menu.setVisible(false);
  MultiListButton b;
  b = menu.add("Create", 1);
  b.add("Rectangle", 11);
  b.add("Line", 12);
  b.add("Circle", 13);
  b.setVisible(false);
  del = menu.add("Delete", 2);
  del.add("Clear all", 20);
  updateDMenu();
  del.setVisible(false);
  xform = menu.add("XForm", 3);
  move = xform.add("Move", 30);
  updateMMenu();
  xform.setVisible(false);
  b = menu.add("Edit", 4);
  b.setVisible(false);

  open = cp5.addListBox("\n            Open Part", 500, 375, 100, 200)
    .setBarHeight(25)
      .setOpen(false)
        ;

  files = loadStrings("config.txt");  
  for (int i=0; i<files.length; i++) {
    ListBoxItem lbi = open.addItem(files[i], i);
  }

  cp5.addButton("3D View")
    .setValue(5)
      .setPosition(0, 130)
        .setSize(BOUNDARYV1, BUTTON_W)
          .setVisible(false)
            ;
  cp5.addButton("Save As")
    .setBroadcast(false)
      .setValue(6)
        .setPosition(0, 180)
          .setSize(BOUNDARYV1, BUTTON_W)
            .setVisible(false)
              .setBroadcast(true);
  ;
  cp5.addButton("             New Part")
    .setPosition(200, 350)
      .setSize(100, 25)
        ;

  cp5.addTextfield("input")
    .setValue(7)
      .setPosition(0, 650)
        .setSize(BOUNDARYV1, BUTTON_W)
          .setColorCaptionLabel(0)
            .setBroadcast(false)
              .setVisible(false)
                ;

  text = cp5.addTextarea("notes")
    .setPosition(0, 350)
      .setSize(BOUNDARYV1, 280)
        .setText("Look here for instructions")
          .setColor(0)
            .setFont(createFont("arial", 12))
              .setVisible(false)
                ;

  cp5.addTextarea("top")
    .setPosition(412, 330)
      .setSize(BOUNDARYV1, BUTTON_W)
        .setText("TOP")
          .setVisible(false)
            ;
  cp5.addTextarea("front")
    .setPosition(412, 360)
      .setSize(BOUNDARYV1, BUTTON_W)
        .setText("FRONT")
          .setVisible(false)
            ;
  cp5.addTextarea("right")
    .setPosition(455, 360)
      .setSize(BOUNDARYV1, BUTTON_W)
        .setText("RIGHT")
          .setVisible(false)
            ;

  //creationsR.add(new Rectangle(100, 565, 66, 77, 2));
  //updateDMenu();
}

void updateDMenu() {
  if (!setup) {
    DRect.remove();
    DLine.remove();
    DCirc.remove();
  }
  DRect = del.add("D_Rectangle", 21);
  DRect.setPosition(BOUNDARYV1, 5 + 2*BUTTON_W);
  for (int i=0; i<creationsR.size (); i++) {
    DRect.add("Rectangle_"+i, 210+i);
  }
  DLine = del.add("D_Line", 22);
  DLine.setPosition(BOUNDARYV1, 5 + 3*BUTTON_W);
  for (int i=0; i<creationsL.size (); i++) {
    DLine.add("Line_"+i, 220+i);
  }
  DCirc = del.add("D_Circle", 23);
  DCirc.setPosition(BOUNDARYV1, 5 + 4*BUTTON_W);
  for (int i=0; i<creationsC.size (); i++) {
    DCirc.add("Circle_"+i, 230+i);
  }
}

void updateMMenu() {
  if (!setup) {
    MRect.remove();
    MLine.remove();
    MCirc.remove();
  } 
  MRect = move.add("M_Rectangle", 31);
  MRect.setPosition(BOUNDARYV1*2, 5 + 2*BUTTON_W);
  for (int i=0; i<creationsR.size (); i++) {
    MRect.add("MRectangle_"+i, 310+i);
  }
  MLine = move.add("M_Line", 32);
  MRect.setPosition(BOUNDARYV1*2, 5 + 3*BUTTON_W);
  for (int i=0; i<creationsL.size (); i++) {
    MLine.add("MLine_"+i, 320+i);
  }
  MCirc = move.add("M_Circle", 33);
  MRect.setPosition(BOUNDARYV1*2, 5 + 4*BUTTON_W);
  for (int i=0; i<creationsC.size (); i++) {
    MCirc.add("MCircle_"+i, 330+i);
  }
}

void draw() {
  if (MENU_SCREEN) {
    //title screen
    background(0);
    image(avo, 500, 240, 100, 70);
    textSize(65);
    text("avoCADo", 200, 300);
    textSize(15);
    text("by CADtherine and MiCADla", 300, 330);
  } else {
    //background stuff
    show();
    background(0);
    fill(200);
    noStroke();
    rect(0, 0, BOUNDARYV1, ENDY);
    stroke(200);
    line(BOUNDARYV2, 0, BOUNDARYV2, ENDY);
    line(BOUNDARYV1, BOUNDARYH, ENDX, BOUNDARYH);

    //draw all the shapes
    for (int i=0; i<creationsR.size (); i++) {
      if (cp5.controller("Rectangle_"+i).isActive() || cp5.controller("MRectangle_"+i).isActive()) {//.controller("D_Rectangle").controller("Rectangle"+i).isActive()){
        stroke(255);
      } else {
        stroke(0, 255, 0);
      }
      noFill();
      creationsR.get(i).draw();
    }
    for (int i=0; i<creationsC.size (); i++) {
      if (cp5.controller("Circle_"+i).isActive() || cp5.controller("MCircle_"+i).isActive()) {//.controller("D_Rectangle").controller("Rectangle"+i).isActive()){
        stroke(255);
      } else {
        stroke(0, 255, 0);
      }
      noFill();
      creationsC.get(i).draw();
    }
    for (int i=0; i<creationsL.size (); i++) {
      if (cp5.controller("Line_"+i).isActive() || cp5.getController("MLine_"+i).isActive()) {//.controller("D_Rectangle").controller("Rectangle"+i).isActive()){
        stroke(255);
      } else {
        stroke(0, 255, 0);
      }
      noFill();
      creationsL.get(i).draw();
    }
    //check the mode
    if (CRT_RECT == 2 || CRT_RECT == 3 || CRT_CIRC == 2 || CRT_FILE == 1 || (MV_SHAPE > 0 && MV_SHAPE < 5)) {
      cp5.getController("input").setBroadcast(true);
    } else {
      cp5.getController("input").setBroadcast(false);
    }
    if (CRT_RECT == 2 || CRT_RECT == 3) {
      createRect(tempX, tempY);
    }
    if (CRT_LINE == 2 || CRT_LINE == 3) {
      createLine(tempX, tempY);
    }
    if (CRT_CIRC == 2) {
      createCirc(tempX, tempY);
    }
    if (CRT_FILE == 1 || CRT_FILE == 2) {
      saveAs();
    }
    if (MV_SHAPE > 0 && MV_SHAPE < 5) {
      moveShape();
    }
  }
}

void show() {
  cp5.getController("Create").setVisible(true);
  cp5.getController("Delete").setVisible(true);
  cp5.getController("Edit").setVisible(true);
  cp5.getController("XForm").setVisible(true);
  cp5.getController("Save As").setVisible(true);
  cp5.getController("3D View").setVisible(true);
  cp5.getController("input").setVisible(true);
  cp5.getGroup("notes").setVisible(true);
  cp5.getGroup("top").setVisible(true);
  cp5.getGroup("front").setVisible(true);
  cp5.getGroup("right").setVisible(true);
  cp5.remove("             New Part");
  open.remove();
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isAssignableFrom(ListBox.class)) {
    int ind = (int)theEvent.getValue();
    String feil = files[ind];
    String[] data = loadStrings(feil+".txt");
    for (int i=0; i<data.length; i++) {
      int[] nums = int(split(data[i], ','));
      if (nums[nums.length-1] == 0) {
        creationsR.add(new Rectangle(nums[0], nums[1], nums[2], nums[3], nums[4]));
      } else if (nums[nums.length-1] == 1) {
        creationsL.add(new Line(nums[0], nums[1], nums[2], nums[3], nums[4]));
      } else if (nums[nums.length-1] == 2) {
        creationsC.add(new Circle(nums[0], nums[1], nums[2], nums[3]));
      }
    }
    updateDMenu();
    updateMMenu();
    MENU_SCREEN = false;
  } else if (theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
      +theEvent.getName()+"': "
      +theEvent.getStringValue()
      );
  }
  if (theEvent.isAssignableFrom(Button.class)) {
    String ControllerName = theEvent.getController().getName();
    if (ControllerName.equals("3D View")) {
      println("the 3D button was pressed");
    } else if (ControllerName.equals("Save As")) {
      println("the Save button was pressed");
      CRT_FILE = 1;
    } else if (ControllerName.equals("             New Part")) {
      MENU_SCREEN = false;
    }
  }
  if (theEvent.isAssignableFrom(MultiListButton.class)) {
    String ControllerName = theEvent.getController().getName();
    float val = theEvent.getController().getValue();
    if (ControllerName.equals("Rectangle")) {
      CRT_RECT = 1;
      println("the Rect option was selected");
      text.setText("Create new Rectangle:\n\nClick in either the top, front or right view box to indicate the position of the shape.");
      getPosition();
    } else if (ControllerName.equals("Line")) {
      CRT_LINE = 1;
      println("the Line option was selected");
      text.setText("Create new Line:\n\nClick in either the top, front or right view box to indicate the position of the shape");
      getPosition();
    } else if (ControllerName.equals("Circle")) {
      CRT_CIRC = 1;
      println("the Circle option was selected");
      text.setText("Create new Circle:\n\nClick in either the top, front or right view box to indicate the center of the shape");
      getPosition();
    } else if (ControllerName.equals("Clear all")) {
      creationsR.clear();
      creationsC.clear();
      creationsL.clear();
      text.setText("Cleared all.");
    } else if (ControllerName.length() > 9 && ControllerName.substring(0, 9).equals("Rectangle")) {
      println("delete a rectangle");
      //println(theEvent.getController().getValue());
      int i = ((int) val % 210);
      creationsR.remove(i);
      text.setText("Rectangle deleted.");
      //theEvent.getController().remove();
      updateDMenu();
      updateMMenu();
    } else if (ControllerName.length() > 6 && ControllerName.substring(0, 6).equals("Circle")) {
      println("delete a circle");
      int i = ((int) val % 230);
      println(i);
      creationsC.remove(i);
      text.setText("Circle deleted.");
      //theEvent.getController().remove();
      updateDMenu();
      updateMMenu();
    } else if (ControllerName.length() > 4 && ControllerName.substring(0, 4).equals("Line")) {
      println("delete a line");
      int i = ((int) val % 220);
      creationsL.remove(i);
      text.setText("Line deleted.");
      //theEvent.getController().remove();
      updateDMenu();
      updateMMenu();
    } else if (ControllerName.length() > 10 && ControllerName.substring(0, 10).equals("MRectangle")) {
      println("move a rect");
      temp2 = ((int) val % 310);
      tempM = 0;
      MV_SHAPE = 1;
      //MV_RECT = 1;
    } else if (ControllerName.length() > 7 && ControllerName.substring(0, 7).equals("MCircle")) {
      println("move a circle");
      temp2 = ((int) val % 330);
      tempM = 1;
      MV_SHAPE = 1;
      //MV_CIRC = 1;
    } else if (ControllerName.length() > 5 && ControllerName.substring(0, 5).equals("MLine")) {
      println("move a line");
      temp2 = ((int) val % 320);
      tempM = 2;
      MV_SHAPE = 1;
      //MV_LINE =  1;
    }
  }
}

void saveAs() {
  if (CRT_FILE == 1) {
    text.setText("Save File:\nEnter a file name");
    if (!fileName.equals("")) {
      println(fileName+"l");
      CRT_FILE = 2;
    }
  } else if (CRT_FILE == 2) {
    int size = creationsR.size() + creationsC.size() + creationsL.size();
    String[] data = new String[size];
    for (int i=0; i<creationsR.size (); i++) {
      String[] datz = new String[6];
      if (creationsR.get(i).getM()==0) {
        datz[0] = creationsR.get(i).getX() + "";
        datz[1] = creationsR.get(i).getY() + "";
      } else if (creationsR.get(i).getM()==1) {
        datz[0] = creationsR.get(i).getX() + "";
        datz[1] = creationsR.get(i).getZ() + "";
      } else if (creationsR.get(i).getM()==2) {
        datz[0] = creationsR.get(i).getY() + "";
        datz[1] = creationsR.get(i).getZ() + "";
      }
      datz[2] = creationsR.get(i).getW() + "";
      datz[3] = creationsR.get(i).getL() + "";
      datz[4] = creationsR.get(i).getM() + "";
      datz[5] = "0";
      data[i] = join(datz, ",");
    }
    for (int i=0; i<creationsL.size (); i++) {
      String[] datz = new String[6];
      if (creationsL.get(i).getM()==0) {
        datz[0] = creationsL.get(i).getX() + "";
        datz[1] = creationsL.get(i).getY() + "";
        datz[2] = creationsL.get(i).getX2() + "";
        datz[3] = creationsL.get(i).getY2() + "";
      } else if (creationsL.get(i).getM()==1) {
        datz[0] = creationsL.get(i).getX() + "";
        datz[1] = ENDY-creationsL.get(i).getZ() + "";
        datz[2] = creationsL.get(i).getX2() + "";
        datz[3] = ENDY-creationsL.get(i).getZ2() + "";
      } else if (creationsL.get(i).getM()==2) {
        datz[0] = ENDX-creationsL.get(i).getY() + "";
        datz[1] = ENDY-creationsL.get(i).getZ() + "";
        datz[2] = ENDX-creationsL.get(i).getY2() + "";
        datz[3] = ENDY-creationsL.get(i).getZ2() + "";
      }
      datz[4] = creationsL.get(i).getM() + "";
      datz[5] = "1";
      data[i+creationsR.size()] = join(datz, ",");
    }
    for (int i=0; i<creationsC.size (); i++) {
      String[] datz = new String[5];
      if (creationsC.get(i).getM()==0) {
        datz[0] = creationsC.get(i).getX() + "";
        datz[1] = creationsC.get(i).getY() + "";
      } else if (creationsC.get(i).getM()==1) {
        datz[0] = creationsC.get(i).getX() + "";
        datz[1] = ENDY-creationsC.get(i).getZ() + "";
      } else if (creationsC.get(i).getM()==2) {
        datz[0] = ENDX-creationsC.get(i).getY() + "";
        datz[1] = ENDY-creationsC.get(i).getZ() + "";
      }
      datz[2] = creationsC.get(i).getR() + "";
      datz[3] = creationsC.get(i).getM() + "";
      datz[4] = "2";
      data[i+creationsR.size()+creationsL.size()] = join(datz, ",");
    }
    saveStrings(fileName+".txt", data);
    text.setText(fileName+" created.");
    String[] names = loadStrings("config.txt");
    String[] name = new String[names.length+1];
    for (int i=0; i<names.length; i++) {
      name[i] = names[i];
    }
    name[names.length] = fileName;
    saveStrings("config.txt", name);
    CRT_FILE = 0;
    fileName = "";
  }
}

void createRect(int x1, int y1) {
  if (CRT_RECT == 2) {
    text.setText("Create new Rectangle:\n\nNow input a width.\n\n(If you enter a negative value, we'll take the absolute value.)");
    //println(width+" "+temp1);
    if (width == -1) {
      width = temp1;
    }
    if (width != -1) {
      //println(width+"ii");
      temp1 = -1;
      CRT_RECT = 3;
    }
    //println(width);
  } else if (CRT_RECT == 3) {
    //println(lengt);
    text.setText("Create new Rectangle:\n\nNow input a length.");
    length = temp1;
    //println(width+" "+length);
    //println(lengt);
    if (length != -1) {
      temp1 = -1;
      int mode = getMode(x1, y1);
      text.setText("New Rectangle created");
      creationsR.add(new Rectangle(x1, y1, width, length, mode));
      width = -1;
      length = -1;
      //numRect ++;
      String name = "Rectangle_"+(creationsR.size()-1);
      DRect.add(name, 210 + creationsR.size()-1);
      CRT_RECT = 0;
      updateDMenu();
      updateMMenu();
    }
  }
}

void createLine(int x1, int y1) {
  if (CRT_LINE == 2) {
    tempX2 = x1;
    tempY2 = y1;
    text.setText("Create New Line:\n\nNow choose another point within the same view box to form a line.");
    SELECT_MODE = true;
    FIRST_CLICK = false;
  } else if (CRT_LINE == 3) {
    text.setText("New Line Created");
    int mode = getMode(x1, y1);
    creationsL.add(new Line(tempX2, tempY2, x1, y1, mode));
    //numLine ++;
    String name = "Line_"+(creationsL.size()-1);
    DLine.add(name, 220+creationsL.size()-1);
    CRT_LINE = 0;
    updateDMenu();
    updateMMenu();
  }
}

void createCirc(int x1, int y1) {
  text.setText("Create new Circle:\n\nNow input a radius.");
  if (temp1 == -1) {
    radius = temp1;
  } else {
    radius = temp1;
    //println(radius);
    temp1 = -1;
    int mode = getMode(x1, y1);
    text.setText("New Circle created");
    creationsC.add(new Circle(tempX, tempY, radius, mode));
    radius = -1;
    tempX = -1;
    tempY = -1;
    //numCirc ++;
    String name = "Circle_"+(creationsC.size()-1);
    DCirc.add(name, 230+creationsC.size()-1);
    CRT_CIRC = 0;
    updateDMenu();
    updateMMenu();
  }
}

void moveShape() {
  if (MV_SHAPE == 1) {
    text.setText("Move a Shape:\n\nInput the change in x (+ or -)");
    if (gotIt) {
      tempX = temp1;
      MV_SHAPE ++;
      gotIt = false;
    }
  } else if (MV_SHAPE == 2) {
    text.setText("Move a Shape:\n\nInput the change in y (+ or -)");
    if (gotIt) {
      tempY = temp1;
      MV_SHAPE ++;
      gotIt = false;
    }
  } else if (MV_SHAPE == 3) {
    text.setText("Move a Shape:\n\nInput the change in z (+ or -)");
    if (gotIt) {
      tempZ = temp1;
      MV_SHAPE ++;
      gotIt = false;
    }
  } else if (MV_SHAPE == 4) {
    int i = temp2;
    if (tempM == 0) {
      Rectangle r = creationsR.get(i);
      creationsR.get(i).setX(r.getX() + tempX);
      creationsR.get(i).setY(r.getY() - tempY);
      creationsR.get(i).setZ(r.getZ() - tempZ);
    } else if (tempM == 1) {
      Circle c = creationsC.get(i);
      creationsC.get(i).setX(c.getX() + tempX);
      creationsC.get(i).setY(c.getY() - tempY);
      creationsC.get(i).setZ(c.getZ() - tempZ);
    } else {
      Line l = creationsL.get(i);
    }
    text.setText("Rectangle was moved");
    MV_SHAPE = 0;
    tempM = -1;
    temp1 = -1;
    temp2 = -1;
    tempX = -1;
    tempY = -1;
    tempZ = -1;
  }
}
void moveCirc() {
}
void moveLine() {
}

int getMode(int x, int y) {
  if (x > BOUNDARYV1 && x < BOUNDARYV2) {
    if (y < BOUNDARYH) {
      return 0; //top mode
    } else {
      return 1; //front mode
    }
  } else if (x > BOUNDARYV2 && y > BOUNDARYH) {
    return 2; //right mode
  } else {
    return -1;
  }
}

void getPosition() {
  SELECT_MODE = true;
  FIRST_CLICK = true;
}

void input(String theText) {
  // automatically receives results from controller input
  // println(theText);
  if (CRT_FILE == 1) {
    fileName = theText;
    if (fileName.equals("") || fileName.equals("config") || fileName.indexOf(".txt") != -1) {
      fileName = "NewPart";
    }
    println(fileName);
  } else {
    if (MV_SHAPE > 0 && MV_SHAPE < 5) {
      try {
        temp1 = Integer.parseInt(theText);
        gotIt = true;
      }
      catch(Exception e) {
        text.setText(text.getText() +  "\n\nTry again...");
      }
    } else {
      try {
        temp1 = abs(Integer.parseInt(theText));
        if (temp1 == 0) {
          temp1 = -1;
          text.setText(text.getText() + "\n\nTry again...");
        }
      }
      catch(Exception e) {
        text.setText(text.getText() + "\n\nTry again...");
      }
      println(temp1);
    }
  }
}

void mouseClicked() {
  if (SELECT_MODE) {
    if (!FIRST_CLICK) {
      if (getMode(mouseX, mouseY) != -1 && ((CRT_LINE == 2 && getMode(mouseX, mouseY) == getMode(tempX2, tempY2)) || CRT_LINE != 2)) {
        tempX = mouseX;
        tempY = mouseY;
        println("xcor: " + tempX + ", ycor: " + tempY);
        SELECT_MODE = false;
        if (CRT_RECT == 1) {
          CRT_RECT = 2;
        } else if (CRT_CIRC == 1) {
          CRT_CIRC = 2;
        } else if (CRT_LINE == 1 || CRT_LINE == 2) {
          CRT_LINE++;
        }
      } else {
        text.setText(text.getText() + "\n\nWrong view...");
      }
    } else {
      FIRST_CLICK = false;
    }
  }
}


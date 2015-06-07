import controlP5.*;

PImage avo;
ControlP5 cp5;
MultiList menu;
MultiListButton del, DRect, DCirc, DLine, XRect;
//int numRect, numCirc, numLine;
Textarea text;
String textValue = "";
String fileName = "NewPart";
ArrayList<Rectangle> creationsR = new ArrayList<Rectangle>(); 
ArrayList<Circle> creationsC = new ArrayList<Circle>();
ArrayList<Line> creationsL = new ArrayList<Line>();
final int BOUNDARYV1 = 100, BOUNDARYV2 = 450, BOUNDARYH = 350;
final int ENDX = 800, ENDY = 700;
final int BUTTON_W = 20;
boolean SELECT_MODE = false, FIRST_CLICK = true;
boolean MENU_SCREEN = true;
boolean setup = true;
int CRT_RECT = 0, CRT_LINE = 0, CRT_CIRC = 0, CRT_FILE = 0;
int temp1 = -1, tempX = -1, tempY = -1;
int tempX2 = -1, tempY2 = -1;
int width = -1, length = -1, radius = -1;

void setup() {
  size(ENDX, ENDY);
  frame.setTitle("avoCADo");

  cp5 = new ControlP5(this);
  cp5.setColorBackground(0);
  createMenu();

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
  b = menu.add("XForm", 3);
  b.add("Delta", 31).add("X_Rectangle", 311);
  b.setVisible(false);
  b = menu.add("Edit", 4);
  b.setVisible(false); 


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
    .setPosition(350, 350)
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

void draw() {
  if (MENU_SCREEN) {
    //title screen
    background(0);
    image(avo, 500, 240, 100, 70);
    textSize(65);
    text("avoCADo", 200, 300);
    //textSize(15);
    //text("by CADtherine and MiCADla",300,350);
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
      if (cp5.controller("Rectangle_"+i).isActive()) {//.controller("D_Rectangle").controller("Rectangle"+i).isActive()){
        stroke(255);
      } else {
        stroke(0, 255, 0);
      }
      noFill();
      creationsR.get(i).draw();
    }
    for (int i=0; i<creationsC.size (); i++) {
      if (cp5.controller("Circle_"+i).isActive()) {//.controller("D_Rectangle").controller("Rectangle"+i).isActive()){
        stroke(255);
      } else {
        stroke(0, 255, 0);
      }
      noFill();
      creationsC.get(i).draw();
    }
    for (int i=0; i<creationsL.size (); i++) {
      if (cp5.controller("Line_"+i).isActive()) {//.controller("D_Rectangle").controller("Rectangle"+i).isActive()){
        stroke(255);
      } else {
        stroke(0, 255, 0);
      }
      noFill();
      creationsL.get(i).draw();
    }
    //check the mode
    if (CRT_RECT == 2 || CRT_RECT == 3 || CRT_CIRC == 2 || CRT_FILE == 1) {
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
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isAssignableFrom(Textfield.class)) {
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
      cp5.remove("             New Part");
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
    } else if (ControllerName.length() > 6 && ControllerName.substring(0, 6).equals("Circle")) {
      println("delete a circle");
      int i = ((int) val % 230);
      println(i);
      creationsC.remove(i);
      text.setText("Circle deleted.");
      //theEvent.getController().remove();
      updateDMenu();
    } else if (ControllerName.length() > 4 && ControllerName.substring(0, 4).equals("Line")) {
      println("delete a line");
      int i = ((int) val % 220);
      creationsL.remove(i);
      text.setText("Line deleted.");
      //theEvent.getController().remove();
      updateDMenu();
    }
  }
}

void saveAs() {
  if (CRT_FILE == 1) {
    text.setText("Save File:\nEnter a file name");
    if (fileName != "") {
      println("o");
      CRT_FILE = 2;
    }
  } else if (CRT_FILE == 2) {
    int size = creationsR.size() + creationsC.size() + creationsL.size();
    String[] data = new String[size];
    for (int i=0; i<creationsR.size (); i++) {
      String[] datz = new String[6];
      datz[0] = creationsR.get(i).getX() + "";
      datz[1] = creationsR.get(i).getY() + "";
      datz[2] = creationsR.get(i).getW() + "";
      datz[3] = creationsR.get(i).getL() + "";
      datz[4] = creationsR.get(i).getM() + "";
      datz[5] = "0";
      data[i] = join(datz, ",");
    }
    for (int i=0; i<creationsL.size (); i++) {
      String[] datz = new String[6];
      datz[0] = creationsL.get(i).getX() + "";
      datz[1] = creationsL.get(i).getY() + "";
      datz[2] = creationsL.get(i).getX2() + "";
      datz[3] = creationsL.get(i).getY2() + "";
      datz[4] = creationsL.get(i).getM() + "";
      datz[5] = "1";
      data[i+creationsR.size()] = join(datz, ",");
    }
    for (int i=0; i<creationsC.size (); i++) {
      String[] datz = new String[5];
      datz[0] = creationsC.get(i).getX() + "";
      datz[1] = creationsC.get(i).getY() + "";
      datz[2] = creationsC.get(i).getR() + "";
      datz[3] = creationsC.get(i).getM() + "";
      datz[4] = "2";
      data[i+creationsR.size()+creationsL.size()] = join(datz, ",");
    }
    saveStrings(fileName+".txt", data);
    text.setText(fileName+" created.");
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
  }
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
    if (fileName == ""){
       fileName = "NewPart"; 
    }
    println(fileName);
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


import controlP5.*;
import javax.swing.*; 

//final vars
final int BOUNDARYV1 = 100, BOUNDARYV2 = 450, BOUNDARYH = 350;
final int ENDX = 800, ENDY = 700;
final int BUTTON_W = 20;

//cp5 stuff
ControlP5 cp5;
ListBox open;
MultiList menu;
MultiListButton del, xform, move, copy, Rect, Line, Circ;
Textarea text;

//3D window stuff
PFrame f;
SecondApplet s;

//shape storage
ArrayList<Rectangle> creationsR = new ArrayList<Rectangle>(); 
ArrayList<Circle> creationsC = new ArrayList<Circle>();
ArrayList<Line> creationsL = new ArrayList<Line>();

//state/mode info
boolean SELECT_MODE = false;
boolean MENU_SCREEN = true;
boolean setup = true;
boolean END_ENT = false;
boolean gotIt = false;
boolean DEL_SHAPE = false;
boolean MOV_SHAPE = false;
boolean COP_SHAPE = false;
int CRT_RECT = 0, CRT_LINE = 0, CRT_CIRC = 0, CRT_FILE = 0, MV_SHAPE = 0, CP_SHAPE = 0;

//placeholder vars
int temp1 = -1, temp2 = -1, tempX = -1, tempY = -1, tempZ = -1;
int tempX2 = -1, tempY2 = -1, tempZ2 = -1, tempM = -1, tempX3 = -1, tempY3 = -1;
int width = -1, length = -1, radius = -1;

//
PImage avo;
String fileName = "NewPart";
String feilNom = "";
String[] files;

/////////////////////////
//*********************//
//        SETUP        //////////////////////////////////////////////////////////////////////////////////////////////////
//*********************//
/////////////////////////

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

  strokeWeight(2);
}

void createMenu() {
  menu = cp5.addMultiList("Menu", 0, 5, BOUNDARYV1, BUTTON_W);
  menu.setVisible(false);
  MultiListButton b;
  // Create
  b = menu.add("Create", 1);
  b.add("Rectangle", 11);
  b.add("Line", 12);
  b.add("Circle", 13);
  b.setVisible(false);
  // Delete
  del = menu.add("Delete", 2);
  del.add("Clear all", 20);
  del.add("Select Shape", 21);
  del.setVisible(false);
  // XForm
  xform = menu.add("XForm", 3);
  move = xform.add("Move", 31);
  copy = xform.add("Copy", 32);
  xform.setVisible(false);
  updateMenu();

  // Display Files
  open = cp5.addListBox("\n            Open Part", 500, 425, 100, 200)
    .setBarHeight(25)
      .setOpen(false)
        ;

  files = loadStrings("config.txt");  
  for (int i=0; i<files.length; i++) {
    ListBoxItem lbi = open.addItem(files[i], i);
  }

  // Abort
  cp5.addButton("Abort", 4)
    .setBroadcast(false)
      .setPosition(0, 5 + 4*BUTTON_W)
        .setSize(BOUNDARYV1, BUTTON_W)
          .setVisible(false)
            .setBroadcast(true)
              ;

  // 3D
  cp5.addButton("3D View")
    .setBroadcast(false)
      .setValue(5)
        .setPosition(0, 125)
          .setSize(BOUNDARYV1, BUTTON_W)
            .setVisible(false)
              .setBroadcast(true)
                ;
  // Save
  cp5.addButton("Save As")
    .setBroadcast(false)
      .setValue(6)
        .setPosition(0, 165)
          .setSize(BOUNDARYV1, BUTTON_W)
            .setVisible(false)
              .setBroadcast(true)
                ;

  cp5.addButton("Save")
    .setBroadcast(false)
      .setValue(7)
        .setPosition(0, 186)
          .setSize(BOUNDARYV1, BUTTON_W)
            .setVisible(false)
              .setBroadcast(true)
                ;

  // MENU
  cp5.addButton("Menu Screen")
    .setBroadcast(false)
      .setValue(8)
        .setPosition(0, 308)
          .setSize(BOUNDARYV1, BUTTON_W)
            .setVisible(false)
              .setBroadcast(true)
                ;

  // New
  cp5.addButton("             New Part")
    .setPosition(200, 400)
      .setSize(100, 25)
        ;
  // user input field
  cp5.addTextfield("input")
    .setValue(7)
      .setPosition(0, 650)
        .setSize(BOUNDARYV1, BUTTON_W)
          .setColorCaptionLabel(0)
            .setBroadcast(false)
              .setVisible(false)
                ;
  // instructions textarea
  text = cp5.addTextarea("notes")
    .setPosition(0, 350)
      .setSize(BOUNDARYV1, 280)
        .setText("Look here for instructions")
          .setColor(0)
            .setFont(createFont("arial", 12))
              .setVisible(false)
                ;
  // other labels
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

void updateMenu() {
  if (!setup) {
    Rect.remove();
    Line.remove();
    Circ.remove();
  }
  // add creations to the menu
  Rect = menu.add("Rectangles", 4);
  Rect.setPosition(0, 226)
    .setVisible(false);
  for (int i=0; i<creationsR.size (); i++) {
    Rect.add("Rectangle_"+i, 40+i);
  }
  Line = menu.add("Lines", 5);
  Line.setPosition(0, 247)
    .setVisible(false);
  for (int i=0; i<creationsL.size (); i++) {
    Line.add("Line_"+i, 50+i);
  }
  Circ = menu.add("Circles", 6);
  Circ.setPosition(0, 268)
    .setVisible(false);
  for (int i=0; i<creationsC.size (); i++) {
    Circ.add("Circle_"+i, 60+i);
  }
}

/////////////////////////
//*********************//
//        DRAW         //////////////////////////////////////////////////////////////////////////////////////////////////
//*********************//
/////////////////////////

void draw() {
  /*if (mousePressed) {
   f = new PFrame();
   }*/
  if (MENU_SCREEN) {
    // title screen
    background(0);
    image(avo, 500, 240, 100, 70);
    textSize(65);
    fill(255);
    text("avoCADo", 200, 300);
    textSize(15);
    text("by CADtherine and MiCADla", 300, 330);
  } else {
    // background stuff
    show();
    frame.setTitle("avoCADo <"+fileName+">");
    background(0);
    fill(200);
    noStroke();
    rect(0, 0, BOUNDARYV1, ENDY);
    stroke(200);
    line(BOUNDARYV2, 0, BOUNDARYV2, ENDY);
    line(BOUNDARYV1, BOUNDARYH, ENDX, BOUNDARYH);

    // draw all the shapes
    // (highlight if user is hovering over its menu item)
    for (int i=0; i<creationsR.size (); i++) {
      try {
        if (cp5.isMouseOver(cp5.getController("Rectangle_"+i))) {
          creationsR.get(i).setA(true);
          stroke(255);
        } else {
          creationsR.get(i).setA(false);
          stroke(0, 255, 0);
        }
      } 
      catch (NullPointerException e) {
        stroke(0, 255, 0);
      }
      noFill();
      creationsR.get(i).draw();
    }
    for (int i=0; i<creationsC.size (); i++) {
      try {
        if (cp5.isMouseOver(cp5.getController("Circle_"+i))) {
          creationsC.get(i).setA(true);
          stroke(255);
        } else {
          creationsC.get(i).setA(false);
          stroke(0, 255, 0);
        }
      } 
      catch (NullPointerException e) {
        stroke(0, 255, 0);
      } 
      noFill();
      creationsC.get(i).draw();
    }
    for (int i=0; i<creationsL.size (); i++) {
      try {
        if (cp5.isMouseOver(cp5.getController("Line_"+i))) {
          creationsL.get(i).setA(true);
          stroke(255);
        } else {
          creationsL.get(i).setA(false);
          stroke(0, 255, 0);
        }
      } 
      catch (NullPointerException e) {
        stroke(0, 255, 0);
      }
      noFill();
      Line l = creationsL.get(i);
      println("k"+l.getX()+" "+l.getY()+" "+l.getZ());
      println(l.getX1()+" "+l.getY1()+" "+l.getZ());
      println(l.getX2()+" "+l.getY2()+" "+l.getZ2());
      println(l.getX2(1)+" "+l.getY2(1));
      creationsL.get(i).draw();
    }

    // check the mode
    if (CRT_RECT > 0 || CRT_LINE > 0 || CRT_CIRC > 0 || CRT_FILE == 1 || MV_SHAPE > 0) {
      cp5.getController("input").setBroadcast(true);
    } else {
      cp5.getController("input").setBroadcast(false);
    } 

    if (CRT_RECT == 3 || CRT_RECT == 4) {
      createRect(tempX, tempY);
    } else if (CRT_LINE == 3 || CRT_LINE == 6) {
      createLine(tempX, tempY);
    } else if (CRT_CIRC == 3) {
      createCirc(tempX, tempY);
    } else if (CRT_FILE == 1 || CRT_FILE == 2) {
      saveAs();
    } else if (CRT_FILE == 3) {
      sauve();
    } else if (MV_SHAPE > 0 && MV_SHAPE < 5) {
      moveShape();
    } else if (CP_SHAPE == 1) {
      copyShape();
    }
  }
}

void show() {
  cp5.getController("Create").setVisible(true);
  cp5.getController("Delete").setVisible(true);
  //cp5.getController("Edit").setVisible(true);
  cp5.getController("XForm").setVisible(true);
  cp5.getController("Rectangles").setVisible(true);
  cp5.getController("Circles").setVisible(true);
  cp5.getController("Lines").setVisible(true);
  cp5.getController("Save As").setVisible(true);
  cp5.getController("Save").setVisible(true);
  cp5.getController("3D View").setVisible(true);
  cp5.getController("Menu Screen").setVisible(true);
  cp5.getController("input").setVisible(true);
  cp5.getGroup("notes").setVisible(true);
  cp5.getGroup("top").setVisible(true);
  cp5.getGroup("front").setVisible(true);
  cp5.getGroup("right").setVisible(true);
  cp5.getController("             New Part").setVisible(false);
  open.setVisible(false);
}

void antiShow() {
  cp5.getController("Create").setVisible(!true);
  cp5.getController("Delete").setVisible(!true);
  //cp5.getController("Edit").setVisible(!true);
  cp5.getController("XForm").setVisible(!true);
  cp5.getController("Rectangles").setVisible(!true);
  cp5.getController("Circles").setVisible(!true);
  cp5.getController("Lines").setVisible(!true);
  cp5.getController("Save As").setVisible(!true);
  cp5.getController("Abort").setVisible(!true);
  cp5.getController("Save").setVisible(!true);
  cp5.getController("3D View").setVisible(!true);
  cp5.getController("Menu Screen").setVisible(!true);
  cp5.getController("input").setVisible(!true);
  cp5.getGroup("notes").setVisible(!true);
  cp5.getGroup("top").setVisible(!true);
  cp5.getGroup("front").setVisible(!true);
  cp5.getGroup("right").setVisible(!true);
  cp5.getController("             New Part").setVisible(!false);
  open.setVisible(!false);
}

/////////////////////////
//*********************//
//       EVENTS        //////////////////////////////////////////////////////////////////////////////////////////////////
//*********************//
/////////////////////////

void controlEvent(ControlEvent theEvent) {
  // LIST BOX
  if (theEvent.isAssignableFrom(ListBox.class)) {
    try {
      int ind = (int)theEvent.getValue();
      String feil = files[ind];
      String[] data = loadStrings(feil+".txt");
      // load creations data from file
      creationsR.clear();
      creationsL.clear();
      creationsC.clear();
      CRT_RECT = 0;
      CRT_LINE = 0;
      CRT_CIRC = 0;
      println("CRT_RECT, CRT_LINE, CRT_CIRC = 0");
      SELECT_MODE = false;
      END_ENT = false;
      gotIt = false;
      DEL_SHAPE = false;
      MOV_SHAPE = false;
      COP_SHAPE = false;
      CRT_FILE = 0;
      MV_SHAPE = 0;
      CP_SHAPE = 0;
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
      fileName = feil;
      text.setText(feil+" loaded.");
      updateMenu();
    } 
    catch (Exception e) {
      fileName = "NewPart";
      creationsR.clear();
      creationsC.clear();
      creationsL.clear();
      text.setText(text.getText()+"\n Could not load file. Does it exist?");
    }
    MENU_SCREEN = false;
  }
  // TEXT FIELD
  if (theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
      +theEvent.getName()+"': "
      +theEvent.getStringValue()
      );
  }
  // BUTTON
  if (theEvent.isAssignableFrom(Button.class)) {
    String ControllerName = theEvent.getController().getName();
    if (ControllerName.equals("3D View")) {
      if (f!=null && f.isDisplayable()) {
        f.dispose();
      } else {
        println("the 3D button was pressed");
        f = new PFrame();
        s = new SecondApplet();
        f.setTitle("3D View");
      }
    } else if (ControllerName.equals("Save As")) {
      println("the Save As button was pressed");
      CRT_FILE = 1;
    } else if (ControllerName.equals("Save")) {
      println("the Save button was pressed");
      CRT_FILE = 3;
    } else if (ControllerName.equals("Menu Screen")) {
      println("back");
      MENU_SCREEN = true;
      antiShow();
    } else if (ControllerName.equals("             New Part")) {
      MENU_SCREEN = false;
    } else if (ControllerName.equals("Abort")) {
      println("the Abort button was pressed");
      CRT_RECT = 0;
      CRT_LINE = 0;
      CRT_CIRC = 0;
      println("CRT_RECT, CRT_LINE, CRT_CIRC = 0");
      SELECT_MODE = false;
      END_ENT = false;
      gotIt = false;
      DEL_SHAPE = false;
      MOV_SHAPE = false;
      COP_SHAPE = false;
      CRT_FILE = 0;
      MV_SHAPE = 0;
      CP_SHAPE = 0;
      text.setText("Nevermind");
      cp5.getController("Abort").setVisible(false);
    }
  }
  // MULTI LIST BUTTON
  if (theEvent.isAssignableFrom(MultiListButton.class)) {
    String ControllerName = theEvent.getController().getName();
    float val = theEvent.getController().getValue();
    if (ControllerName.equals("Rectangle")) {
      CRT_RECT = 1;
      println("CRT_RECT = 1");
      tempM = 0;
      println("the Rect option was selected");
      text.setText("Create new Rectangle:\n\nEnter 0 for End Entity, 1 for cursor selection");
      cp5.getController("Abort").setVisible(true);
    } else if (ControllerName.equals("Line")) {
      CRT_LINE = 1;
      println("CRT_LINE = 1");
      tempM = 1;
      println("the Line option was selected");
      text.setText("Create new Line:\n\nEnter 0 for End Entity, 1 for cursor selection");
      cp5.getController("Abort").setVisible(true);
    } else if (ControllerName.equals("Circle")) {
      CRT_CIRC = 1;
      println("CRT_CIRC = 1");
      tempM = 2;
      println("the Circle option was selected");
      text.setText("Create new Circle:\n\nEnter 0 for End Entity, 1 for cursor selection");
      cp5.getController("Abort").setVisible(true);
    } else if (ControllerName.equals("Clear all")) {
      if (creationsR.size()>0 || creationsL.size()>0 || creationsC.size()>0) {
        creationsR.clear();
        creationsC.clear();
        creationsL.clear();
        text.setText("Cleared all.");
      } else {
        text.setText("No shapes to delete.");
      }
    } else if (ControllerName.equals("Select Shape")) {
      if (creationsR.size()>0 || creationsL.size()>0 || creationsC.size()>0) {
        text.setText("Delete shape:\n\nChoose which shape from either the Rectangles, Lines, or Circles menu.");
        cp5.getController("Abort").setVisible(true);
        DEL_SHAPE = true;
      } else {
        text.setText("No shapes to delete.");
      }
    } else if (ControllerName.equals("Move")) { 
      if (creationsR.size()>0 || creationsL.size()>0 || creationsC.size()>0) {
        text.setText("Move shape:\n\nChoose which shape from either the Rectangles, Lines, or Circles menu.");
        cp5.getController("Abort").setVisible(true);
        MOV_SHAPE = true;
      } else {
        text.setText("No shapes to move.");
      }
    } else if (ControllerName.equals("Copy")) { 
      if (creationsR.size()>0 || creationsL.size()>0 || creationsC.size()>0) {
        text.setText("Copy shape:\n\nChoose which shape from either the Rectangles, Lines, or Circles menu.");
        cp5.getController("Abort").setVisible(true);
        COP_SHAPE = true;
      } else {
        text.setText("No shapes to copy.");
      }
    } else if (ControllerName.length() > 9 && ControllerName.substring(0, 9).equals("Rectangle")) {
      if (creationsR.size()>0) {
        /*if (END_ENT) {
         int i = ((int) val % 40);
         endEnt(0, i);
         } else */        if (DEL_SHAPE) {
          println("delete a rectangle");
          println(val);
          //println(theEvent.getController().getValue());
          int i = ((int) val % 40);
          creationsR.remove(i);
          text.setText("Rectangle deleted.");
          updateMenu();
          DEL_SHAPE = false;
          cp5.getController("Abort").setVisible(false);
        } else if (MOV_SHAPE) {
          println("move a rect");
          temp2 = ((int) val % 40);
          tempM = 0;
          MV_SHAPE = 1;
          updateMenu();
          MOV_SHAPE = false;
        } else if (COP_SHAPE) {
          println("copy a rect");
          temp2 = ((int) val % 40);
          tempM = 0;
          CP_SHAPE = 1;
          updateMenu();
          COP_SHAPE = false;
        }
      }
    } else if (ControllerName.length() > 6 && ControllerName.substring(0, 6).equals("Circle")) {
      if (creationsC.size()>0) {
        /*if (END_ENT) {
         int i = ((int) val % 60);
         endEnt(2, i);
         } else*/        if (DEL_SHAPE) {
          println("delete a circle");
          int i = ((int) val % 60);
          println(i);
          creationsC.remove(i);
          text.setText("Circle deleted.");
          updateMenu();
          DEL_SHAPE = false;
          cp5.getController("Abort").setVisible(false);
        } else if (MOV_SHAPE) {
          println("move a circle");
          temp2 = ((int) val % 60);
          tempM = 1;
          MV_SHAPE = 1;
          updateMenu();
          MOV_SHAPE = false;
        } else if (COP_SHAPE) {
          println("copy a circle");
          temp2 = ((int) val % 60);
          tempM = 1;
          CP_SHAPE = 1;
          updateMenu();
          COP_SHAPE = false;
        }
      }
    } else if (ControllerName.length() > 4 && ControllerName.substring(0, 4).equals("Line")) {
      if (creationsL.size()>0) {
        if (END_ENT) {
          int i = ((int) val % 50);
          endEnt(1, i);
        } else if (DEL_SHAPE) {
          println("delete a line");
          int i = ((int) val % 50);
          creationsL.remove(i);
          text.setText("Line deleted.");
          updateMenu();
          DEL_SHAPE = false;
          cp5.getController("Abort").setVisible(false);
        } else if (MOV_SHAPE) {
          println("move a line");
          temp2 = ((int) val % 50);
          tempM = 2;
          MV_SHAPE = 1;
          updateMenu();
          MOV_SHAPE = false;
        } else if (COP_SHAPE) {
          println("copy a line");
          println(val);
          temp2 = ((int) val % 50);
          tempM = 2;
          CP_SHAPE = 1;
          updateMenu();
          COP_SHAPE = false;
        }
      }
    }
  }
}

/////////////////////////
//*********************//
//        SAVE         //////////////////////////////////////////////////////////////////////////////////////////////////
//*********************//
/////////////////////////

void saveAs() {
  if (CRT_FILE == 1) {
    text.setText("Save File:\nEnter a file name");
    if (!feilNom.equals("")) {
      println(feilNom+"l");
      fileName = feilNom;
      CRT_FILE = 2;
    }
  } else if (CRT_FILE == 2) {
    sauve();
  }
}

void sauve() {
  if (CRT_FILE == 2 || CRT_FILE == 3) {
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
        datz[2] = creationsL.get(i).getX2(1) + "";
        datz[3] = ENDY-creationsL.get(i).getZ2() + "";
      } else if (creationsL.get(i).getM()==2) {
        datz[0] = ENDX-creationsL.get(i).getY() + "";
        datz[1] = ENDY-creationsL.get(i).getZ() + "";
        datz[2] = ENDX-creationsL.get(i).getY2(1) + "";
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
    if (CRT_FILE == 2) {
      String[] names = loadStrings("config.txt");
      String[] name = new String[names.length+1];
      boolean contains = false;
      for (int i=0; i<names.length; i++) {
        name[i] = names[i];
        if (names[i].equals(fileName)) {
          contains = true;
        }
      }
      if (!contains) {
        name[names.length] = fileName;
        saveStrings("config.txt", name);
        text.setText(fileName+" created.");
      } else {
        text.setText(fileName+" overwritten.");
      }
    } else {
      text.setText(fileName+" saved.");
    }
    CRT_FILE = 0;
    feilNom = "";
  }
}

/////////////////////////
//*********************//
//       CREATE        //////////////////////////////////////////////////////////////////////////////////////////////////
//*********************//
/////////////////////////

void selection(int mode) {
  temp1 = -1;
  String shape;
  if (tempM == 0) {
    shape = "Rectangle";
    CRT_RECT = 2;
    println("CRT_RECT = 2");
  } else if (tempM == 1) {
    shape = "Line";
    if (CRT_LINE == 1) {
      CRT_LINE = 2;
      println("CRT_LINE = 2");
    } else if (CRT_LINE == 4) {
      CRT_LINE = 5;
      println("CRT_LINE = 5");
    }
  } else {
    shape = "Circle";
    CRT_CIRC = 2;
    println("CRT_CIRC = 2");
  }
  if (mode == 0) {
    text.setText("Create new " + shape + ":\n\nSelect a shape from either the Rectangles, Lines, or Circles menu");
    END_ENT = true;
  } else {
    text.setText("Create new " + shape + ":\n\nClick in either the top, front or right view box to indicate the position of the shape.");
    SELECT_MODE = true;
  }
}

void endEnt(int mode, int i) {
  // each of these has to set tempX and tempY
  END_ENT = true;
  //println("mode " + mode + " index " + i);
  if (mode == 0) {
    //rectangle i
    //text.setText(which coords? left or right)
  } else if (mode == 1) {
    //line i
    Line l = creationsL.get(i);
    if (l.getM()==0) {
      tempX = l.getX1();
      tempY = l.getY1();
      tempZ = l.getZ();
      tempX2 = l.getX2();
      tempY2 = l.getY2();
      tempZ2 = l.getZ2();
      text.setText("Which coordinates do you want?\n\nEnter 0 for \n(" + 
        tempX + ", " + (350-tempY) + ", " + tempZ + ") \nor 1 for \n(" + tempX2 + ", " + (350-tempY2) + ", " + tempZ2 + ")");
    } else if (l.getM()==1) {
      tempX = l.getX1();
      tempY = l.getY1();
      //tempZ = l.getY2(1);
      tempX2 = l.getX2(1);
      tempY2 = l.getY2();
      //tempZ2 = l.getY2(1);
      text.setText("Which coordinates do you want?\n\nEnter 0 for \n(" + 
        tempX + ", " + l.getY() + ", " + l.getZ() + ") \nor 1 for \n(" + l.getX2(1) + ", " + l.getY2(1) + ", " + l.getZ2() + ")");
    } else if (l.getM()==2) {
      tempX = l.getX1();
      tempY = l.getY1();
      //tempZ = l.getZ();
      tempX2 = l.getX2();
      tempY2 = l.getY2();
      //tempZ2 = l.getZ2();
      text.setText("Which coordinates do you want?\n\nEnter 0 for \n(" + 
        (l.getX()-100) + ", " + (ENDX-tempX) + ", " + (ENDY-tempY) + ") \nor 1 for \n(" + (l.getX()-100) + ", " + (ENDX-tempX2) + ", " + (ENDY-tempY2) + ")");
    }
  } else if (mode == 2) {
    //circle i
    //text.setText(which coords? left or right of center)
  }
}

void createRect(int x1, int y1) {

  if (CRT_RECT == 3) {
    text.setText("Create new Rectangle:\n\nNow input a width.\n\n(If you enter a negative value, we'll take the absolute value.)");
    if (width == -1) {
      width = temp1;
    }
    if (width != -1) {
      temp1 = -1;
      CRT_RECT = 4;
      println("CRT_RECT = 4");
    }
  } else if (CRT_RECT == 4) {
    text.setText("Create new Rectangle:\n\nNow input a length.");
    length = temp1;
    if (length != -1) {
      temp1 = -1;
      int mode = getMode(x1, y1);
      text.setText("New Rectangle created");
      creationsR.add(new Rectangle(x1, y1, width, length, mode));
      width = -1;
      length = -1;
      String name = "Rectangle_"+(creationsR.size()-1);
      CRT_RECT = 0;
      END_ENT = false;
      println("CRT_RECT = 0");
      cp5.getController("Abort").setVisible(false);
      updateMenu();
    }
  }
}

void createLine(int x1, int y1) {

  if (CRT_LINE == 3) {
    tempX3 = x1;
    tempY3 = y1;
    text.setText("Create New Line:\n\nNow choose another point within the same view box to form a line.\n\nEnter 0 for End Entity or 1 for cursor selection.");
    CRT_LINE = 4;
    println("CRT_LINE = 4");
  } else if (CRT_LINE == 6) {
    text.setText("New Line Created");
    int mode = getMode(x1, y1);
    creationsL.add(new Line(tempX3, tempY3, x1, y1, mode));
    String name = "Line_"+(creationsL.size()-1);
    CRT_LINE = 0;
    END_ENT = false;
    println("CRT_LINE = 0");
    cp5.getController("Abort").setVisible(false);
    updateMenu();
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
    String name = "Circle_"+(creationsC.size()-1);
    CRT_CIRC = 0;
    END_ENT = false;
    println("CRT_CIRC = 0");
    cp5.getController("Abort").setVisible(false);
    updateMenu();
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

/////////////////////////
//*********************//
//     MOVE/COPY       //////////////////////////////////////////////////////////////////////////////////////////////////
//*********************//
/////////////////////////

void moveShape() {

  if (MV_SHAPE == 1) {

    if (CP_SHAPE == 1) {
      text.setText("Copy a Shape:\n\nInput the change in x (+ or -)");
    } else {
      text.setText("Move a Shape:\n\nInput the change in x (+ or -)");
    }
    if (gotIt) {
      println("l");
      tempX = temp1;
      MV_SHAPE ++;
      println(MV_SHAPE);
      gotIt = false;
    }
  } else if (MV_SHAPE == 2) {

    if (CP_SHAPE == 1) {
      text.setText("Copy a Shape:\n\nNow input the change in y (+ or -)");
    } else {
      text.setText("Move a Shape:\n\nNow input the change in y (+ or -)");
    }
    if (gotIt) {
      tempY = temp1;
      MV_SHAPE ++;
      gotIt = false;
    }
  } else if (MV_SHAPE == 3) {

    if (CP_SHAPE == 1) {
      text.setText("Copy a Shape:\n\nNow input the change in z (+ or -)");
    } else {
      text.setText("Move a Shape:\n\nNow input the change in z (+ or -)");
    }
    if (gotIt) {
      tempZ = temp1;
      MV_SHAPE ++;
      gotIt = false;
    }
  } else if (MV_SHAPE == 4) {
    int i = temp2;
    if (tempM == 0) {
      Rectangle r = creationsR.get(i);
      r.setX(r.getX() + tempX);
      r.setY(r.getY() + tempY);
      r.setZ(r.getZ() - tempZ);
      if (CP_SHAPE == 1) {
        text.setText("Rectangle was copied");
      } else {
        text.setText("Rectangle was moved");
      }
    } else if (tempM == 1) {
      Circle c = creationsC.get(i);
      c.setX(c.getX() + tempX);
      c.setY(c.getY() - tempY);
      c.setZ(c.getZ() + tempZ);
      if (CP_SHAPE == 1) {
        text.setText("Circle was copied");
      } else {
        text.setText("Circle was moved");
      }
    } else {
      Line l = creationsL.get(i);
      l.setX(l.getX() + tempX);
      l.setY(l.getY() - tempY);
      l.setZ(l.getZ() + tempZ);
      l.setX2(l.getX2(1) + tempX);
      l.setY2(l.getY2(1) - tempY);
      l.setZ2(l.getZ2() + tempZ);
      if (CP_SHAPE == 1) {
        text.setText("Line was copied");
      } else {
        text.setText("Line was moved");
      }
    }
    MV_SHAPE = 0;
    CP_SHAPE = 0;
    tempM = -1;
    temp1 = -1;
    temp2 = -1;
    tempX = -1;
    tempY = -1;
    tempZ = -1;
    updateMenu();
    cp5.getController("Abort").setVisible(false);
  }
}

void copyShape() {
  if (CP_SHAPE == 1) {
    int i = temp2;
    if (tempM == 0) {
      Rectangle r = creationsR.get(i);
      Rectangle rect = new Rectangle();
      rect.setX(r.getX());
      rect.setY(r.getY());
      rect.setZ(r.getZ());
      rect.setW(r.getW());
      rect.setL(r.getL());
      rect.setM(r.getM());
      creationsR.add(rect);
    } else if (tempM == 1) {
      Circle c = creationsC.get(i);
      Circle circ = new Circle();
      circ.setX(c.getX());
      circ.setY(c.getY());
      circ.setZ(c.getZ());
      circ.setR(c.getR());
      circ.setD(c.getD());
      circ.setM(c.getM());
      creationsC.add(circ);
    } else {
      Line l = creationsL.get(i);
      Line line = new Line();
      line.setX(l.getX());
      line.setY(l.getY());
      line.setZ(l.getZ());
      line.setX2(l.getX2());
      line.setY2(l.getY2());
      line.setZ2(l.getZ2());
      line.setM(l.getM());
      creationsL.add(line);
    }
    MV_SHAPE = 1;
  }
}

/////////////////////////
//*********************//
//     USR INPUT       //////////////////////////////////////////////////////////////////////////////////////////////////
//*********************//
/////////////////////////

void input(String theText) {
  // automatically receives results from controller input

    // println(theText);
  if (CRT_FILE == 1) {
    feilNom = theText;
    if (feilNom.equals("") || feilNom.equals("config") ||
      feilNom.indexOf(".") != -1 || feilNom.indexOf("/") != -1) {
      feilNom = "NewPart";
    }
    println(fileName);
  } else {

    if (MV_SHAPE > 0) {
      try {
        temp1 = Integer.parseInt(theText);
        int i = temp2;
        if (tempM == 0) {
          Rectangle r = creationsR.get(i);
          //if (outOfBoundsMR(MV_SHAPE, r, temp1)) {
            //println("Out of Bounds!");
            //tryAgain();
          //} else {
            gotIt = true;
         // }
        } else if (tempM == 2) {
          Line l = creationsL.get(i);
          //if (outOfBoundsML(MV_SHAPE, l, temp1)) {
            //println("Out of Bounds!");
            //tryAgain();
          //} else {
            gotIt = true;
          //}
        } else {
          Circle c = creationsC.get(i);
          //if (outOfBoundsMC(MV_SHAPE, c, temp1)) {
           // println("Out of Bounds!");
            //tryAgain();
          //} else {
            gotIt = true;
          //}
        }
      }
      catch(Exception e) {
        tryAgain();
      }
    } else if (CRT_RECT == 1 || CRT_LINE == 1 || CRT_LINE == 4 || CRT_CIRC == 1) {
      //end ent or cursor
      try {
        temp1 = Integer.parseInt(theText);
        println(temp1);
        if (temp1 != 0 && temp1 != 1) {
          tryAgain();
        } else {
          selection(temp1);
        }
      }
      catch(Exception e) {
        tryAgain();
      }
    } else if (END_ENT && CRT_RECT == 2 || CRT_LINE == 2 || CRT_LINE == 5 || CRT_CIRC == 2) {
      try {
        int m = Integer.parseInt(theText);
        if (m == 0) {
          if (tempM == 0) {
            CRT_RECT = 3;
            println("CRT_RECT = 3");
          } else if (tempM == 1) {
            if (CRT_LINE == 2) {
              CRT_LINE = 3;
              println("CRT_LINE = 3");
            } else if (CRT_LINE == 5) {
              CRT_LINE = 6;
              println("CRT_LINE = 6");
            }
          } else {
            CRT_CIRC = 3;
            println("CRT_CIRC = 3");
          }
          //END_ENT = false;
        } else if (m == 1) {
          tempX = tempX2;
          tempY = tempY2;
          if (tempM == 0) {
            CRT_RECT = 3;
            println("CRT_RECT = 3");
          } else if (tempM == 1) {
            if (CRT_LINE == 2) {
              CRT_LINE = 3;
              println("CRT_LINE = 3");
            } else if (CRT_LINE == 5) {
              CRT_LINE = 6;
              println("CRT_LINE = 6");
            }
          } else {
            CRT_CIRC = 3;
            println("CRT_CIRC = 3");
          }
          //END_ENT = false;
        } else {
          tryAgain();
        }
      } 
      catch(Exception e) {
        tryAgain();
      }
    } else if (CRT_RECT > 2 || CRT_CIRC > 2) {
      //width, length, or radius
      try {
        temp1 = abs(Integer.parseInt(theText));
        if (temp1 == 0) {
          tryAgain();
        } else if (CRT_RECT > 2 && outOfBounds(0, tempX, tempY, temp1)) {
          println("Out of Bounds!");
          tryAgain();
        } else if (CRT_CIRC > 2 && outOfBounds(1, tempX, tempY, temp1)) {
          println("Out of Bounds!");
          tryAgain();
        }
      }
      catch(Exception e) {
        tryAgain();
      }
      println(temp1);
    }
  }
}

boolean outOfBounds(int m, int x, int y, int t) {
  if (m == 0) { //rectangle width or height
    if (CRT_RECT == 3) { //checking width
      if (getMode(x, y) == 0 || getMode(x, y) == 1) { //top view or front view
        return x + t >= BOUNDARYV2;
      } else { //right view
        return x + t >= ENDX;
      }
    } else if (CRT_RECT == 4) { //checking length
      if (getMode(x, y) == 1 || getMode(x, y) == 2 ) { //front view or right view
        return y + t >= ENDY;
      } else { //top view
        return y + t >= BOUNDARYH;
      }
    }
  } else if (m == 1) { //circle radius
    if (getMode(x, y) == 0) { //top view
      return x + t >= BOUNDARYV2 || x - t <= BOUNDARYV1 || y + t >= BOUNDARYH || y - t <= 0;
    } else if (getMode(x, y) == 1) { //front view
      return x + t >= BOUNDARYV2 || x - t <= BOUNDARYV1 || y + t >= ENDY || y - t <= BOUNDARYH;
    } else { //right view
      return x + t >= ENDX || x - t <= BOUNDARYV2 || y + t >= ENDY || y - t <= BOUNDARYH;
    }
  }
  return false;
}

/*boolean outOfBoundsMR(int m, Rectangle r, int t) {
  int mode = r.getM();
  int w = r.getW();
  int l = r.getL();
  if (m == 1) { //check x
    return r.getX() + w + t >= BOUNDARYV2 || r.getX() + t <= BOUNDARYV1;
  } else if (m == 2) { //check y
    if (mode == 0 || mode == 1) { //top or front view
      return r.getY() + l + t >= BOUNDARYH || r.getY() - t <= 0;
    } else { //right view
      return r.getY() + w + t >= ENDX || r.getY() - t <= BOUNDARYV2;
    }
  } else if (m == 3) { //check z
    if (mode == 1 || mode == 2) { //front or right view
      return r.getZ() + l - t >= ENDY || r.getZ() - t <= BOUNDARYH;
    } else { //top view
      return (ENDY-r.getZ()) + l - t >= ENDY || (ENDY-r.getZ()) - t <= BOUNDARYH;
    }
  }
  return false;
}
boolean outOfBoundsML(int m, Line l, int t) {
  int mode = l.getM();
  if (m == 1) { //check x
    if (mode == 0 || mode == 1) { //top or front view
      return l.getX1() + t >= BOUNDARYV2 || l.getX1() + t <= BOUNDARYV1 || l.getX2() + t >= BOUNDARYV2 || l.getX2() + t <= BOUNDARYV1;
    } else { //right view
      return l.getX1() + t >= ENDX || l.getX1() + t <= BOUNDARYV2 || l.getX2() + t >= ENDX || l.getX2() + t <= BOUNDARYV1;
    }
  } else if (m == 2) { //check y
    if (mode == 1 || mode == 2) { //front or right view
      return l.getY1() + t >= ENDY || l.getY1() + t <= BOUNDARYH || l.getY2() + t >= ENDY || l.getY2() + t <= BOUNDARYH;
    } else { //top view
      return l.getY1() + t >= BOUNDARYH || l.getY1() + t <= 0 || l.getY2() + t >= BOUNDARYH || l.getY2() + t <= 0;
    }
  } else if (m == 3) { //check z
    if (mode == 1 || mode == 2) { //front or right view
      return (ENDY-l.getZ()) + t >= ENDY || (ENDY-l.getZ()) + t <= BOUNDARYH || (ENDY - l.getZ2()) + t >= ENDY || (ENDY - l.getZ2()) + t  <= BOUNDARYH;
    } else {
      return (ENDY-l.getZ()) + t >= ENDY || (ENDY-l.getZ()) + t <= BOUNDARYH;
    }
  }
  return false;
}
boolean outOfBoundsMC(int m, Circle c, int t) {
  int mode = c.getM();
  int r = c.getR();
  if (m == 1) { //check x
    return c.getX() + r + t >= BOUNDARYV2 || c.getX() + t <= 0;
  } else if (m == 2) { //check y
    if (mode == 0 || mode == 1) { //top or front view
      return c.getY() - r - t <= 0 || c.getY() + r + t >= BOUNDARYH;
    } else { //right view
      return (ENDX-c.getY()) - r - t <=BOUNDARYV2 || (ENDX-c.getY()) + r + t >= ENDX;
    }
  } else if (m == 3) { //check z
    return c.getZ() + r + t >= BOUNDARYH || c.getZ() + t <= 0;
  }
  return false;
}*/

void tryAgain() {
  temp1 = -1;
  text.setText(text.getText() + "\n\nTry again...");
}

void mouseClicked() {
  if (SELECT_MODE) {
    if (getMode(mouseX, mouseY) != -1 && ((CRT_LINE == 5 && getMode(mouseX, mouseY) == getMode(tempX3, tempY3)) || CRT_LINE != 5)) {
      tempX = mouseX;
      tempY = mouseY;
      println("xcor: " + tempX + ", ycor: " + tempY);
      SELECT_MODE = false;
      if (CRT_RECT == 2) {
        CRT_RECT = 3;
        println("CRT_RECT = 3");
      } else if (CRT_CIRC == 2) {
        CRT_CIRC = 3;
        println("CRT_CIRC = 3");
      } else if (CRT_LINE == 2) {
        CRT_LINE  = 3;
        println("CRT_LINE = 3");
      } else if (CRT_LINE == 5) {
        CRT_LINE = 6;
        println("CRT_LINE = 6");
      }
    } else {
      text.setText(text.getText() + "\n\nWrong view...");
    }
  }
}

public class PFrame extends JFrame {
  public PFrame() {
    setBounds(50, 50, 700, 850);
    setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
    s = new SecondApplet();
    add(s);
    s.init();
    show();
  }
}

public class SecondApplet extends PApplet {

  void setup() {
    size(700, 850, OPENGL);
    noFill(); 
    strokeWeight(2);
    stroke(0, 255, 0);
  }

  void draw() {
    println(height+" "+width);
    background(0);
    rot(width/2, 0);
    for (int i=0; i<creationsL.size (); i++) {
      Line l = creationsL.get(i);
      //scale(0.75);
      if (l.getA()) {
        stroke(255);
      } else {
        stroke(0, 255, 0);
      }
      if (l.getM()==0) {
        line(l.getX(), l.getY(), l.getZ()-360, l.getX2(), l.getY2(), l.getZ()-360);
      } else if (l.getM()==1) {
        line(l.getX(), l.getZ(), l.getY()-360, l.getX2(), l.getZ(), l.getY2()-360);
      } else if (l.getM()==2) {
        line(l.getY(), l.getZ(), l.getX()-360, l.getY2(), l.getZ(), l.getX2()-360);
      }
    }
    //test();
  }
  void rot(float x, float y) {
    translate(x, y);
    rotateX(radians(54));
    rotateZ(radians(45));
    ortho();
  }
  void drawBox(float x, float y, float z, int size) {
    pushMatrix();
    translate(x, y, z);
    box(size);
    popMatrix();
  }
  void test() {
    //line(0,0,0,350,350,0);
    //line(50,50,50,150,150,50);
    stroke(0, 0, 255);
    //drawBox(width/2, height/2, 0.0, 100);
    stroke(0, 255, 0);
    //drawBox(width/2, height/2, 50.0, 100);
    stroke(255, 0, 0);
    //drawBox(0, 100, 0, 100);
    stroke(205, 0, 0);
    //drawBox(100, 0, 0, 100);
    stroke(255, 250, 0);
    //drawBox(0, 0, 200, 100);
    //drawBox(0, 0, -550, 100);
    drawBox(0, 0, 600, 100);
    stroke(0, 250, 0);
    //drawBox(0, 0, 0, 100);
    //drawBox(-100, -100, -350.0, 100);
    stroke(155, 0, 0);
    //drawBox(0, 0, -350.0, 100);
    stroke(105, 0, 0);
    //drawBox(100, -100, -350.0, 100);
    stroke(55, 0, 0);
    //drawBox(200, -100, -350.0, 100);
  }
}


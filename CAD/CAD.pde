import controlP5.*;

ControlP5 cp5;
MultiList menu;
Textarea text;
String textValue = "";
ArrayList<Shape> creations = new ArrayList<Shape>();
final int BOUNDARYV1 = 100, BOUNDARYV2 = 500, BOUNDARYH = 300;
final int ENDX = 900, ENDY = 600;
final int BUTTON_W = 20;
boolean SELECT_MODE = false, FIRST_CLICK = true;
boolean CRT_RECT = false, CRT_LINE = false, CRT_CIRCLE = false;
int tempX, tempY;

void setup() {
  size(ENDX, ENDY);
  frame.setTitle("avoCADo");

  cp5 = new ControlP5(this);
  createMenu();

  creations.add(new Rectangle(5, 5, 75, 120, 250, 75, 0));
  //creations.add(new Rectangle(185,15,5,130,15,250,1));
  //creations.add(new Rectangle(5,30,5,5,250,120,2));
  //creations.add(new Circle(100,100,50,44,0));
}

void createMenu() {
  menu = cp5.addMultiList("Menu", 0, 5, BOUNDARYV1, BUTTON_W);
  MultiListButton b;
  b = menu.add("Create", 1);
  b.add("Rectangle", 11);
  b.add("Line", 12);
  b.add("Circle", 13);
  b = menu.add("Delete", 2);
  b = menu.add("XForm", 3);
  b = menu.add("Edit", 4);

  cp5.addButton("3D View")
    .setValue(5)
      .setPosition(0, 130)
        .setSize(BOUNDARYV1, BUTTON_W)
          ;
  cp5.addButton("Save As")
    .setValue(6)
      .setPosition(0, 180)
        .setSize(BOUNDARYV1, BUTTON_W)
          ;

  cp5.addTextfield("input")
    .setValue(7)
      .setPosition(0, 550)
        .setSize(BOUNDARYV1, BUTTON_W)
          .setColorCaptionLabel(0)
            ;

  text = cp5.addTextarea("notes")
    .setPosition(0, 300)
      .setSize(BOUNDARYV1, 230)
        .setText("Look here for instructions")
          .setColor(0)
            .setFont(createFont("arial", 12))
              ;

  cp5.addTextarea("top")
    .setPosition(450, 280)
      .setSize(BOUNDARYV1, BUTTON_W)
        .setText("TOP VIEW")
          ;
  cp5.addTextarea("front")
    .setPosition(438, 310)
      .setSize(BOUNDARYV1, BUTTON_W)
        .setText("FRONT VIEW")
          ;
  cp5.addTextarea("side")
    .setPosition(505, 310)
      .setSize(BOUNDARYV1, BUTTON_W)
        .setText("RIGHT VIEW")
          ;
}

void draw() {
  background(0);
  fill(200);
  noStroke();
  rect(0, 0, BOUNDARYV1, 600);
  stroke(200);
  line(BOUNDARYV2, 0, BOUNDARYV2, ENDY);
  line(BOUNDARYV1, BOUNDARYH, ENDX, BOUNDARYH);
  //text(cp5.get(Textfield.class,"input").getText(), 360,130);
  //text(textValue, 360,180);

  for (int i=0; i<creations.size (); i++) {
    stroke(0, 255, 0);
    noFill();
    creations.get(i).draw();
  }
}

void clear() {
  cp5.get(Textfield.class, "input").clear();
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
    }
  }
  if (theEvent.isAssignableFrom(MultiListButton.class)) {
    String ControllerName = theEvent.getController().getName();
    if (ControllerName.equals("Rectangle")) {
      println("the Rect option was selected");
      text.setText("Create new Rectangle:\n\n" + getPosition());
    } else if (ControllerName.equals("Line")) {
      println("the Line option was selected");
      text.setText("Create new Line:\n\n" + getPosition());
    } else if (ControllerName.equals("Circle")) {
      println("the Circle option was selected");
      text.setText("Create new Circle:\n\n" + getPosition());
    }
    //delete, xform, edit, save, 3d
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

String getPosition() {
  SELECT_MODE = true;
  FIRST_CLICK = true;
  return "Click in either the top, front or right view box to indicate the position of the shape";
}

void input(String theText) {
  println(theText);
  // automatically receives results from controller input
}

void mouseClicked() {
  if (SELECT_MODE) {
    if (!FIRST_CLICK) {
      tempX = mouseX;
      tempY = mouseY;
      println("xcor: " + tempX + ", ycor: " + tempY);
      println("mode: " + getMode(tempX, tempY));
      SELECT_MODE = false;
      text.setText("Success");
    } else {
      FIRST_CLICK = false;
    }
  }
}


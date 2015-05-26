import controlP5.*;

ControlP5 cp5;
MultiList menu;
String textValue = "";
ArrayList<Shape> creations = new ArrayList<Shape>();
final int BOUNDARYV1 = 100, BOUNDARYV2 = 500, BOUNDARYH = 300;
final int ENDX = 900, ENDY = 600;
final int BUTTON_W = 20;
boolean SELECT_MODE = false, FIRST_CLICK = true;

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

  cp5.addTextarea("notes")
    .setPosition(0, 300)
      .setSize(BOUNDARYV1, 230)
        .setText("Lorem ipsum dolor sit amet, consectetur adipiscing elit."
          +" Quisque sed velit nec eros scelerisque adipiscing vitae eu sem."
          +" Quisque malesuada interdum lectus. Pellentesque pellentesque molestie"
          +" vestibulum. Maecenas ultricies, neque at porttitor lacinia, tellus enim"
          +" suscipit tortor, ut dapibus orci lorem non ipsum. Mauris ut velit velit."
          +" Fusce at purus in augue semper tincidunt imperdiet sit amet eros."
          +" Vestibulum nunc diam, fringilla vitae tristique ut, viverra ut felis."
          +" Proin aliquet turpis ornare leo aliquam dapibus. Integer dui nisi, condimentum"
          +" ut sagittis non, fringilla vestibulum sapien. Sed ullamcorper libero et massa"
          +" congue in facilisis mauris lobortis. Fusce cursus risus sit amet leo imperdiet"
          +" lacinia faucibus turpis tempus. Pellentesque pellentesque augue sed purus varius"
          +" sed volutpat dui rhoncus. Lorem ipsum dolor sit amet, consectetur adipiscing elit")
          .setColor(0)
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
      SELECT_MODE = true;
      FIRST_CLICK = true;
    } else if (ControllerName.equals("Line")) {
      println("the Line option was selected");
    } else if (ControllerName.equals("Circle")) {
      println("the Circle option was selected");
    }
    //delete, xform, edit, save, 3d
  }
}

void input(String theText) {
  println(theText);
  // automatically receives results from controller input
  //println("a textfield event for controller 'input' : "+theText);
}

void mouseClicked() {
  if (SELECT_MODE) {
    if (FIRST_CLICK == false) {
      println("xcor: " + mouseX + ", ycor: " + mouseY);
      SELECT_MODE = false;
    } else {
      FIRST_CLICK = false;
    }
  }
}


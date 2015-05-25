import controlP5.*;

ControlP5 cp5;
String textValue = "";
ArrayList<Shape> creations = new ArrayList<Shape>();
final int BOUNDARYV1 = 100, BOUNDARYV2 = 500, BOUNDARYH = 300;
final int ENDX = 900, ENDY = 600;
final int BUTTON_W = 20;

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
  cp5.addButton("Create")
      .setValue(0)
      .setPosition(0, 5)
      .setSize(BOUNDARYV1, BUTTON_W)
      ;  
  cp5.addButton("Delete")
      .setValue(1)
      .setPosition(0, 30)
      .setSize(BOUNDARYV1, BUTTON_W)
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

public void clear() {
  cp5.get(Textfield.class, "input").clear();
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
      +theEvent.getName()+"': "
      +theEvent.getStringValue()
      );
  }
  String ControllerName = theEvent.getController().getName();
  if (ControllerName.equals("Create")){
     println("the Create button was pressed"); 
  }
  if (ControllerName.equals("Delete")){
     println("the Delete button was pressed");
  }
}


public void input(String theText) {
  println(theText);
  // automatically receives results from controller input
  //println("a textfield event for controller 'input' : "+theText);
}


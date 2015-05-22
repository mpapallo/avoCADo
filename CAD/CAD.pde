import controlP5.*;

ControlP5 cp5;
String textValue = "";
ArrayList<Shape> creations = new ArrayList<Shape>();
final int BOUNDARYV1 = 100, BOUNDARYV2 = 500, BOUNDARYH = 300;
final int ENDX = 900, ENDY = 600;

void setup() {
  size(ENDX,ENDY);
  frame.setTitle("avoCADo");
  
  cp5 = new ControlP5(this);   
  
  creations.add(new Rectangle(5,5,5,20,20,20,0));
  
}

void draw() {
  background(0);
  fill(200);
  rect(0,0,BOUNDARYV1,600);
  stroke(200);
  line(BOUNDARYV2,0,BOUNDARYV2,ENDY);
  line(BOUNDARYV1,BOUNDARYH,ENDX,BOUNDARYH);
  //text(cp5.get(Textfield.class,"input").getText(), 360,130);
  //text(textValue, 360,180);
  
  for (int i=0; i<creations.size(); i++){
     stroke(0,255,0);
     noFill();
     creations.get(i).draw(); 
  }
}

public void clear() {
  cp5.get(Textfield.class,"input").clear();
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
  }
}


public void input(String theText) {
  println(theText);
  // automatically receives results from controller input
  //println("a textfield event for controller 'input' : "+theText);
}



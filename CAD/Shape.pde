abstract class Shape {

  float x1, y1, z1, z2;
  int mode;
  final int TOP = 0, FRONT = 1, RIGHT = 2;
  final int BOUNDARYV1 = 100, BOUNDARYV2 = 500, BOUNDARYH = 300;

  Shape(float xx1, float yy1, float zz1, float zz2, int mod) {
    x1 = xx1;
    y1 = yy1;
    z1 = zz1;
    z2 = zz2;
    mode = mod;
  }

  abstract void draw();

  class Line extends Shape {
    float x2, y2;

    Line(float xx1, float yy1, float zz1, 
    float xx2, float yy2, float zz2, int mod) {
      super(xx1, yy1, zz1, zz2, mod);
      x2 = xx2;
      y2 = yy2;
    }
    
    void draw(){
      
    }
  }

  class Rectangle extends Shape {
    float x2, y2;

   Rectangle(float xx1, float yy1, float zz1, 
    float xx2, float yy2, float zz2, int mod) {
      super(xx1, yy1, zz1, zz2, mod);
      x2 = xx2;
      y2 = yy2;
    }
    
    void draw(){
      if (mode==TOP){
        rect(x1+BOUNDARYV1,y1,x2+BOUNDARYV1,y2);
        line(x1+BOUNDARYV1,ENDY-z1);
        line();
      } else if (mode==FRONT){
        
      } else if (mode==RIGHT){
        
      }
    }
  }

  class Circle extends Shape {
    float r;
    Circle(float xx1, float yy1, float zz1, float zz2, float rr, int mod) {
      super(xx1, yy1, zz1, zz2, mod);
      r = rr;
    }
    
    void draw(){
      
    }
  }
}


class Shape {
  
  float x1, y1, z1, z2;
  int mode;
  final int TOP = 0, FRONT = 1, RIGHT = 2;

  Shape(float xx1, float yy1, float zz1, float zz2, float mod) {
    x1 = xx1;
    y1 = yy1;
    z1 = zz1;
    z2 = zz2;
    mode = mod;
  }

  class Line implements Shape {
    float x2, y2;

    Line(float xx1, float yy1, float zz1, 
    float xx2, float yy2, float zz2, int mod) {
      super(xx1, yy1, zz1, zz2, mod);
      x2 = xx2;
      y2 = yy2;
    }
  }

  class Rectangle extends Line {
  }

  class Circle extends Shape {
  }

}


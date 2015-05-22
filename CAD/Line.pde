class Line extends Shape {
  float x2, y2, z2;

  Line(float xx1, float yy1, float zz1, 
  float xx2, float yy2, float zz2, int mod) {
    super(xx1, yy1, zz1, mod);
    x2 = xx2;
    y2 = yy2;
    z2 = zz2;
  }

  void draw() {
  }
}


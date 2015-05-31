class Line extends Shape {

  int x2, y2;
  
  /*
  Line(int xx1, int yy1, int zz1, 
   int xx2, int yy2, int zz2, int mod) {
   super(xx1, yy1, zz1, mod);
   x2 = xx2;
   y2 = yy2;
   z2 = zz2;
   }
   */

  Line(int xx1, int yy1, int xx2, int yy2, int mod) {
    setM(mod);
    if (mode == TOP) {
    } else if (mode == FRONT) {
    } else {
    }
  }

  void draw() {
  }
  
}


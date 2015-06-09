class Line extends Shape {

  int x2, y2, z2;

  Line(int xx1, int yy1, int xx2, int yy2, int mod) {
    setM(mod);
    if (mode == TOP) {
      x1 = xx1;
      y1 = yy1;
      x2 = xx2;
      y2 = yy2;
      z1 = 100;
    } else if (mode == FRONT) {
      x1 = xx1;
      z1 = ENDY-yy1;
      x2 = xx2;
      z2 = ENDY-yy2;
      y1 = 100;
    } else {
      y1 = ENDX-xx1;
      z1 = ENDY-yy1;
      y2 = ENDX-xx2;
      z2 = ENDY-yy2;
      x1 = BOUNDARYV1+100;
    }
  }
  
  int getX2() {
    return x2;
  }

  int getY2() {
    return y2;
  }

  int getZ2() {
    return z2;
  }

  void draw() {
    if (mode == TOP) {
      line(x1, y1, x2, y2);
      line(x1, ENDY-z1, x2, ENDY-z1);
      line(ENDX-y1, ENDY-z1, ENDX-y2, ENDY-z1);      
    } else if (mode == FRONT) {
      line(x1, y1, x2, y1);
      line(x1, ENDY-z1, x2, ENDY-z2);
      line(ENDX-y1, ENDY-z2, ENDX-y1, ENDY-z1);
    } else {
      line(x1, y2, x1, y1);
      line(x1, ENDY-z2, x1, ENDY-z1);
      line(ENDX-y1, ENDY-z1, ENDX-y2, ENDY-z2);
    }
  }
}


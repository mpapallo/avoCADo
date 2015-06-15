class Line extends Shape {

  int x2, y2, z2;

  Line() {
    setX(0);
    setY(0);
    setZ(0);
    setX2(0);
    setY2(0);
    setZ2(0);
    setM(-1);
  }

  Line(int xx1, int yy1, int xx2, int yy2, int mod) {
    setM(mod);
    if (mode == TOP) {
      x1 = xx1;
      y1 = yy1;
      x2 = xx2;
      y2 = yy2;
      z1 = 100;
      z2 = 100;
    } else if (mode == FRONT) {
      x1 = xx1;
      z1 = ENDY-yy1;
      x2 = xx2;
      z2 = ENDY-yy2;
      y1 = 100;
      y2 = 100;
    } else {
      y1 = ENDX-xx1;
      z1 = ENDY-yy1;
      y2 = ENDX-xx2;
      z2 = ENDY-yy2;
      x1 = BOUNDARYV1+100;
      x2 = BOUNDARYV1+100;
    }
  }

  int getX1() {
    if (mode == RIGHT) {
      return ENDX - y1;
    } else {
      return x1;
    }
  }

  int getY1() {
    if (mode == TOP) {
      return y1;
    } else {
      return ENDY - z1;
    }
  }

  int getX2() {
    if (mode == RIGHT) {
      return ENDX - y2;
    } else {
      return x2;
    }
  }
  int getX2(int n) {
    return x2;
  }

  int getY2() {
    if (mode == TOP) {
      return y2;
    } else {
      return ENDY - z2;
    }
  }
  int getY2(int n) {
    return y2;
  }

  int getZ2() {
    return z2;
  }

  void setX2(int x) {
    x2=x;
  }

  void setY2(int y) {
    y2=y;
  }

  void setZ2(int z) {
    z2=z;
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


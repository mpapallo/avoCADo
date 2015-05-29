class Circle extends Shape {

  int r;
  Circle(int xx1, int yy1, int rr, int mod) {
    x1 = xx1;
    y1 = yy1;
    mode = mod;
    r = rr;
  }

  void draw() {
    if (mode==TOP) {
      z1 = y1;
      ellipse(x1, y1, 2*r, 2*r);
      line(x1-r, ENDY-z1-r, x1+r, ENDY-z1-r);
      line(ENDX-y1-r, ENDY-z1-r, ENDX-y1+r, ENDY-z1-r);
    } else if (mode==FRONT) {
      z1 = ENDY - y1;
      line(x1-r, z1, x1+r, z1);
      ellipse(x1, y1, 2*r, 2*r);
      line(ENDX-z1, y1-r, ENDX-z1, y1+r);
    } else {
    }
  }
}


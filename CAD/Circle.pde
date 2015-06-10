class Circle extends Shape {

  int r, d;

  //where (xx1, yy1) is the center of the circle
  //(regardless of actual x, y, z dimensions)
  //and rr is the radius of the circle
  //and mod indicates which view the face of the circle is in
  Circle(int xx1, int yy1, int r, int mod) {
    setM(mod);
    if (mode == TOP) {
      setX(xx1);
      setY(yy1);
      setZ(100);
      setR(r);
      setD(2*r);
    } else if (mode == FRONT) {
      setX(xx1);
      setY(100);
      setZ(ENDY-yy1);
      setR(r);
      setD(2*r);
    } else if (mode == RIGHT){
      setX(BOUNDARYV1+100);
      setY(ENDX-xx1);
      setZ(ENDY-yy1);
      setR(r);
      setD(2*r);
    }
  }
  
  int getR() {
    return r;
  }

  int getD() {
    return d;
  }

  void draw() {
    if (mode == TOP) {
      ellipse(x1, y1, d, d);
      line(x1-r, ENDY-z1, x1+r, ENDY-z1);
      line(ENDX-y1-r, ENDY-z1, ENDX-y1+r, ENDY-z1);
    } else if (mode == FRONT) {
      line(x1-r, y1, x1+r, y1);
      ellipse(x1, ENDY-z1, d, d);
      line(ENDX-y1, ENDY-z1-r, ENDX-y1, ENDY-z1+r);
    } else {
      line(x1, y1-r, x1, y1+r);
      line(x1, ENDY-z1-r, x1, ENDY-z1+r);
      ellipse(ENDX-y1, ENDY-z1, d, d);
    }
  }

  void setR(int rr) {
    r = rr;
  }
  void setD(int dd) {
    d = dd;
  }
}


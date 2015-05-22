class Rectangle extends Shape {
  float x2, y2;

  Rectangle(float xx1, float yy1, float zz1, 
  float xx2, float yy2, float zz2, int mod) {
    super(xx1, yy1, zz1, zz2, mod);
    x2 = xx2;
    y2 = yy2;
  }

  void draw() {
    if (mode==TOP) {
      rect(x1+BOUNDARYV1, y1, x2+BOUNDARYV1, y2);
      line(x1+BOUNDARYV1, ENDY-z1, x2+BOUNDARYV1, ENDY-z1);
      line(y1+BOUNDARYV2, ENDY-z1, y2+BOUNDARYV2, ENDY-z1);
    } else if (mode==RIGHT) {
      line(x1+BOUNDARYV1, y1, x2+BOUNDARYV1, y2);
      line(x1+BOUNDARYV1, ENDY-z1, x2+BOUNDARYV1, ENDY-z1);
      rect(y1+BOUNDARYV2, ENDY-z1, y2+BOUNDARYV2, ENDY-z1);
    } else if (mode==FRONT) {
      line(x1+BOUNDARYV1, y1, x2+BOUNDARYV1, y2);
      rect(x1+BOUNDARYV1, ENDY-z1, x2+BOUNDARYV1, ENDY-z1);
      line(y1+BOUNDARYV2, ENDY-z1, y2+BOUNDARYV2, ENDY-z1);
    }
  }
}


class Circle extends Shape {
  float r;
  Circle(float xx1, float yy1, float zz1, float zz2, float rr, int mod) {
    super(xx1, yy1, zz1, zz2, mod);
    r = rr;
  }

  void draw() {
    if (mode==TOP) {
      //println(pmouseX+" "+pmouseY);
      //println(BOUNDARYV1);
      //println(x1+BOUNDARYV1+" "+y1+" "+(x2+BOUNDARYV1)+" "+y2);
      ellipse(x1+BOUNDARYV1, y1, 2*r, 2*r);
      line(x1+BOUNDARYV1, ENDY-z1, x1+BOUNDARYV1+2*r, ENDY-z1);
      line(y1+BOUNDARYV2, ENDY-z1, y1+BOUNDARYV2+2*r, ENDY-z1);
    }/* else if (mode==FRONT) {
      line(x1+BOUNDARYV1, y1, x2+BOUNDARYV1, y2);
      ellipse(x1+BOUNDARYV1, ENDY-z2, 2*r, 2*r);
      line(y1+BOUNDARYV2, ENDY-z1, y2+BOUNDARYV2, ENDY-z2);
    } else if (mode==RIGHT) {
      line(x1+BOUNDARYV1, y1, x2+BOUNDARYV1, y2);
      line(x1+BOUNDARYV1, ENDY-z1, x2+BOUNDARYV1, ENDY-z2);
      ellipse(y1+BOUNDARYV2, ENDY-z2, 2*r, 2*r);
    }*/
  }
}


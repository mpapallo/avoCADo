class Circle extends Shape {
  
  int r;
  
  Circle(int xx1, int yy1, int zz1, int rr, int mod) {
    super(xx1, yy1, zz1, mod);
    r = rr;
  }

  void draw() {
    //println(pmouseX+" "+pmouseY);
    if (mode==TOP) {
      //println(BOUNDARYV1);
      //println(x1+BOUNDARYV1+" "+y1+" "+(x2+BOUNDARYV1)+" "+y2);
      ellipse(x1+BOUNDARYV1, y1, 2*r, 2*r);
      line(x1+BOUNDARYV1-r, ENDY-z1-r, x1+BOUNDARYV1+r, ENDY-z1-r);
      line(y1+BOUNDARYV2-r, ENDY-z1-r, y1+BOUNDARYV2+r, ENDY-z1-r);
    } else if (mode==FRONT) {
      line(x1+BOUNDARYV1-r, y1, x1+BOUNDARYV1+r, y1);
      ellipse(x1+BOUNDARYV1, ENDY-z1, 2*r, 2*r);
      line(ENDX-y1-r, ENDY-z1-r, ENDX-y1-r, ENDY-z1+r);
    } /*else if (mode==RIGHT) {
      line(x1+BOUNDARYV1+r, y1-r, x1+BOUNDARYV1+r, y1+r);
      line(x1+BOUNDARYV1-r, ENDY-z1-r, x1+BOUNDARYV1+r, ENDY-z1-r);
      ellipse(y1+BOUNDARYV2, ENDY-z1, 2*r, 2*r);
    }*/
  }
}


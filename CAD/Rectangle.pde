class Rectangle extends Shape {
  
  float x2, y2, z2;

  Rectangle(float xx1, float yy1, float zz1, 
  float xx2, float yy2, float zz2, int mod) {
    super(xx1, yy1, zz1, mod);
    x2 = xx2;
    y2 = yy2;
    z2 = zz2;
  }

  void draw() {
    if (mode==TOP) {
      //println(pmouseX+" "+pmouseY);
      //println(BOUNDARYV1);
      //println(x1+BOUNDARYV1+" "+y1+" "+(x2+BOUNDARYV1)+" "+y2);
      rect(x1+BOUNDARYV1, y1, x2-x1, y2-y1);
      line(x1+BOUNDARYV1, ENDY-z1, x2+BOUNDARYV1, ENDY-z1);
      line(y1+BOUNDARYV2, ENDY-z1, y2+BOUNDARYV2, ENDY-z1);
    } else if (mode==FRONT) {
      line(x1+BOUNDARYV1, y1, x2+BOUNDARYV1, y2);
      rect(x1+BOUNDARYV1, ENDY-z2, x2-x1, z2-z1);
      line(y1+BOUNDARYV2, ENDY-z1, y2+BOUNDARYV2, ENDY-z2);
    } else if (mode==RIGHT) {
      line(x1+BOUNDARYV1, y1, x2+BOUNDARYV1, y2);
      line(x1+BOUNDARYV1, ENDY-z1, x2+BOUNDARYV1, ENDY-z2);
      rect(y1+BOUNDARYV2, ENDY-z2, y2-y1, z2-z1);
    }
  }
  
}


class Rectangle extends Shape {

  int width, length;
  /*
  Rectangle(int xx1, int yy1, int zz1, 
   int xx2, int yy2, int zz2, int mod) {
   super(xx1, yy1, zz1, mod);
   x2 = xx2;
   y2 = yy2;
   z2 = zz2;
   }
   */
  Rectangle(int xx1, int yy1, int w, int l, int mod) {
    setM(mod);
    width = w;
    length = l;
    if (mode == TOP) {
      setX(xx1);
      setY(yy1);
      setZ(100);
    } else if (mode == FRONT) {
      setX(xx1);
      setZ(yy1);
      setY(100);
    } else if (mod == RIGHT) {
      setY(xx1);
      setZ(yy1);
      setX(100);
    }
  }

  void draw() {
    if (mode==TOP) {
      rect(x1, y1, width, length);
      line(x1, ENDY-z1, x1+width, ENDY-z1);
      line(ENDX-y1, ENDY-z1, ENDX-(y1+length), ENDY-z1);
    } else if (mode==FRONT) {
      line(x1, BOUNDARYH-y1, x1+width, BOUNDARYH-y1);
      rect(x1, z1, width, length);
      line(BOUNDARYV2+y1, z1, BOUNDARYV2+y1, z1+length);
    } else if (mode==RIGHT) {
      rect(y1, z1, width, length);
      line(BOUNDARYV1+x1, ENDX-(y1+width), BOUNDARYV1+x1, ENDX-y1);
      line(BOUNDARYV1+x1, z1+length, BOUNDARYV1+x1, z1);
    }
  }
}


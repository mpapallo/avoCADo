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
    if (mod == TOP) {
      setX(xx1);
      setY(yy1);
      setZ(100);
      setM(mod);
      width = w;
      length = l;
    } else if (mod == FRONT) {
      setX(xx1);
      setZ(yy1);
      setY(100);
      setM(mod);
      width = w;
      length = l;
    } else if (mod == RIGHT) {
      setZ(xx1);
      setY(yy1);
      setX(100);
      setM(mod);
      width = w;
      length = l;
    }
  }

  void draw() {
    if (mode==TOP) {
      rect(x1, y1, width, length);
      line(x1, ENDY-z1, x1+width, ENDY-z1);
      line(ENDX-y1, ENDY-z1, ENDX-(y1+length), ENDY-z1);
    } else if (mode==FRONT) {
      rect(x1, z1, width, length);
      line(x1, BOUNDARYH-y1, x1+width, BOUNDARYH-y1);
      line(BOUNDARYV2+y1, z1, BOUNDARYV2+y1, z1+length);
    } else if (mode==RIGHT) {
      rect(y1, z1, width, length);
      line(x1, ENDY-z1, x1+width, ENDY-z1);
      line(ENDX-(y1), ENDY-z1, ENDX-(y1+length), ENDY-z1);
    }
  }
}


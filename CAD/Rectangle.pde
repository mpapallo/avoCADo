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
    if (mode == TOP) {
      setX(xx1);
      setY(yy1);
      setZ(10);
      width = w;
      length = l;
    } else if (mode == FRONT) {
      setX(xx1);
      setZ(yy1);
      setY(10);
      width = w;
      length = l;
    } else if (mode == RIGHT) {
      setZ(xx1);
      setY(yy1);
      setX(10);
      width = w;
      length = l;
    }
  }

  void draw() {
    if (mode==TOP) {
      //println(BOUNDARYV1);
      //println(x1+BOUNDARYV1+" "+y1+" "+(x2+BOUNDARYV1)+" "+y2);
      //println(x1+" "+y1+" "+z1+" "+width+" "+length);
      rect(x1, y1, width, length);
      line(x1, ENDY-z1, x1+width, ENDY-z1);
      line(ENDX-(y1), ENDY-z1, ENDX-(y1+length), ENDY-z1);
    } /*else if (mode==FRONT) {
      line(x1, y1, x2, y2);
      rect(x1, z2, x2-x1, z2-z1);
      line(y1, z1, y2, ENDY-z2);
    } else if (mode==RIGHT) {
      line(x1, y1, x2, y2);
      line(x1, z1, x2, z2);
      rect(y1, z2, y2-y1, z2);
    }*/
  }
}


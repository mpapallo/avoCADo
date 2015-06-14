abstract class Shape {

  int x1, y1, z1;
  int mode;
  boolean isActive;
  final int TOP = 0, FRONT = 1, RIGHT = 2;
  final int BOUNDARYV1 = 100, BOUNDARYV2 = 500, BOUNDARYH = 300;

  Shape() {}

  Shape(int xx1, int yy1, int zz1, int mod) {
    x1 = xx1;
    y1 = yy1;
    z1 = zz1;
    mode = mod;
    isActive = false;
  }

  int getX() {
    return x1;
  }

  int getY() {
    return y1;
  }

  int getZ() {
    return z1;
  }

  int getM() {
    return mode;
  }
  
  boolean getA() {
    return isActive;
  }

  void setX(int x) {
    x1=x;
  }

  void setY(int y) {
    y1=y;
  }

  void setZ(int z) {
    z1=z;
  }

  void setM(int m) {
    mode = m;
  }
  
  void setA(boolean a) {
    isActive = a;
  }

  abstract void draw();
}


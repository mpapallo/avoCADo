abstract class Shape {

  int x1, y1, z1;
  int mode;
  final int TOP = 0, FRONT = 1, RIGHT = 2;
  final int BOUNDARYV1 = 100, BOUNDARYV2 = 500, BOUNDARYH = 300;

  Shape() {
  }

  Shape(int xx1, int yy1, int zz1, int mod) {
    x1 = xx1;
    y1 = yy1;
    z1 = zz1;
    mode = mod;
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

  abstract void draw();
}


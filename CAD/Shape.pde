abstract class Shape {

  float x1, y1, z1;
  int mode;
  final int TOP = 0, FRONT = 1, RIGHT = 2;
  final int BOUNDARYV1 = 100, BOUNDARYV2 = 500, BOUNDARYH = 300;

  Shape(float xx1, float yy1, float zz1, int mod) {
    x1 = xx1;
    y1 = yy1;
    z1 = zz1;
    mode = mod;
  }

  abstract void draw();

}

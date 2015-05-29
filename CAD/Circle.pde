class Circle extends Shape {
  
  float r;
  Circle(float xx1, float yy1, float zz1, float rr, int mod) {
    super(xx1, yy1, zz1, mod);
    r = rr;
  }

  void draw() {
    if (mode==TOP){
       ellipse(x1, y1, 2*r, 2*r);
       line(x1-r, ENDY-z1-r, x1+r, ENDY-z1-r);
       line(ENDX-y1-r, ENDY-z1-r, ENDX-y1+r, ENDY-z1-r);       
    }else if (mode==FRONT){
       line(x1-r, y1, x1+r, y1);
       ellipse(x1, ENDY-z1, 2*r, 2*r);
       line(ENDX-y1, ENDY-z1-r, ENDX-y1, ENDY-z1+r);
    }else{
      
    }
  }
}


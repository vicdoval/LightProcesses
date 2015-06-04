/*
  Coded by Víctor Doval.
  Title:   Pseudo-realities.
  Description: Rotating geometry build up on transparency gradients  and some  blur post-processing.
  Created: 2015 May.
  Pusblished at http://lightprocesses.tumblr.com/
 This work is licensed under the MIT License 
 (It lets people do anything they want with your code as long as they provide attribution
 back to you and don't hold you liable)
*/

int dur=20;
color c1=#008Eff;
PImage bas;

void setup() {
  size(500, 500, P2D);
  smooth(16);
  noStroke();
  frameRate(20);
  bas=new PImage(width, height);
}

void draw() {

  background(0);
  blendMode(ADD);
  float time=norm(frameCount%dur, 0, dur);
  pushMatrix();
  translate(width/2, height/2);
  float l=300/500.0*width;
  float rs=200*cos(PI/4)/500.0*height;
  for (int i=0; i<4; i++) {
    for (int j=0; j<3; j++) {
      float ang=TAU/4;
      float rot=-TAU/4*time;
      float glRot=PI/3;
      float angf=(i*ang+rot+PI/4)-(j*TAU/3+glRot);
      float ax=rs*cos(i*ang+rot);
      float ay=rs*sin(i*ang+rot);
      float bx=rs*cos((i+1)*ang+rot);
      float by=rs*sin((i+1)*ang+rot);

      float cx=ax+l*cos(j*TAU/3+glRot);
      float cy=ay+l*sin(j*TAU/3+glRot);
      float dx=bx+l*cos(j*TAU/3+glRot);
      float dy=by+l*sin(j*TAU/3+glRot);
      beginShape();
      fill(c1, 100+87*abs(sin(angf)));
      vertex(ax, ay);
      vertex(bx, by);

      fill(0, 0);
      vertex(dx, dy);
      vertex(cx, cy);

      endShape();
    }
  }
  popMatrix();
  // filter(BLUR);
  bas=get();
  for (int i=1; i<4; i++) {
    bas.filter(DILATE);
    bas.filter(BLUR, pow(i,3));
    tint(255, 64/i);
    image(bas, 0, 0);
  }
  // saveFrame("im/##.png");
  //  if (frameCount==dur)exit();
}

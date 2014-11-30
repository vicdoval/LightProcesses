/*
Coded by Víctor Doval.
 Title: Horseshoe Arch Cristal Land.
 Description: Loop throught horseshoe arches' geometry with a double draw to get wireframe and filled geometry 
 and some post-processing.
 
 Created: 2014 Nov.
Pusblished at http://lightprocesses.tumblr.com/
 This work is licensed under the MIT License 
 (It lets people do anything they want with your code as long as they provide attribution
 back to you and don't hold you liable)

*/

PImage bas, basWire, fir;
float mar=0.25;
float diag;
color cl=#1C1616;
PShape pr;
float camx, camy;
int co;
float siz=500;

void setup() {

  size(500, 500, P3D);
  diag=width*sqrt(2)/2;
  camx=width/2.0-80;
  camy=height/2.0+225;
  frameRate(1);
  // noLoop();
  smooth(16);
  fir=loadImage("fir.png");
  bas= new PImage(width, height);
  basWire= new PImage(width, height);
  
}

void draw() {

  co=frameCount%15;
  background(255);
  camSet();
  geomdraw();
  post();
  
}

void camSet() {

  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
  cameraZ/100.0, cameraZ*50.0);


  camera(camx, camy, (height/2.0) / tan(PI*30.0 / 180.0), 
  width/2.0, height/2.0+50, 0, 
  0, 1, 0);
  
}


void geomdraw() {

  for (int k=0; k<2; k++) {
    if (k==0)noFill();
    if (k==1) fill(cl);
    pushMatrix();
    translate(width/2, height/2, -250);

    for (int j=-5; j<5; j++) {
      for (int i=0; i<15; i++) {
        pushMatrix();
        float zp=siz-i*siz+co*siz/15.0;
        translate(j*siz, 0, zp);
        float d=dist(j*siz, zp, camx, 0);
        float col=map(d, 10, 5000, 255, 0);

        stroke(cl, col);

        portic(siz);
        rotateY(HALF_PI);
        translate(siz/2, 0, -siz/2);
        portic(siz);

        popMatrix();
      }
    }
    popMatrix();
    if (k==0) basWire=get();
    if (k==1) bas=get();
  }

  camera();
}

void portic(float s) {
  
  pushMatrix();
  translate(-s/2, -s/2);

  for (int i=0; i<2; i++) {
    translate(0, 0, s/100*i);
    beginShape();
    vertex(0, 0);
    vertex(s, 0);
    vertex(s, s);
    vertex(s-s*mar, s);
    for (int j=0; j<=40; j++) {
      float arq=3*TAU/4;
      float rad=(1-2*mar)*s*cos(PI/4);
      vertex(s/2+rad*sin(j*arq/40+PI-arq/2), s/1.5+rad*cos(j*arq/40+PI-arq/2));
    }
    vertex(s*mar, s);
    vertex(0, s);
    endShape(CLOSE);
  }

  popMatrix();
  
}


void post() {
  
  background(cl);

  tint(255, 255);
  image(basWire, 0, 0);
  tint(255, 127);
  image(bas, 0, 0);
  filter(BLUR, 3);

  blendMode(ADD);

  tint(255, 64);
  image(basWire, 0, 0);
  tint(255, 127);
  image(bas, 0, 0);


  blendMode(BLEND);
  filt(cl);
  blendMode(ADD);
  image(fir, width-fir.width, height-fir.height);
  blendMode(BLEND);
  saveFrame("im/###.jpg");
  if (frameCount==15)exit();
  
}


void filt(color c) {
  loadPixels();
  for (int i=0; i<pixels.length; i++) {
    float d=dist(width/2, height/2, i%width, int(i/width));
    // pixels[i]=color(255-min(d,255));
    pixels[i]=lerpColor(pixels[i], c, d/diag);
  }
  updatePixels();
}

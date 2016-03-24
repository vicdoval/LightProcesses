/*
Coded by Víctor Doval.
 Title:  Subconscious Space.
 Description: Loop throught isonometric caotic space.
 Created ofr the MCCC of March
 
 Created: 2016 Mar.
Pusblished at http://lightprocesses.tumblr.com/
 This work is licensed under the MIT License 
*/

color[] c={#4B89AC, #ACE6F6, #E4FCF9, #FAEE5A};
float time;
int dur=50;
int vals[][][];
int n=30;
float mod=15;
void setup() {
  size(540, 540, P3D);
  smooth(16);
  randomSeed(20);
  frameRate(20);
  vals=new int[n][n][5];
  for (int j=0; j<n; j++) {
    for (int i=0; i<n; i++) {
      vals[i][j][0]=int(random(-n, n));
      vals[i][j][1]=int(random(-n, n));
      vals[i][j][2]=int(random(0, 3));
      vals[i][j][3]=int(random(1, 4));
      vals[i][j][4]=int(random(1, 4));
    }
  }
}
void draw() {
  time=norm(frameCount%dur, 0, dur);
  background(c[0]);
  noStroke();
  ortho();
  camera(300, 300, 300, 0, 0, 0, 0, 0, 1);
    for (int k=-1; k<2; k++) {
    for (int j=0; j<n; j++) {
      for (int i=0; i<n; i++) {
        int[] ac=vals[i][j];
        int xp= ac[0];
        int yp= ac[1];
        int typ= ac[2];
        rectO(xp*mod, yp*mod+(k-time)*2*n*mod, 0, ac[3]*mod, ac[4]*mod, typ);
      }
    }
  }
}

void rectO(float x, float y, float z, float w, float h, int dir) {
  switch(dir) {
  case 0:
    fill(c[2]);
    beginShape();
    vertex(x, y, z);
    vertex(x+w, y, z);
    vertex(x+w, y+h, z);
    vertex(x, y+h, z); 
    endShape(CLOSE);
    break;
  case 1:
    fill(c[1]);
    beginShape();
    vertex(x, y, z);
    vertex(x+w, y, z);
    vertex(x+w, y, z+h);
    vertex(x, y, z+h); 
    endShape(CLOSE);
    break;
  case 2:
    fill(c[3]);

    beginShape();
    vertex(x, y, z);
    vertex(x, y+w, z);
    vertex(x, y+w, z+h);
    vertex(x, y, z+h); 
    endShape(CLOSE);
    break;
  }
}



import peasy.*;

PeasyCam cam;

PGraphics img;
PImage cap;

void setup() {
  size(640, 480,P3D);
  img = createGraphics(width, height, P3D);
  cap = createImage(width, height, RGB);
  
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  
  background(0);
}

void draw() {
  blendMode(NORMAL);
  fill(0, 55);
  noStroke();
  rect(0,0,width,height);
  
  blendMode(ADD);
  noFill();
  stroke(255, 5);
  
  img.beginDraw();
  img.tint(255,5);
  img.image(cap,0,0,width,height);
  img.endDraw();

  beginShape();
  texture(img);
  vertex(10, 20, 0, 0);
  vertex(80, 5, 100, 0);
  vertex(95, 90, 100, 100);
  vertex(40, 95, 0, 100);
  endShape();
  
  cap = get(0,0,width,height);
}

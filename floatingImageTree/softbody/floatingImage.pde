import processing.video.*;
Movie myMovie;

ArrayList<SoftBody> list;
PImage image;

import java.awt.*;

Rectangle monitor = new Rectangle();
boolean bSubdisplay = true;
boolean cursorIsVisible = true;
final float RADIUS_MIN = 7;
final float RADIUS_MAX = 61;

void setup() {
  size(1920, 1080);
  noStroke();
  frameRate(30);
  list = new ArrayList<SoftBody>();
  for(int i=0; i<100; i++){
    float startX = random(-displayWidth, 2*displayWidth);
    float startY = random(0, displayHeight);
//    float destinationX = startX+random(-500, 500);
    float destinationX = linearToRadiate(startX, 0.00001)+random(-50, 50);
    float destinationY = -2000+random(-500, 500);
    list.add(new SoftBody(startX, startY, destinationX, destinationY, random(RADIUS_MIN, RADIUS_MAX), color(220, 40, 50, 200), random(0, 360)));
  }
  //s2 = new SoftBody(500, displayHeight-100, 25, color(255, 127, 255, 127));
  image = loadImage("image.jpg");
  
  myMovie = new Movie(this, "video.mov");
  myMovie.loop();
  myMovie.volume(0);
  
}

void draw() {
  //fade background
  //fill(0, 255);
  //rect(0,0,width, height);
  
  image(myMovie, 0, 0);
  for(int i =0; i<list.size(); i++){
    list.get(i).update();
  }
  //s1.update();
//  s2.update();
  inOrOut(list);
//  println(list.size());
 
}

void inOrOut(ArrayList<SoftBody> listSoftBody){
  for (int i=0; i<listSoftBody.size(); i++){
    if(listSoftBody.get(i).getCenterY()+listSoftBody.get(i).getRadius() < 0){
      listSoftBody.remove(i);
      float startX = random(-displayWidth, 2*displayWidth);
      float startY = displayHeight+random(38, 50);
//      float destinationX = startX+random(-500, 500);
      float destinationX = linearToRadiate(startX, 0.00001)+random(-50, 50);
      float destinationY = -2000+random(-500, 500);
      list.add(new SoftBody(startX, startY, destinationX, destinationY, random(RADIUS_MIN, RADIUS_MAX), color(220, 40, 50, 200), random(0, 360)));
    }
  }
}

void movieEvent(Movie m) {
  m.read();
}

void mousePressed(){
  if(cursorIsVisible){
    noCursor();
  }else{
    cursor();
  }
  cursorIsVisible = !cursorIsVisible;
}

float linearToRadiate(float x, float convertValue){
  float y = convertValue*pow(x-displayWidth/2.0, 3)+displayWidth/2.0;
  return y;
}

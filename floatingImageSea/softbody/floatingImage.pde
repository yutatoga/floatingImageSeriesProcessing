import controlP5.*;
ControlP5 cp5;
float sliderR = 255.0;
float sliderG = 255.0;
float sliderB = 255.0;
float sliderA = 230.0;

SoftBody s1;
SoftBody s2;
ArrayList<SoftBody> list;
PImage imageBackground, imageTop;
final int SOFTBODY_NUMBER = 100;
final int RADIUS_MIN = 10;
final int RADIUS_MAX = 100;
void setup() {
  size(1920, 1280);
  noStroke();
  frameRate(30);
  list = new ArrayList<SoftBody>();
  for(int i=0; i<SOFTBODY_NUMBER; i++){
    float startX = random(-displayWidth, 2*displayWidth);
    float startY = random(0, displayHeight);
    float destinationX = linearToRadiate(startX, 0.000005);
    float destinationY = -2000;
    list.add(new SoftBody(startX, startY, destinationX, destinationY, random(RADIUS_MIN, RADIUS_MAX), color(sliderR, sliderG, sliderB, sliderA)));
  }
  //s2 = new SoftBody(500, displayHeight-100, 25, color(255, 127, 255, 127));
  imageBackground = loadImage("image_background.jpg");
  imageTop = loadImage("image_top.png");
  
  //gui
  cp5 = new ControlP5(this);
  cp5.addSlider("sliderR").setPosition(10,10).setRange(0,255);
  cp5.addSlider("sliderG").setPosition(10,20).setRange(0,255);
  cp5.addSlider("sliderB").setPosition(10,30).setRange(0,255);
  cp5.addSlider("sliderA").setPosition(10,40).setRange(0,255);
  cp5.hide();
}

void draw() {
  //fade background
  //fill(0, 255);
  //rect(0,0,width, height);
  
  image(imageBackground, 0, 0);
  for(int i =0; i<list.size(); i++){
    list.get(i).update();
  }
  //s1.update();
//  s2.update();
  inOrOut(list);
  image(imageTop, 0, 0);
//  println(frameRate);
}

void inOrOut(ArrayList<SoftBody> listSoftBody){
  for (int i=0; i<listSoftBody.size(); i++){
    if(listSoftBody.get(i).getCenterY()+listSoftBody.get(i).getRadius() < 0){
      println(list.getClass());
      println("before removed:", list.size());  
      listSoftBody.remove(i);
      println("removed:", list.size());
      float startX = random(-displayWidth, 2*displayWidth);
      float startY = displayHeight+random(40, 200);
      float destinationX = linearToRadiate(startX, 0.000005);
      float destinationY = -2000;
      list.add(new SoftBody(startX, startY, destinationX, destinationY, random(RADIUS_MIN, RADIUS_MAX), color(sliderR, sliderG, sliderB, sliderA)));
    }
  }
}

float linearToRadiate(float x, float convertValue){
  float y = convertValue*pow(x-displayWidth/2.0, 3)+displayWidth/2.0;
  return y;
}

void keyPressed(){
  switch(key){
    case 'h':
      if (cp5.isVisible()){
        cp5.hide();
      }else{
        cp5.show();
      }
    break;
  }
}


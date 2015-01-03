SoftBody s1;
SoftBody s2;
ArrayList<SoftBody> list;
PImage image;
void setup() {
  size(1920, 1280);
  noStroke();
  frameRate(30);
  list = new ArrayList<SoftBody>();
  for(int i=0; i<1000; i++){
    list.add(new SoftBody(random(-displayWidth, 2*displayWidth), random(0, displayHeight), displayWidth/2.0, -2000, random(7, 53), color(0, 34, 244, 200)));
  }
  //s2 = new SoftBody(500, displayHeight-100, 25, color(255, 127, 255, 127));
  image = loadImage("image.jpg");
}

void draw() {
  //fade background
  //fill(0, 255);
  //rect(0,0,width, height);
  
  image(image, 0, 0);
  for(int i =0; i<list.size(); i++){
    list.get(i).update();
  }
  //s1.update();
//  s2.update();
  inOrOut(list);
  println(frameRate);

}

void inOrOut(ArrayList<SoftBody> listSoftBody){
  for (int i=0; i<listSoftBody.size(); i++){
    if(listSoftBody.get(i).getCenterY()+listSoftBody.get(i).getRadius() < 0){
      println(list.getClass());
      println("before removed:", list.size());  
      listSoftBody.remove(i);
      println("removed:", list.size());
      list.add(new SoftBody(random(-displayWidth, 2*displayWidth), displayHeight+random(38, 50), displayWidth/2.0, -2000, random(7, 53), color(0, 34, 244, 200)));
      
    }
  }
}


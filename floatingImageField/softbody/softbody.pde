// http://r-dimension.xsrv.jp/classes_j/inheritance/
// http://r-dimension.xsrv.jp/classes_j/class_method/
// http://yoppa.org/proga10/1190.html
// http://processing.org/examples/softbody.html

class SoftBody{
  // center point
  float centerX = 0;
  float centerY = 0;
  float startX = 0;
  float startY = 0;
  float destinationX = 0;
  float destinationY = 0;
  float startDistanceFromDestination = 0;
  float radius = 45, rotAngle = -90;
  float accelX, accelY;
  float springing = .0009, damping = .98;
  color bodyColor;
  
  //corner nodes
  int nodes = 5;
  float nodeStartX[] = new float[nodes];
  float nodeStartY[] = new float[nodes];
  float[]nodeX = new float[nodes];
  float[]nodeY = new float[nodes];
  float[]angle = new float[nodes];
  float[]frequency = new float[nodes];
  
  // soft-body dynamics
  float organicConstant = 1;
  
   SoftBody(float x, float y, float dx, float dy, float r, color col){
    //center shape in window
    centerX = x;
    centerY = y;
    startX = x;
    startY = y;
    destinationX = dx;
    destinationY = dy;
    startDistanceFromDestination = dist(startX, startY, destinationX, destinationY);
    radius = r;
    bodyColor = col;
    // iniitalize frequencies for corner nodes
    for (int i=0; i<nodes; i++){
      frequency[i] = random(5, 12);
    }
  }
  void drawShape() {
    //  calculate node  starting locations
    float distanceFromDestination = dist(centerX, centerY, destinationX, destinationY);
    float sizeDown = distanceFromDestination/startDistanceFromDestination;
    for (int i=0; i<nodes; i++){
      nodeStartX[i] = centerX+cos(radians(rotAngle))*radius*sizeDown*sizeDown*sizeDown;
      nodeStartY[i] = centerY+sin(radians(rotAngle))*radius*sizeDown*sizeDown*sizeDown;
      rotAngle += 360.0/nodes;
    }
  
    // draw polygon
    curveTightness(organicConstant);
    fill(bodyColor);
    beginShape();
    for (int i=0; i<nodes; i++){
      curveVertex(nodeX[i], nodeY[i]);
    }
    for (int i=0; i<nodes-1; i++){
      curveVertex(nodeX[i], nodeY[i]);
    }
    endShape(CLOSE);
  }
  void moveShape() {
    //move center point
//A
//    float deltaX = mouseX-centerX;
//    float deltaY = mouseY-centerY;
//B
//    float deltaX = random(-200, 200);
//    float deltaY = random(-100, -10);
//DESTINATION
    float deltaX = (destinationX-centerX)*0.02;
    float deltaY = (destinationY-centerY)*0.02;
    // create springing effect
    deltaX *= springing;
    deltaY *= springing;
    accelX += deltaX;
    accelY += deltaY;
  
    // move predator's center
    centerX += accelX;
    centerY += accelY;
  
    // slow down springing
    accelX *= damping;
    accelY *= damping;
  
    // change curve tightness
    organicConstant = 0;//1-((abs(accelX)+abs(accelY))*.1);
  
    //move nodes
    for (int i=0; i<nodes; i++){
      nodeX[i] = nodeStartX[i]+sin(radians(angle[i]))*(accelX*2);
      nodeY[i] = nodeStartY[i]+sin(radians(angle[i]))*(accelY*2);
      angle[i]+=frequency[i];
    }
  }
  void update(){
      drawShape();
      moveShape();
      println(frameRate);
  }
  float getCenterX(){
    return centerX;
  }
  float getCenterY(){
    return centerY;
  }
  float getRadius(){
    return radius;
  }
}

class Tanks {
  // initiate bullet object called fire 
  bullet fire;
  // initiate PImage for body of tank
  PImage main;
  // initiate PImage for nozzle of tank
  PImage nozzle;
  // starting score initiated to be 0
  int score = 0;
  int xpos, ypos, r_l, oxpos, oypos;
  // nozzle angle initiated to be 0
  int nozzleAngle = 0;
  // turn boolean initiated to false
  boolean turn = false;
  int boxHeight = 59;
  int boxWidth = 68;
  int power;
  int origx;
  int therex = 0;
  PImage[] explosion1 = new PImage[6];

  // variables for the explosion sprites
  int animationTimer = millis();
  int animationTimerValue = 250;
  // initiate current frame to be 0
  int currentFrame = 0;
  // number of frames is 5
  int numFrames = 5;
  // initiate the on boolean to be false
  boolean on = false;

  Tanks(int _r_l, int _xpos, int _ypos, int _oxpos, int _oypos, int _power) {
    xpos = _xpos;
    origx = xpos;
    ypos = _ypos;
    oxpos = _oxpos;
    oypos = _oypos;
    therex = oxpos;

    r_l = _r_l;
    power = _power;
    // create new bullet object called fire that comes out of the nozzle at the given angle
    fire = new bullet(800, 800, nozzleAngle, 0, 0);

    if (_r_l>0) {
      // load red tank png
      main = loadImage("rTank.png", "png");
      nozzle = loadImage("Untitled_Artwork 13.png", "png");
      // red tank goes first
      turn = true;
      // populate second array for blue tank explosion
      for (int j=0; j < explosion1.length; j ++) {
        // loads tiles pngs in order of sprite
        explosion1[j] = loadImage("tile" + nf(j, 3) + ".png");
        // resize sprite
        explosion1[j].resize(0, 200);
      }
    } else {
      // populate first array for red tank explosion
      for (int i=0; i < explosion1.length; i ++) {
        // loads tile pngs in order of sprite
        explosion1[i] = loadImage("tile" + nf(i, 4) + ".png");
        // resize sprite
        explosion1[i].resize(0, 200);
      }
      // load blue tank png
      main = loadImage("lTank.png", "png");
      nozzle = loadImage("l_nozzle.png", "png");
    }
  }


  void display() {
    fire.move();
    pushMatrix();
    translate(xpos, ypos);
    pushMatrix();
    if (r_l > 0) {
      translate(50, 40);
      scale(-1, 1);
    } else {
      translate(80, 40);
    }
    scale(0.1);
    // roatates angle of the nozzles
    rotate(radians(nozzleAngle));
    image(nozzle, 0, 0);
    popMatrix();
    scale(0.1);
    image(main, 0, 0);
    popMatrix();
    // if the fired bullet hits the opposing tank
    if (fire.x < oxpos + 68 && oxpos -68 < fire.x && fire.y < oypos + 59 && oypos -59 < fire.y) {
      // score added to that team
      score +=1;
      on = true;
      if (r_l > 0) {
        println("Red's Score is ", score);
      } else {
        println("Blue's Score is ", score);
      }
      // bullet disappears
      fire.x = 90000;
      fire.y = 1000000;
    }
    // if the fired bullet hits the ground of the platfrom 
    if (fire.x < 350 && 25 < fire.x && fire.y < 590 && 190 <fire.y){
      // bullet disappears
      fire.x = 90000;
      fire.y = 100000;
    }
  }

// constrains movement of nozzles and tanks
  void keyPressed() {
    if (r_l > 0) {
      switch (keyCode) {
      case UP:
        nozzleAngle -= 5;
        nozzleAngle = constrain(nozzleAngle, -90, 0);
        break;

      case DOWN:
        nozzleAngle +=5;
        nozzleAngle = constrain(nozzleAngle, -90, 0);
        break;
      case LEFT:
        xpos -=5;
        xpos = constrain(xpos, origx-100, origx+100);
        break;
      case RIGHT:
        xpos +=5;
        xpos = constrain(xpos, origx-100, origx+100);
        break;
      }
      switch(key) {
      case 'a':
        oxpos -=5;
        oxpos = constrain(oxpos, therex -100, therex +100);
        break;
      case 'd':
        oxpos +=5;
        oxpos = constrain(oxpos, therex -100, therex +100);
        break;
      }
    } else {
      switch (key) {
      case 'w':
        nozzleAngle -= 5;
        nozzleAngle = constrain(nozzleAngle, -90, 0);
        break;

      case 's':
        nozzleAngle +=5;
        nozzleAngle = constrain(nozzleAngle, -90, 0);
        break;
      case 'a':
        xpos -=5;
        xpos = constrain(xpos, origx -100, origx +100);
        break;
      case 'd':
        xpos +=5;
        xpos = constrain(xpos, origx -100, origx +100);
        break;
      }
      switch(keyCode) {
      case LEFT:
        oxpos -=5;
        oxpos = constrain(oxpos, therex -100, therex +100);
        break;
      case RIGHT:
        oxpos +=5;
        oxpos = constrain(oxpos, therex -100, therex +100);
        break;
      }
    }
    if (turn && key == 32) {
      fire = new bullet(xpos, ypos, nozzleAngle, power, r_l);
    }
  }



  // helps animated the sprite in order by the millis time
  int getCurrentFrame() {
    if (on) {
      if ((millis() - animationTimer) >= animationTimerValue) {
        // increments frame count
        currentFrame = (currentFrame + 1);
        animationTimer = millis();
      }
    }
    println(currentFrame);
    // if frames excede maximum amount in sprite
    if (currentFrame >5){
      // go back to the first frame (0)
      currentFrame = 0;
      on = false;
    }
    return currentFrame;
  }

  void onOff() {
    on = !on;
  }
}

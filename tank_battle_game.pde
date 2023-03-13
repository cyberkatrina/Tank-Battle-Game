// initiates first tank object (red tank)
Tanks tank1;
// initiates second tank object (blue tank)
Tanks tank2;

PImage platform;
// creates 2 arrays of PImages for each explosion
PImage[] explosion1 = new PImage[6];
PImage[] explosion2 = new PImage[6];

void setup() {
  size(900, 700);
  // creates first tank object (red) at bottom right corner
  tank1 = new Tanks(1, 500, 600, 200, 100, 140);
  // creates second tank object (blue) at top left corner
  tank2 = new Tanks(0, 200, 100, 500, 600, 50);


  // loads the file into platform PImage
  platform = loadImage("platform.png");
  // resize for platform to fit scene
  platform.resize(0, 400);

  // populate first array for red tank explosion
  for (int i=0; i < explosion1.length; i ++) {
    // loads tile pngs in order of sprite
    explosion1[i] = loadImage("tile" + nf(i, 4) + ".png");
    // resize sprite
    explosion1[i].resize(0, 200);
  }

  // populate second array for blue tank explosion
  for (int j=0; j < explosion2.length; j ++) {
    // loads tiles pngs in order of sprite
    explosion2[j] = loadImage("tile" + nf(j, 3) + ".png");
    // resize sprite
    explosion2[j].resize(0, 200);
  }
}

void draw() {
  background(18, 0, 38);
  // size and color for bullets
  strokeWeight(8);
  stroke(255);
  // if statement happens when second (blue) tank gets hit
  if (tank2.on) {
    // sprite animation of blue explosion plays
    image(explosion1[tank2.getCurrentFrame()], tank1.xpos-50, tank1.ypos-60);
    // second tank returns back to normal
    tank2.display();
    // else if statement happens when first (red) tank gets hit
  } else if (tank1.on) {
    // sprite animation of red explosion plays
    image(explosion2[tank1.getCurrentFrame()], tank2.xpos-85, tank2.ypos-55);
    // first tank returns back to normal
    tank1.display();
    // else happens when no tanks are hit
  } else {
    // both tank objects display
    tank1.display();
    tank2.display();
  }
  // draw the platform at proper location
  image(platform, 20, 200);
}

// function decides which tank's turn it is by alternating them
void keyPressed() {
  tank1.keyPressed();
  tank2.keyPressed();
  if (key == 32) {
    tank1.turn ^= true;
    tank2.turn ^= true;
  }
}

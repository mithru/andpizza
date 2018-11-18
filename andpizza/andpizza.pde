PImage img;

int currVal = -1;

int mode = 0;
int ACTIVE = 1;
int INACTIVE = 0;

int startX = -1;
int startY = -1;
int endX = -1;
int endY = -1;
int prevEndX = 0;
int prevEndY = 0;

int lineHeight = 20;
int strokeWeight = 4;

boolean cursor = true;

void setup() {
  size(1000, 1000);
  img = loadImage("images/pizza-logo.png");
  img.loadPixels();
  //image(img, 0, 0, 1000, 1000);
  noFill();
}


void draw() {

  if (cursor == true) {
    noCursor();
  } else {
    cursor(HAND);
  }
  background(0);
  stroke(255);
  strokeWeight(strokeWeight);
  lineHeight = int(map(mouseY, 0, 1000, 1, 100));
  strokeWeight = int(map(mouseX, 0, 1000, 1, lineHeight/2));
  //loadPixels();
  //println(pixels[mouseY*width + mouseX]);
  lines();
}

void lines() {
  for (int i = 0; i < img.pixels.length; i++) {
    currVal = img.pixels[i];
    if (currVal == -16777216) {
      if (startX < 0) {
        startX = i % img.width;
        startY = i / img.height;
        //stroke(120);
        line(prevEndX, prevEndY, startX, startY);
      }
      endX = i % img.width;
      endY = i / img.height;
      mode = ACTIVE;
    } else {
      if (startX > 0) {
        //stroke(255);
        //line(startX, startY, endX, endY);
        float distanceBetPoints = dist(startX, startY, endX, endY);
        curve(startX - distanceBetPoints/2, startY + distanceBetPoints/2,
          startX, startY,
          endX, endY,
          endX + distanceBetPoints/2, endY + distanceBetPoints/2);
        prevEndX = endX;
        prevEndY = endY;
      }
      mode = INACTIVE;
      startX = -1;
      startY = -1;
      endX = -1;
      endY = -1;
    }
    if (i % (img.width) == 0) {
      //stroke(120);
      line(prevEndX, prevEndY, (i-1)%img.width, (i-1)/img.height);

      i += (img.width * lineHeight);
      prevEndX = 0;
      prevEndY = i/img.height;
    }
  }
}

void mouseClicked() {
  cursor = !cursor;
}

void keyReleased() {
  if (key == 's')
    saveFrame("#####.png");
}

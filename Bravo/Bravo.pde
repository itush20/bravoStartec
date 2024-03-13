/* //<>// //<>// //<>// //<>//
Bravo by Shahar and Itamar
 
TODOS:
 * Improve difficulty button
 * Implement the difficulty changer.
 */

import javax.swing.JOptionPane; // Message boxes: https://docs.oracle.com/javase%2F7%2Fdocs%2Fapi%2F%2F/javax/swing/JOptionPane.html#showOptionDialog(java.awt.Component,%20java.lang.Object,%20java.lang.String,%20int,%20int,%20javax.swing.Icon,%20java.lang.Object[],%20java.lang.Object)


// object setup
Rect startButton = new Rect();
Rect advancedDifficultyButton = new Rect();
Image bg = new Image();
Image rose = new Image();
ArrayList<Image> roses = new ArrayList<Image>();
Hexagon[] stars = new Hexagon[4];
SplashScreen splashScreen = new SplashScreen();
Image actor = new Image();
Text winText = new Text();
Text loseText = new Text();
Text startText = new Text();
Text difficultyText = new Text();
Music cheers = new Music();

PImage background;

// parameter setup
int roseDelay = 50;
int roseSpeed = 5;
float roseCaughtScore = 0.5;
float roseFellScore = 1.0;
boolean openingScreenSensor = false; // Change to true to disable opening screen
boolean useProcessingBackground = true; // Use Processing backgound(img) instead of bg.draw() because of lags.

float score = 0;

void setup() {
  size(1024, 512);
  
  rose.setImage("rose.png");
  actor.setImage("actor.png");

  if (!useProcessingBackground) {
    bg.setImage("bg_theater.png");
    bg.width = width;
    bg.height = height;
  } else background = loadImage("theater_resized.png");

  // buttons
  startButton.height = 30;
  startButton.width = 80;
  startButton.brush = color(255, 0, 0);
  startButton.pen = color(255);
  startButton.penThickness = 3;
  
  advancedDifficultyButton.height = 30;
  advancedDifficultyButton.width = 80;
  advancedDifficultyButton.brush = color(255, 0, 0);
  advancedDifficultyButton.pen = color(255);
  advancedDifficultyButton.penThickness = 3;


  // actor setup
  actor.x = 300;
  actor.y = 200;
  actor.width = 200;
  actor.height = 150;

  // stars setup
  stars[0] = createStar(30, 100, color(125));
  stars[1] = createStar(30, 130, color(125));
  stars[2] = createStar(30, 160, color(125));
  stars[3] = createStar(30, 190, color(125));
  cheers.load("cheers.mp3");

  // win text setup
  winText.brush = color(255);
  winText.text = "You Won!\nCongradulations!\n ~By Shahar & Itamar";
  winText.x = width / 2 - 250;
  winText.y = height / 2 - 50;
  winText.font = "Roboto";
  winText.textSize = 38;

  // lose text setup
  loseText.brush = color(255);
  loseText.text = "You Lost Bro\nYou Are Not Prawn Ready Anymore";
  loseText.x = width / 2 - 250;
  loseText.y = height / 2 - 50;
  loseText.font = "Roboto";
  loseText.textSize = 38;

  // start text setup
  startText.brush = color(255);
  startText.text = "Start";
  startText.x = 235;
  startText.y = 273;
  startText.font = "Roboto";
  startText.textSize = 24;
  
  difficultyText.brush = color(255);
  difficultyText.text = "Hard?";
  difficultyText.x = 345;
  difficultyText.y = 273;
  difficultyText.font = "Roboto";
  difficultyText.textSize = 24;

  // opening screen setup
  splashScreen.introMusic = cheers;
  splashScreen.image = "actor.png";
  splashScreen.backgroundColor = color(255, 0, 0);
  splashScreen.gameName = "bravo!";
  splashScreen.gameAuthor1 = "Itamar";
  splashScreen.gameAuthor2 = "Shahar";
  splashScreen.gameAuthor3 = "";
}

void draw() {
  // MAIN LOGIC
  // the opening screen
  if (!openingScreenSensor) { // Show opening screen until the start button is pressed
    splashScreen.show();
    startButton.x = 220;
    startButton.y = 250;
    advancedDifficultyButton.x = 330;
    advancedDifficultyButton.y = 250;
    startButton.draw();
    advancedDifficultyButton.draw();
    startText.draw();
    difficultyText.draw();
    if (startButton.pointInShape(mouseX, mouseY) && mousePressed) {
      openingScreenSensor = true;
      return;
    } else if (advancedDifficultyButton.pointInShape(mouseX,mouseY) && mousePressed) {
      difficultyChanger();
      openingScreenSensor = true;
      return;
    }
  } else {
    if (useProcessingBackground) background(background);
    else bg.draw();

    // winning
    if (score >= 4.0F) {
      winText.draw();
      return;
    }

    // losing
    if (score < 0.0F) {
      loseText.draw();
      return;
    }

    // generating roses
    if (frameCount%roseDelay == 0) {
      if (roses.size() == 10) {
        roses.clear();
      }
      roses.add(RoseGenerator());
    }


    // Rose drawing and score system.
    for (int i = 0; i < roses.size(); i++) {
      Image rose = roses.get(i);

      // rose caught
      if (actor.pointInShape(rose.x, rose.y)) {
        roses.remove(i);
        score += roseCaughtScore;
        int starNum = int(score) - 1;
        if (starNum >= 0) stars[starNum].brush = color(255, 255, 0);
      }

      // rose fell
      if (rose.y >= height) {
        roses.remove(i);
        int starNum = int(score) - 1;
        if (starNum >= 0) stars[starNum].brush = color(125);
        score -= roseFellScore;
        
      }

      rose.draw();
    }
    actor.draw();

    // stars
    for (Hexagon star : stars) {
      star.draw();
    }
  }
}


void mouseMoved() { // Move the actor if the mouse is moved or dragged.
  actor.x = mouseX - 75;
}

void mouseDragged() {
  mouseMoved();
}

Image RoseGenerator() { // Generates a new rose in a random location and returns its Image object
  int roseY = -50;
  int roseX = int(random(624)) + 200;
  Image rose = new Image();
  rose.setImage("rose.png");
  rose.y = roseY;
  rose.x = roseX;
  rose.width = 150;
  rose.height = 100;
  rose.speed = roseSpeed;
  rose.direction = Direction.DOWN;
  rose.rotation = 90;
  return rose;
} 

Hexagon createStar(int x, int y, color brush) { // Creates a star at a specific location
  Hexagon s = new Hexagon();
  s.x = x;
  s.y = y;
  s.radius = 25;
  s.rotation = -17.5;
  s.pen = color(255, 255, 0);
  s.penThickness = 4;
  s.brush = brush;
  return s;
}

void difficultyChanger() {
}

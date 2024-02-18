// obgect setup
Image bg = new Image();
Image rose = new Image();

ArrayList<Image> roses = new ArrayList<Image>();
Hexagon[] stars = new Hexagon[4];

SplashScreen screen = new SplashScreen();

Image actor = new Image();

Text winText = new Text();

Music cheers = new Music();

// parameter setup
int roseSpacing = 0;
float score = 0;
float roseCaught_score = 0.5;
// TODO: Add game behavior

void setup() {
  size(1024, 512);
  
  rose.setImage("rose.png");
  actor.setImage("actor.png");
  
  bg.setImage("bg_theater.png");
  bg.width = width;
  bg.height = height;
  
  roseSpacing = 50;
  
  actor.x = 300;
  actor.y = 200;
  actor.width = 200;
  actor.height = 150;
  
  stars[0] = createStar(30, 100, color(125));
  stars[1] = createStar(30, 130, color(125));
  stars[2] = createStar(30, 160, color(125));
  stars[3] = createStar(30, 190, color(125));
  cheers.load("cheers.mp3");
  //cheers.play();
  
  winText.brush = color(255);
  //winText.alpha = 0;
  winText.text = "You Won!\nCongradulations!\n ~By Shahar & Itamar";
  winText.x = width / 2 - 100;
  winText.y = height / 2;
  winText.font = "Consolas";
  winText.textSize = 38;
  
  screen.introMusic = cheers;
  screen.image = "bg_theater.png";
  screen.gameName = "bravo!";
  screen.gameAuthor1 = "Itamar And Shahar";
  screen.gameAuthor2 = "";
  screen.gameAuthor3 = "";
  
}

void draw() {
  if (frameCount < 1000)
  {
    screen.show();
    return;
  }
 
  bg.draw();

  if (score >= 4.0F) {
    //winText.alpha = 255;
    winText.draw();
    return;
  }
  
  if (frameCount%roseSpacing == 0) {
    if (roses.size() == 10) {
      roses.clear();
    }
    roses.add(RoseGenerator());
  }
  
  
  for (int i = 0; i < roses.size(); i++) {
    Image rose = roses.get(i);
    if (actor.pointInShape(rose.x, rose.y)) {
      roses.remove(i);
      
      score += roseCaught_score;
      
      stars[int(score-1)].brush = color(255,255, 0);
    }
    
    rose.draw();
  }
  
  actor.draw();
  
  for (Hexagon star : stars) {
    star.draw();
  }
}

void mouseMoved() {
  actor.x = mouseX - 75;
}

void mouseDragged(){
  mouseMoved();
}

Image RoseGenerator() {
  int roseY = -50;
  int roseX = int(random(624)) + 200;
  Image rose = new Image();
  rose.setImage("rose.png");
  rose.y = roseY;
  rose.x = roseX;
  rose.width = 150;
  rose.height = 100;
  rose.speed = 5;
  rose.direction = Direction.DOWN;
  rose.rotation = 90;
  return rose;
} 

Hexagon createStar(int x, int y, color brush) {
  Hexagon s = new Hexagon();
  s.x = x;
  s.y = y;
  s.radius = 25;
  s.rotation = -17.5;
  s.pen = color(255,255,0);
  s.penThickness = 4;
  s.brush = brush;
  return s;
}

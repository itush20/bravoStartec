// obgect setup
Image bg = new Image();
Image rose = new Image();

ArrayList<Image> roses = new ArrayList<Image>();

Image actor = new Image();
Hexagon star1;
Hexagon star2;
Hexagon star3;
Hexagon star4;
Music cheers = new Music();

// parameter setup
int roseSpacing = 0;

// TODO: Add game behavior

void setup() {
  size(1024, 512);
  bg.setImage("bg_theater.png");
  rose.setImage("rose.png");
  actor.setImage("actor.png");
  bg.width = width;
  bg.height = height;
  roseSpacing = 50;
  
  actor.x = 300;
  actor.y = 200;
  actor.width = 200;
  actor.height = 150;
  
  star1 = createStar(30, 100, color(125));
  star2 = createStar(30, 100, color(125));
  star3 = createStar(30, 100, color(125));
  star4 = createStar(30, 100, color(125));
  cheers.load("cheers.mp3");
  cheers.play();
}

void draw() {
  if (frameCount%roseSpacing == 0) {
    if (roses.size() == 10) {
      roses.clear();
    }
    roses.add(RoseGenerator());
  }
  bg.draw();
  for (Image rose : roses){
    rose.draw();
  }

  actor.draw();
  star1.draw();
  star2.draw();
  star3.draw();
  star4.draw();
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

Image bg = new Image();
Image rose = new Image();
Image actor = new Image();
Hexagon star1;
Hexagon star2;
Hexagon star3;
Hexagon star4;

void setup() {
  size(1024, 512);
  bg.setImage("bg_theater.png");
  rose.setImage("rose.png");
  actor.setImage("actor.png");
  bg.width = width;
  bg.height = height;
  
  rose.x = 300;
  rose.y = 20;
  rose.width = 150;
  rose.height = 100;
  rose.rotation = 90;
  
  actor.x = 300;
  actor.y = 200;
  actor.width = 200;
  actor.height = 150;
  
  star1 = createStar(30, 100, color(125));
  star2 = createStar(30, 100, color(125));
  star3 = createStar(30, 100, color(125));
  star4 = createStar(30, 100, color(125));
}

void draw() {
  bg.draw();
  rose.draw();
  actor.draw();
  star1.draw();
  star2.draw();
  star3.draw();
  star4.draw();
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

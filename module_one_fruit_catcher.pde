int basketX;
int basketWidth = 80;
int basketY;
int shapeType; // 0: smiley, 1: star, 2: tree

ArrayList<Fruit> fruits;
int score = 0;
int gameTime = 60;
boolean gameOver = false;
int shapeChangeTime = 20000;
int fruitSpawnTime = 1000;
int lastShapeChange;
int lastFruitSpawn;
int startTime;
int remainingLives = 5;

void setup() {
  size(400, 600);
  basketX = width / 2;
  basketY = height - 50;
  shapeType = int(random(3));
  fruits = new ArrayList<Fruit>();
  lastShapeChange = millis();
  lastFruitSpawn = millis();
  startTime = millis();
}

void draw() {
  background(255);
  
  if (gameOver) {
    displayGameOver();
    return;
  }
  
  drawBasket();
  drawUI();
  
  if (millis() - lastShapeChange > shapeChangeTime) {
    shapeType = int(random(3));
    lastShapeChange = millis();
    if (shapeChangeTime > 10000) shapeChangeTime -= 2000;
  }
  
  if (millis() - lastFruitSpawn > fruitSpawnTime) {
    fruits.add(new Fruit(int(random(3))));
    lastFruitSpawn = millis();
    if (fruitSpawnTime > 1000) fruitSpawnTime -= 100;
  }
  
  for (int i = fruits.size() - 1; i >= 0; i--) {
    Fruit f = fruits.get(i);
    f.update();
    f.display();
    if (f.y > height) fruits.remove(i);
    if (f.checkCollision(basketX, basketY, basketWidth)) {
      if (f.type == shapeType) {
        score++;
      } else {
        remainingLives--;
        if (remainingLives == 0) gameOver = true;
      }
      fruits.remove(i);
    }
  }
  
  int remainingTime = gameTime - (millis() - startTime) / 1000;
  if (remainingTime <= 0) gameOver = true;
}

void drawBasket() {
  fill(200);
  rect(basketX - basketWidth / 2, basketY, basketWidth, 20);
  fill(0);
  if (shapeType == 0) ellipse(basketX, basketY - 10, 20, 20);
  if (shapeType == 1) drawStar(basketX, basketY - 10, 10);
  if (shapeType == 2) drawTree(basketX, basketY - 10);
}

void drawUI() {
  fill(0);
  textSize(16);
  text("Score: " + score, 10, 20);
  text("Time: " + max(0, gameTime - (millis() - startTime) / 1000), 10, 40);
  for (int i = 0; i < remainingLives; i++) {
    fill(255, 0, 0);
    ellipse(350 + i * 15, 20, 10, 10);
  }
}

void displayGameOver() {
  background(0);
  fill(255);
  textSize(32);
  text("Game Over", width / 2 - 80, height / 2 - 20);
  text("Score: " + score, width / 2 - 50, height / 2 + 20);
  textSize(16);
  text("Press R to Restart", width / 2 - 60, height / 2 + 50);
}

void keyPressed() {
  if (keyCode == LEFT) basketX -= 20;
  if (keyCode == RIGHT) basketX += 20;
  if (gameOver && key == 'r') {
    restartGame();
  }
}

void restartGame() {
  score = 0;
  remainingLives = 5;
  gameOver = false;
  shapeChangeTime = 20000;
  fruitSpawnTime = 3000;
  lastShapeChange = millis();
  lastFruitSpawn = millis();
  startTime = millis();
  fruits.clear();
}

class Fruit {
  int x, y, type;
  int speed = 3;
  
  Fruit(int type) {
    x = int(random(width));
    y = 0;
    this.type = type;
  }
  
  void update() {
    y += speed;
  }
  
  void display() {
    fill(255, 200, 0);
    if (type == 0) ellipse(x, y, 20, 20);
    if (type == 1) drawStar(x, y, 10);
    if (type == 2) drawTree(x, y);
  }
  
  boolean checkCollision(int bx, int by, int bw) {
    return y > by && x > bx - bw / 2 && x < bx + bw / 2;
  }
}

void drawStar(int x, int y, int radius) {
  beginShape();
  for (int i = 0; i < 10; i++) {
    float angle = TWO_PI / 10 * i;
    float r = (i % 2 == 0) ? radius : radius / 2;
    vertex(x + cos(angle) * r, y + sin(angle) * r);
  }
  endShape(CLOSE);
}

void drawTree(int x, int y) {
  fill(0, 150, 0);
  triangle(x - 10, y + 10, x + 10, y + 10, x, y - 10);
}

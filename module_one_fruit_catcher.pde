int basketX;
int basketWidth = 80;
int basketY;
int fruitX;
int fruitY;
int fruitSize = 20;
int score = 0;
int gameTime = 60;
boolean gameOver = false;
int shapeChangeTime = 20000;
int fruitSpawnTime = 1000;
int lastShapeChange;
int lastFruitSpawn;
int startTime;
int remainingLives = 5;

int basketVelocity = 0;
int basketSpeed = 5;

void setup() {
  size(400, 600);
  basketX = width / 2;
  basketY = height - 50;
  fruitX = int(random(width));
  fruitY = 0;
  lastShapeChange = millis();
  lastFruitSpawn = millis();
  startTime = millis();
}

void draw() {
  background(255);
  
  if (gameOver) {
    textSize(32);
    fill(0);
    text("Game Over", width / 2 - 80, height / 2);
    return;
  }
  
  // Draw basket
  fill(150);
  rect(basketX - basketWidth / 2, basketY, basketWidth, 20);
  
  // Draw fruit
  fill(255, 0, 0);
  ellipse(fruitX, fruitY, fruitSize, fruitSize);
  
  // Move fruit
  fruitY += 5;

  // Move basket (# Optional practice for optimize basket movement)
  // basketX += basketVelocity;
  
  // Check if fruit is caught
  if (fruitY > basketY && fruitX > basketX - basketWidth / 2 && fruitX < basketX + basketWidth / 2) {
    score++;
    fruitX = int(random(width));
    fruitY = 0;
  }
  
  // Check if fruit hits the ground
  if (fruitY > height) {
    remainingLives--;
    fruitX = int(random(width));
    fruitY = 0;
    if (remainingLives <= 0) {
      gameOver = true;
    }
  }
  
  // Draw UI
  textSize(16);
  fill(0);
  text("Score: " + score, 10, 20);
  text("Lives: " + remainingLives, 10, 40);
  text("Time: " + (gameTime - (millis() - startTime) / 1000), 10, 60);
  
  // Check if time is up
  if (millis() - startTime > gameTime * 1000) {
    gameOver = true;
  }
}

void keyPressed() {
  if (keyCode == LEFT) {
    basketX -= 20;
  } else if (keyCode == RIGHT) {
    basketX += 20;
  }
}

// # Optional practice for optimize basket movement
// void keyPressed() {
//   if (keyCode == LEFT) {
//     basketVelocity = -basketSpeed;
//   } else if (keyCode == RIGHT) {
//     basketVelocity = basketSpeed;
//   }
// }
// void keyReleased() {
//   basketVelocity = 0;
// }

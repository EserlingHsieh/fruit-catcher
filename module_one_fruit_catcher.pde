int fruitX;
int fruitY;
int basketX;
int basketWidth = 80;
int basketHeight = 20;
int basketY;

int shapeType; // 0: triangle, 1: tree, 2: smile
int basketType; // 0: triangle, 1: tree, 2: smile
int basketTypeChangeTime = 5000;

int score = 0;
int gameTime = 60;
boolean gameOver = false;
int lastShapeChange;
int lastFruitSpawn;
int startTime;

int basketVelocity = 0;
int basketSpeed = 25;
float fruitSpeed;
float minFruitSpeed = 5;
float maxFruitSpeed = 10;

void setup() {
  size(400, 600);
  fruitX = int(random(width));
  fruitY = 0;
  basketX = width / 2;
  basketY = height - 50;
  
  // random shapes for fruits and basket
  shapeType = int(random(3));
  basketType = int(random(3));
  
  startTime = millis();
  lastShapeChange = millis();

  fruitSpeed = minFruitSpeed;
  
}

void drawShape(float type) {
  
    if (type == 0) {
    // #Practice 1-1: draw Triangle
    fill(255, 204, 0);
    triangle(0, 0-20/2, 0- 20/2, 0 + 20/2, 0 + 20/2, 0 + 20/2);
    /// End of practice
  
  } else if (type == 1) {
    // #Practice 1-1: draw Tree
    fill(34, 139, 34);
    triangle(0, 0, 0 - 20/2, 0 + 20/2, 0 + 20/2, 0 + 20/2); 
    triangle(0, 0 - 20/2, 0 - 20/2, 0 + 20/4, 0 + 20/2, 0 + 20/4);
    fill(139, 69, 19);
    rect(0 - 20/8, 0 + 20/2, 20/4, 20/4); 
    /// End of practice
  
  } else if (type == 2) {
    // #Practice 1-1: draw Smile
    fill(255, 204, 0);
    ellipse(0,0, 20, 20);
    fill(0);
    ellipse(0-5, 0-5, 4, 4);
    ellipse(0+5, 0-5, 4, 4);
    noFill();
    arc(0, 0+2, 10, 6, 0, PI);
    /// End of practice
  }
}

void draw() {
  background(255);

  // #Practice 3-1 : Condition -> end game when time is up
  if (gameOver) {
    textSize(32);
    fill(0);
    text("Game Over", width / 2 - 80, height / 2);
    text("Score: "+score, width / 2 - 60, height / 2+40);
    return;
  }
  /// End of exercise
  
  // #Practice 1-1: draw Basket
  fill(150);
  rect(basketX - basketWidth / 2, basketY, basketWidth, basketHeight);
  /// End of practice
  
  pushMatrix(); // draw basket fruit
  translate(basketX, basketY+9);
  scale(0.5);
  drawShape (basketType); //call function drawShape
  popMatrix();
  
  pushMatrix(); // draw fruit
  translate(fruitX, fruitY); 
  drawShape (shapeType); //call function drawShape
  popMatrix();
  
  // #Practice 1-2: fruit fall from top
  fruitY += fruitSpeed;
  /// End of practice
  
  
  // #Practice 3-2: increase game difficulty
  // Gradually increase fruit speed
  float elapsedTime = (millis() - startTime) / 1000.0;
  fruitSpeed = minFruitSpeed + (maxFruitSpeed - minFruitSpeed) * elapsedTime / gameTime;
  if (fruitSpeed > maxFruitSpeed) {
    fruitSpeed = maxFruitSpeed;
  }
  /// End of practice

  
  // #Practice 1-2: Check if fruit hits the ground
  if (fruitY > height) {
    fruitX = int(random(width));
    fruitY = 0;
    shapeType = int(random(3));
  }
  /// End of practice
  
  
  // #Practice 2-2: Check if fruit is caught
  // Add score if correct fruit is caught, else subtract score
  if (fruitY > basketY && fruitX > basketX - basketWidth / 2 && fruitX < basketX + basketWidth / 2) {
    
    if (shapeType == basketType) {
      score++;
    } else {
      score--;
    }
    
    fruitX = int(random(width));
    fruitY = 0; 
    shapeType = int(random(3));
  }
  /// End of practice
  
  
  // #Practice 2-3: Draw UI
  textSize(16);
  fill(0);
  text("Score: " + score, 10, 20);
  text("Time: " + (gameTime - (millis() - startTime) / 1000), 10, 60);
  /// End of exercise

  //Change basket shape every 5 seconds
  if (millis() - lastShapeChange > basketTypeChangeTime) {
    lastShapeChange = millis();
    basketType = int(random(3));
  }
  
  // #Practice 3-1 : end game when time is up
  if (millis() - startTime > gameTime * 1000) {
    gameOver = true;
  }
  /// End of exercise
}


  // #Practice 1-3: control basket with keyboard
  // #Practice 2-1: set boundaries for basket
void keyPressed() {
  if (keyCode == LEFT && basketX >= 0) {
    basketX -= basketSpeed;
  } else if (keyCode == RIGHT && basketX <= 400) {
    basketX += basketSpeed;
  }
}
  /// End of exercise

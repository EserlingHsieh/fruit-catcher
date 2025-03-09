int fruitX; // Center X position of the falling fruit
int fruitY; // Center Y position of the falling fruit
int basketX; // Center X position of the basket
int basketY; // Top Y position of the basket
int basketWidth = 120; // Width of the basket
int basketHeight = 30; // Height of the basket

int shapeType; // Type of the shape for the fruit, 0: triangle, 1: tree, 2: smile
int basketType; // Type of the shape for the basket, 0: triangle, 1: tree, 2: smile
int basketTypeChangeTime = 5000; // Time interval to change basket type

// Game state variables
int score = 0; // Player's score
int gameTime = 60;  // Total game time in seconds
boolean gameOver = false; // Flag to check if the game is over
int lastShapeChange; // Timestamp of the last shape change
int startTime; // Timestamp of the game start

// Basket movement variables
int basketSpeed = 25; // Speed of basket movement

// Fruit speed variables
float fruitSpeed; // Speed of the falling fruit
float minFruitSpeed = 5; // Minimum speed of falling fruit
float maxFruitSpeed = 15; // Maximum speed of falling fruit
PImage background;

void setup() {
  size(400, 600); // Set the size of the window
  background = loadImage ("background.jpeg");
  fruitX = int(random(width)); // Initialize fruit X position randomly
  fruitY = 0; // Initialize fruit Y position at the top
  basketX = width / 2; // Initialize basket X position at the center
  basketY = height - 50; // Initialize basket Y position near the bottom
  
  shapeType = int(random(3)); // Randomly select the initial shape for the fruit
  basketType = int(random(3)); // Randomly select the initial shape for the basket
  
  startTime = millis(); // Record the start time
  lastShapeChange = millis(); // Record the last shape change time

  fruitSpeed = minFruitSpeed; // Initialize fruit speed
}

void drawShape(float type) {
  pushMatrix();
  scale(2);
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
    circle(0-5, 0-5, 4);
    circle(5, 0-5, 4);
    noFill();
    arc(0, 0+2, 10, 6, 0, PI);
    /// End of practice
  }
  popMatrix();
}

void draw() {
  // #Practice 2-1: insert background image
  // background(255);
  image(background,0,0,400,600);
  /// End of practice

  // #Practice 3-1 : Condition -> end game when time is up
  
  // End game when time is up
  if (gameOver) {
    background(255);
    textSize(32);
    fill(0);
    text("Game Over", width / 2 - 80, height / 2);
    text("Score: "+score, width / 2 - 60, height / 2+40);
    return;
  }
  // Check if the time is up
  if (gameTime - (millis() - startTime) / 1000==0){
      gameOver = true;
  }
  /// End of practice
  
  // #Practice 1-3: control basket with mouse
  basketX = mouseX;
  /// End of practice
  
  // Draw falling fruit
  pushMatrix();
  translate(fruitX, fruitY); 
  drawShape(shapeType);
  popMatrix();
  
  // #Practice 1-1: draw Basket
  fill(150);
  int offsetX = 10;  // offset the basket to make it look like a trapezoid
  quad(basketX - basketWidth / 2, basketY, basketX + basketWidth / 2, basketY, basketX + basketWidth / 2 - offsetX, basketY + basketHeight, basketX - basketWidth / 2 + offsetX, basketY+ basketHeight);
  /// End of practice
  
  // Draw basket fruit
  pushMatrix();
  translate(basketX, basketY + basketHeight / 2);
  scale(0.5);
  drawShape(basketType);
  popMatrix();
  
  // #Practice 1-2: fruit fall from top
  fruitY += fruitSpeed;
  /// End of practice
  
  // #Practice 3-2: increase game difficulty
  // Gradually increase fruit speed
  float elapsedTime = (millis() - startTime) / 1000.0; // Elapsed time since the game started
  fruitSpeed = minFruitSpeed + (maxFruitSpeed - minFruitSpeed) * elapsedTime / gameTime;
  /// End of practice

  // #Practice 1-2: Check if fruit hits the ground
  if (fruitY > height) {
    // Reset fruit position and shape
    fruitX = int(random(width));
    fruitY = 0;
    shapeType = int(random(3)); //這裡加個用途說明 因為這個會直接附在初始code裡
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
    
    // Reset fruit position and shape
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
  /// End of practice

  //Change basket shape every 5 seconds
  if (millis() - lastShapeChange > basketTypeChangeTime) {
    lastShapeChange = millis();
    basketType = int(random(3));
  }
}

int fruitX;
int fruitY;
int fruitSize = 20;
int basketX;
int basketWidth = 80;
int basketY;

// # Optional: Add different shapes for fruits and basket
int shapeType; // 0: circle, 1: tree, 2: create your own one!
int basketType; // 0: circle, 1: tree, 2: create your own one!
int basketTypeChangeTime = 5000;
// # End of optional practice

int score = 0;
int gameTime = 60;
boolean gameOver = false;
int lastShapeChange;
int lastFruitSpawn;
int startTime;

int basketVelocity = 0;
int basketSpeed = 25;

void setup() {
  size(400, 600);
  fruitX = int(random(width));
  fruitY = 0;
  basketX = width / 2;
  basketY = height - 50;
  
  // # Optional: Add different shapes for fruits and basket
  shapeType = int(random(3));
  basketType = int(random(3));
  // # End of optional practice
  
  startTime = millis();
  lastShapeChange = millis();
}

void draw() {
  background(255);

  // Exercise : Condition -> end game when time is up
  if (gameOver) {
    textSize(32);
    fill(0);
    text("Game Over", width / 2 - 80, height / 2);
    text("Score: "+score, width / 2 - 60, height / 2+40);
    return;
  }
  /// End of exercise
  
  // Draw basket
  fill(150);
  rect(basketX - basketWidth / 2, basketY, basketWidth, 20);
  
  // # Optional: Add different shapes for fruits and basket
  fill(0);
  if (basketType == 0) {
    // draw face on center of basket, with half the size
    ellipse(basketX, basketY + 7.5, 10, 10); // 臉
    fill(255);
    ellipse(basketX - 2.5, basketY + 5, 2, 2); // 左眼
    ellipse(basketX + 2.5, basketY + 5, 2, 2); // 右眼
    arc(basketX, basketY + 10, 5, 3, 0, PI); // 微笑
  }
  else if (basketType == 1) {
    // draw tree on center of basket, with half the size, using fruit size parameters
    triangle(basketX, basketY + 2.5, basketX - 5, basketY + 10, basketX + 5, basketY + 10); // 上層樹
    triangle(basketX, basketY + 10, basketX - 5, basketY + 15, basketX + 5, basketY + 15); // 下層樹
    rect(basketX - 2.5, basketY + 15, 5, 5); // 樹幹
  }
  else if (basketType == 2) {
    triangle(basketX, basketY + 2.5, basketX - 5, basketY + 10, basketX + 5, basketY + 10);
  }
  // # End of optional practice
  
  // Draw fruit
  
  // # Optional: Add different shapes for fruits and basket
 
  if (shapeType == 0) {
    //ellipse(fruitX, fruitY, fruitSize, fruitSize);
    fill(255, 204, 0);
    ellipse(fruitX, fruitY, fruitSize, fruitSize); // 臉
    fill(0);
    ellipse(fruitX - 5, fruitY - 5, 4, 4); // 左眼
    ellipse(fruitX + 5, fruitY - 5, 4, 4); // 右眼
    noFill();
    arc(fruitX, fruitY + 2, 10, 6, 0, PI); // 微笑
    
  } else if (shapeType == 1) {
    //square(fruitX - fruitSize / 2, fruitY - fruitSize / 2, fruitSize);
    fill(34, 139, 34);
    triangle(fruitX, fruitY - fruitSize / 2, fruitX - fruitSize / 2, fruitY + fruitSize / 4, fruitX + fruitSize / 2, fruitY + fruitSize / 4); // 上層樹
    triangle(fruitX, fruitY, fruitX - fruitSize / 2, fruitY + fruitSize / 2, fruitX + fruitSize / 2, fruitY + fruitSize / 2); // 下層樹
    fill(139, 69, 19);
    rect(fruitX - fruitSize / 8, fruitY + fruitSize / 2, fruitSize / 4, fruitSize / 4); // 樹幹
  
  } else if (shapeType == 2) {
    triangle(fruitX, fruitY - fruitSize / 2, fruitX - fruitSize / 2, fruitY + fruitSize / 2, fruitX + fruitSize / 2, fruitY + fruitSize / 2);
    //create your own one!
  }
  // # End of optional practice
  
  // Move fruit
  fruitY += 5;

  // Move basket (# Optional practice for optimize basket movement)
  // basketX += basketVelocity;
  
  // Check if fruit is caught
  if (fruitY > basketY && fruitX > basketX - basketWidth / 2 && fruitX < basketX + basketWidth / 2) {
    // # Optional: Add score if correct fruit is caught, else subtract score
    // score++;
    if (shapeType == basketType) {
      score++;
    } else {
      score--;
    }
    // # End of optional practice
    
    fruitX = int(random(width));
    fruitY = 0;
    
    // # Optional: Randomize shape of fruit
    shapeType = int(random(3));
    // # End of optional practice
  }
  
  // Check if fruit hits the ground
  if (fruitY > height) {
    fruitX = int(random(width));
    fruitY = 0;
    
    // # Optional: Randomize shape of fruit
    shapeType = int(random(3));
    // # End of optional practice
  }
  
  // Exercise : Draw UI
  textSize(16);
  fill(0);
  text("Score: " + score, 10, 20);
  text("Time: " + (gameTime - (millis() - startTime) / 1000), 10, 60);
  /// End of exercise

  // # Optional: Change basket shape every 5 seconds
  if (millis() - lastShapeChange > basketTypeChangeTime) {
    lastShapeChange = millis();
    basketType = int(random(3));
  }
  // # End of optional practice
  
  // Exercise : Condition -> end game when time is up
  if (millis() - startTime > gameTime * 1000) {
    gameOver = true;
  }
  /// End of exercise
}

void keyPressed() {
  if (keyCode == LEFT) {
    basketX -= basketSpeed;
  } else if (keyCode == RIGHT) {
    basketX += basketSpeed;
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

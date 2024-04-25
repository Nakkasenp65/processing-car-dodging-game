import ddf.minim.*;

class Car {
  private float velocity, distance, posX, posY;
  private float sVel, sDis, sPosX, sPosY;
  //private PImage car;
  private PImage oldCar = loadImage("resources/car1.png");
  private PImage newCar = loadImage("resources/car2.png");
  private PImage truck = loadImage("resources/truck.png");
  int carType;
  int n = 0;

  public Car(float velocity, float distance, float posX, float posY) {

    this.velocity = velocity;
    this.distance = distance;
    this.posX = posX;
    this.posY = posY;

    this.sVel = velocity;
    this.sDis = distance;
    this.sPosX = posX;
    this.sPosY = posY;
    //car = oldCar;
    //car.resize(150, 200);
  }

  public void spawn() {
    if (n==1) {
      carType = 1;
      image(oldCar, this.posX, this.posY);
    } else if(n==0 || n==2){
      carType = 0;
      image(newCar, this.posX, this.posY);
    } else if(n==3){
      carType = 3;
      image(truck, this.posX, this.posY);
    }
  }

  public void go() {
    if (posY >= 900) {
      n = int(random(-1, 4));
      posY = int(random(-800, -200));
    }
    posY+= distance * velocity;
  }

  public void speedUp() {
    if ( distance <= 100 ) {
      distance += random(0, 1);
    }
  }

  public void slowDown() {
    distance -= 4;
  }

  public void reset() {
    this.velocity = sVel;
    this.distance = sDis;
    this.posX = sPosX;
    this.posY = sPosY;
  }
  //car.newCar.width, car.newCar.height
  
  public float getWidth(){
    float carWidth;
    switch(carType){
      case 0:
        carWidth = newCar.width;
        break;
      case 1:
        carWidth = oldCar.width;
        break;
      case 3:
        carWidth = truck.width;
        break;
      default:
        carWidth = 0.0;
        break;
    }
    return carWidth-5;
  }
  
  public float getHeight(){
    float carHeight;
    switch(carType){
      case 0:
        carHeight = newCar.height-5;
        break;
      case 1:
        carHeight = oldCar.height;
        break;
      case 3:
        carHeight = truck.height;
        break;
      default:
        carHeight = 0.0;
        break;
    }
    return carHeight-5;
  }
  
}//ClassCar

Minim minim;
AudioPlayer bell, bgm, mainMenuSong;
PFont font;
PImage player, backgroundImg, menu1, menu2, death, grave;

Car[] cars = new Car[6];
int playerX = 640;
int playerY = 560;
int y = 560;
int speedTimer = 0;
int deathTime = 0;
int graveX;
int score = 0;
int mode = 0;

boolean moveLeft = false;
boolean moveRight = false;
boolean moveDown = false;
boolean moveUp = false;

void setup() {
  
  minim = new Minim(this);
  mainMenuSong = minim.loadFile("resources/menu.mp3");
  bell = minim.loadFile("resources/bell.mp3");
  bgm = minim.loadFile("resources/bgm.mp3");
  
  font = createFont("resources/Pixeboy-z8XGD.ttf", 128);
  textFont(font);
  
  size(1280, 720);
  frameRate(60);
  backgroundImg = loadImage("data/background.png");
  menu1 = loadImage("resources/menu.png");
  menu2 = loadImage("resources/menu2.png");
  grave = loadImage("resources/grave.png");
  death = loadImage("resources/death.png");
  player = loadImage("resources/character.png");
  //player.resize(80, 87);

  cars[0] = new Car(0.2, 10, 200, -700);
  cars[1] = new Car(0.2, 10, 350, -500);
  cars[2] = new Car(0.2, 10, 510, 0);
  cars[3] = new Car(0.2, 10, 665, -200);
  cars[4] = new Car(0.2, 10, 827, -100);
  cars[5] = new Car(0.2, 10, 975, -400);
}

void draw() {
  
  //mode 1 run/ mode 0 menu/ mode 3 death
  switch(mode){
    case 1:
      
      runGame();
      break;
    case 0: 
      background(menu1);
      mainMenuSong.play();
      break;
    case 3:
      background(backgroundImg);
      delay(3000);
      mode = 4;
      break;
    case 4: 
      bell.play();
      background(death);
      textAlign(CENTER, CENTER); // Align text to the center of the screen
      textSize(72); // Set text size
      text("Score: " + score, width / 2, height / 2); // Draw the score
      break;
    default:
      background(menu1);
      break;
  }
  
}

void carReset() {
  for (Car car : cars) {
    car.reset();
  }
}

void carHandler() {
  for (Car car : cars) {
    car.spawn();
    car.go();
  }
}

void speedHandler() {
  int randomIndex = int(random(0, cars.length));
  cars[randomIndex].speedUp();
}

void loadAudioFiles() {
  mainMenuSong = minim.loadFile("resources/menu.mp3");
  bell = minim.loadFile("resources/bell.mp3");
  bgm = minim.loadFile("resources/bgm.mp3");
}

void runGame() {
  bgm.play();
  background(backgroundImg);
  image(player, playerX, playerY);
  carHandler();

  if (speedTimer >= 4) {
    speedTimer = 0;
    score += 1;
    speedHandler();
  }
  
  speedTimer++;

  if (moveLeft) {
    playerX = max(playerX - 10, 185); 
  }
  
  if (moveRight) {
    playerX = min(playerX + 10, 1025);
  }
  
  if (moveUp) {
    playerY = min(playerY - 10, 720); 
  }
  
  if (moveDown) {
    playerY = max(playerY + 10, 0); 
  }

  for (Car car : cars) {
    if (checkCollision(playerX, playerY, player.width, player.height, car.posX, car.posY, car.getWidth(), car.getHeight()) ||
      checkCollision(playerX, playerY, player.width, player.height, car.posX, car.posY, car.getWidth(), car.getHeight()) ||
      checkCollision(playerX, playerY, player.width, player.height, car.posX, car.posY, car.getWidth(), car.getHeight()))
      {
        background(backgroundImg);
        carHandler();
        image(grave, playerX, playerY);
        println("Collision detected!");
        bgm.close();
        
        mode = 3;
    }
  }
  
  
  fill(255); // Set text color to white
  textAlign(RIGHT, TOP); // Align text to the top right corner
  textSize(64); // Set text size
  text("Score: " + score, width - 10, 10); // Draw the score
  
}

void keyPressed() {

  if (keyCode == 'r' || keyCode == 'R') {
    mainMenuSong.close();
    loadAudioFiles();
    score = 0;
    mode = 1;
    carReset();
    
  } else if(keyCode == 'm' || keyCode == 'M'){
    mode = 0;
    carReset();
  }

  if (keyCode == LEFT) {
    moveLeft = true;
  } else if (keyCode == RIGHT) {
    moveRight = true;
  } else if (keyCode == UP){
    moveUp = true;
  } else if (keyCode == DOWN){
    moveDown = true;
  }
}

void keyReleased() {
  if (keyCode == LEFT) {
    moveLeft = false;
  } else if (keyCode == RIGHT) {
    moveRight = false;
  } else if (keyCode == UP){
    moveUp = false;
  } else if (keyCode == DOWN){
    moveDown = false;
  }
}

boolean checkCollision(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  // Check if the rectangles defined by (x1, y1, w1, h1) and (x2, y2, w2, h2) intersect
  return x1 < x2 + w2 && x1 + w1 > x2 && y1 < y2 + h2 && y1 + h1 > y2;
}

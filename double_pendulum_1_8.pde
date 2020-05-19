//http://www.myphysicslab.com/dbl_pendulum.html for reference
//Owen Martin
//My double pendulums <3 <3 <3

//Variable initialization.
DoublePendulum pendulum;
DoublePendulum pendulum2;
DoublePendulum pendulum3;

double dt;
double friction;
int counter = 0;
float r = 1;
float g = 1;
float b = 1;
int r_value = 0;
int g_value = 0;
int b_value = 0;
color white = color(255, 255, 255, 5);
color black = color(0, 0, 0, 45);
color brown = color(112,61,0,35);

//Processing setup
void setup() {
  fullScreen(P3D);
  smooth(8);
  frameRate(30);
  init();
}

//This is where I can initialize my pendulum values
void init() {
  dt = 0.005;
  friction = 0.003;
  background(20);

  //center x, center y, length1, length2, mass1, mass2, angle1, angle2, angular velocity1, angular velocity 2, color
  pendulum = new DoublePendulum(width/2, height/2, 2, 2, 1.0, 1.0, radians(random(360)), radians(random(360)), 0.0, 0.0, 9.81);
  
  pendulum2 = new DoublePendulum(width/2, height/2, 1, 1, 1.0, 1.0, radians(random(360)), radians(random(360)), 0.0, 0.0, 9.81);
  
  pendulum3 = new DoublePendulum(width/2, height/2, 0.65, 0.95, 2.0, 2.0, radians(random(360)), radians(random(360)), 0.0, 0.0, 9.81);
}

//This should draw an eye
void draw() {
  for (int i=0; i<30; i++) { 
    pendulum.draw(pendulum.update(), white);
    //This is where you can choose how the pendulum objects interact with the canvas.
    //They can draw themselves, update themselves, or modify themselves
    pendulum3.draw_weighted(black, brown);
    pendulum3.update();
  }
} //<>//

void keyPressed() {
    if (key == 's') {
      save("pendulum_" + str(millis()) + ".png");
  }
}
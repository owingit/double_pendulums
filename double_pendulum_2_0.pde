//http://www.myphysicslab.com/dbl_pendulum.html


//Globals
double dt; //delta t
double friction; //coefficient of friction

//For colors
float r = 1; 
float g = 1; 
float b = 1; 
int r_value = 0; 
int g_value = 0;
int b_value = 0;
color white = color(255, 255, 255, 5);
color black = color(5, 5, 5, 65);
color brown = color(112,61,0,35);
color pink = color(255,192,203);

//Initialize pendulums
DoublePendulum pendulum;
DoublePendulum pendulum2;
DoublePendulum pupil_pendulum;

//For when I want to record
boolean recording = false;

void setup() {
  fullScreen(P3D);
  smooth(8);
  frameRate(40);
  init();
}

void init() {
  /* 
   a higher dt makes the simulation go much faster, while a lower (or negative!)
   friction causes wacky, unrealistic but fascinating behavior.
   add gravitational constant (gc) back here when you want the pendulums to have standardized gravity (it's currently a member object
   of the pendulum class because you were trying to give them each different gravities, you crazy God you
  */
  dt = 0.000095;
  friction= -0.271828;
  background(255); //255 for white 0 for black

  /* Pendulum parameters: 
     DoublePendulum(center x coords, center y coords, length1, l2, mass1, mass2, angle1, angle2, angular velocity1, angular velocity2, gravitational constant)
  */
  
  //Create three pendulum objects
  //TODO: an interesting follow up would be to enclose this portion in a kind of genetic algorithm to produce stronger results over time
  //I could write code to assign scores to each of the output pendulums based on a variety of factors: # of times the pendulum goes around,
  //dominating color, distance from being a full circle upon completion, etc.
  //Then, I could optimize these values based on those criteria and create a more interesting simulator
  pendulum = new DoublePendulum(width/2, height/2, 2, 2, 5.0, 3.0, radians(random(360)), radians(random(360)), 0.0, 0.0, 9.81);
  pendulum2 = new DoublePendulum(width/2, height/2, 1, 1, 3.0, 5.0, radians(random(360)), radians(random(360)), 0.0, 0.0, 9.81);
  pupil_pendulum = new DoublePendulum(width/2, height/2, 0.001, 0.65, 2.0, 2.0, radians(random(360)), radians(random(360)), 0.0, 0.0, 9.81);
}


void draw() {
  for (int i=0; i<50; i++) {     
    //Include as many pendulums as you want
    pendulum.draw(pendulum.update(), pendulum.update());
    pendulum.update();
    
    //pendulum2.draw();
    //pendulum2.update();
    
    //Using black as color2 here makes it a pupil
    pupil_pendulum.draw_weighted(pink, black);
    pupil_pendulum.update();
  }
  if (recording) {
    saveFrame("output/Pend_####.png");
  }
  //stroke(255,150);
  //ellipse(width/2, 300, 10, 10);
} //<>//

void keyPressed() {
    if (key == 's') {
      save("pendulum_" + str(millis()) + ".png");
    }
    if (key == 'r') {
      recording = !recording;
    }
}
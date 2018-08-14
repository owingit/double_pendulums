class DoublePendulum {
  //Variable initialization
  double phi1, omega1, phi2, omega2;
  double mass1, mass2;
  double length1, length2;
  float x1, y1, x2, y2;
  float  cx, cy;  
  double gc;

  //Variables for RK4
  double[] k1, l1, k2, l2;

  DoublePendulum(float  cx, float  cy, double length1, double length2, double mass1, double mass2, double phi1, double phi2, double omega1, double omega2, double gc) {
    this.cx=cx;
    this.cy=cy;
    this.length1=length1;
    this.phi1=phi1;
    this.omega1=omega1;
    this.mass1=mass1;
    k1= new double[4];
    l1= new double[4];
    this.length2=length2;
    this.phi2=phi2;
    this.omega2=omega2;
    this.mass2=mass2;
    k2= new double[4];
    l2= new double[4];
    this.gc=gc;
  }
  // delta angular velo
  double domega1(double phi1, double phi2, double omega1, double omega2) {
    return (-gc*(2*mass1+ mass2)*Math.sin(phi1)-mass2*gc*Math.sin(phi1-2*phi2)-2*Math.sin(phi1-phi2)*mass2*(omega2*omega2*length2+omega1*omega1*length1*Math.cos(phi1-phi2)) )/ (length1*( 2*mass1 + mass2 - mass2*Math.cos(2*phi1-2*phi2)))-(friction*omega1);
  }

  //delta angular velo
  double domega2(double phi1, double phi2, double omega1, double omega2) {
    return 2*Math.sin(phi1-phi2)*(omega1*omega1*length1*(mass1+mass2)+gc*(mass1+mass2)*Math.cos(phi1)+omega2*omega2*length2*mass2*Math.cos(phi1-phi2))/ (length2*( 2*mass1 + mass2 - mass2*Math.cos(2*phi1-2*phi2)))-(friction*omega2);
  }


  /* This function originally was void, but I have it return the subsequent color (this part can be updated to fit one's liking - currently, 
     color uses the angular velocity to calculate a random color
     The critical part of this function is the Runge-Katta fourth-order method approximation of the differential equations for 
     double pendulum movement, which allows the program to plot the motion of the pendulums
  */ 
  color update() {
    k1[0] = dt * omega1;
    l1[0] = dt * domega1(phi1, phi2, omega1, omega2);
    k1[1] = dt * (omega1 + l1[0] / 2);
    l1[1] = dt * domega1(phi1 + k1[0] / 2, phi2, omega1 + l1[0] /2, omega2);
    k1[2] = dt * (omega1 + l1[1] /2);
    l1[2] = dt * domega1(phi1 + k1[1] / 2, phi2, omega1 + l1[1] / 2, omega2);
    k1[3] = dt * (omega1 + l1[2]);
    l1[3] = dt * domega1(phi1 + k1[2], phi2, omega1 + l1[2], omega2);
    k2[0] = dt * omega2;
    l2[0] = dt * domega2(phi1, phi2, omega1, omega2);
    k2[1] = dt * (omega2 + l2[0] / 2);
    l2[1] = dt * domega2(phi1, phi2 + k2[0] / 2, omega1, omega2 + l2[0] / 2);
    k2[2] = dt * (omega2 + l2[1] / 2);
    l2[2] = dt * domega2(phi1, phi2 + k2[1] / 2, omega1, omega2 + l2[1] / 2);
    k2[3] = dt * (omega2 + l2[2]);
    l2[3] = dt * domega2(phi1, phi2 + k2[2], omega1, omega2 + l2[2]);

    phi1 = phi1 + (k1[0] + 2 * k1[1] + 2 * k1[2] + k1[3]) / 6;
    omega1 = omega1 + (l1[0] + 2 * l1[1] + 2 * l1[2] + l1[3]) / 6;
    phi2 = phi2 + (k2[0] + 2 * k2[1] + 2 * k2[2] + k2[3]) / 6;
    omega2 = omega2 + (l2[0] + 2 * l2[1] + 2 * l2[2] + l2[3]) / 6;
    x1=(float)(cx + 100 * length1 * Math.sin(phi1));
    y1=(float)(cy + 100 * length1 * Math.cos(phi1));
    x2=(float)(x1 + 100 * length2 * Math.sin(phi2));
    y2=(float)(y1 + 100 * length2 * Math.cos(phi2));

    //Change me for fun color options!
    r_value = (int)(noise((float)omega1) * 255);
    g_value = (int)(noise((float)omega2) * 255);
    b_value = (int)(noise((float)omega1) * 255);
    
    color c = color(r_value, g_value, b_value, 10); 
    return c;
  }

  void draw(color c1, color c2) {
    stroke(c2);
    strokeWeight(0.5);
    line(cx, cy, (float)omega2, x1, y1, (-(float)omega1));
    stroke(c1);
    line(x1, y1, (float)omega1, x2, y2, (-(float)omega2));
    //fill(0);
    
    /*ellipse(x1, y1, (float)omega1, (float)omega2);
    fill(c);
    ellipse(x2, y2, 2, 2);
    fill(c);*/
  }
  
    void draw_weighted(color color_1, color color_2) {
    
    //line(cx, cy, (float)omega2, x1, y1, (-(float)omega1));
    //color c = color(((x1 % 255) / 255) * 120, ((y1 % 255) / 255) * 60, 0, 35);
    stroke(color_1,5);
    strokeWeight(5.0);
    line(cx, cy, (float)omega1, x1, y1 ,(float)omega2);
    stroke(color_2, 95);
    strokeWeight(5.0);
    line(x1, y1, (float)omega1, x2, y2, -(float)omega2);

    //fill(0);
  }
}
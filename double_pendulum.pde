class DoublePendulum {
  double phi1, omega1, phi2, omega2;
  double mass1, mass2;
  double length1, length2;
  float x1, y1, x2, y2;
  float  cx, cy;
  double[] k1, l1, k2, l2;
  double gc;

  DoublePendulum(float  cx, float  cy, double length1, double length2, double mass1, double mass2, double phi1, double phi2, double omega1, double omega2, /*color c, color c2,*/ double gc) {
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

  double domega1(double phi1, double phi2, double omega1, double omega2) {
    return (-gc * (2*mass1+ mass2) * Math.sin(phi1)-mass2 * gc * Math.sin(phi1-2*phi2) - 2*Math.sin(phi1-phi2) * mass2*(omega2*omega2*length2+omega1*omega1*length1 * Math.cos(phi1-phi2))) / (length1 * ( 2*mass1 + mass2 - mass2 * Math.cos(2*phi1-2*phi2))) - (friction*omega1);
  }

  double domega2(double phi1, double phi2, double omega1, double omega2) {
    return 2*Math.sin(phi1-phi2) * (omega1*omega1*length1*(mass1+mass2)+ gc *(mass1+mass2) * Math.cos(phi1)+omega2*omega2*length2*mass2 * Math.cos(phi1-phi2)) / (length2 *( 2*mass1 + mass2 - mass2 * Math.cos(2*phi1-2*phi2))) - (friction*omega2);
  }

  color update() {//RK4
    k1[0] = dt*omega1;
    l1[0] = dt*domega1(phi1, phi2, omega1, omega2);
    k1[1] = dt*(omega1+l1[0]/2);
    l1[1] = dt*domega1(phi1+k1[0]/2, phi2, omega1+l1[0]/2, omega2);
    k1[2] = dt*(omega1+l1[1]/2);
    l1[2] = dt*domega1(phi1+k1[1]/2, phi2, omega1+l1[1]/2, omega2);
    k1[3] = dt*(omega1+l1[2]);
    l1[3] = dt*domega1(phi1+k1[2], phi2, omega1+l1[2], omega2);
    k2[0] = dt*omega2;
    l2[0] = dt*domega2(phi1, phi2, omega1, omega2);
    k2[1] = dt*(omega2+l2[0]/2);
    l2[1] = dt*domega2(phi1, phi2+k2[0]/2, omega1, omega2+l2[0]/2);
    k2[2] = dt*(omega2+l2[1]/2);
    l2[2] = dt*domega2(phi1, phi2+k2[1]/2, omega1, omega2+l2[1]/2);
    k2[3] = dt*(omega2+l2[2]);
    l2[3] = dt*domega2(phi1, phi2+k2[2], omega1, omega2+l2[2]);

    phi1 = phi1 + (k1[0]+2*k1[1]+2*k1[2]+k1[3])/6;
    omega1 = omega1 + (l1[0]+2*l1[1]+2*l1[2]+l1[3])/6;
    phi2 = phi2 + (k2[0]+2*k2[1]+2*k2[2]+k2[3])/6;
    omega2 = omega2 + (l2[0]+2*l2[1]+2*l2[2]+l2[3])/6;
    x1=(float)(cx+100*length1*Math.sin(phi1));
    y1=(float)(cy+100*length1*Math.cos(phi1));
    x2=(float)(x1+100*length2*Math.sin(phi2));
    y2=(float)(y1+100*length2*Math.cos(phi2));
    color point_color = color_update(counter);
    return point_color;
  }
  
  color color_update(int counter) {
    counter = 0;
    counter += 1;
    if (counter % 360 == 0) {
      r += random(10);
      g += random(10);
      b += random(10);
    }
    if (r > 255) {
      r_value = 510 - (int)r;
      if (r > 510) {
        r = 0;
        r_value = 0;
      }
    } else r_value = (int)r;
    if (g > 255) {
      g_value = 510 - (int)g;
      if (g > 510) {
        g = 0;
        g_value = 0;
      }
    } else g_value = (int)g;
    if (b > 255) {
      b_value = 510 - (int)b;
      if (b > 510) {
        b = 0;
        b_value = 0;
      }
    } else b_value = (int)b;
    
    color c = color(r_value, g_value, b_value, 10); 
    return c;
    
  }

  void draw(color random, color white) {
      stroke(white);
      strokeWeight(1.0);
      line(cx, cy, (float)omega2, x1, y1, (-(float)omega1));
      stroke(random);
      line(x1, y1, (float)omega1, x2, y2, (-(float)omega2));
      fill(0);
  }
  
  //This is just draw_differently, essentially.
  //The idea was to allow you to define functions here that alter the way the pendulum draws itself.
  void draw_weighted(color black, color brown) {
      stroke(black);
      strokeWeight(1.0);
      point(cx, cy, 5);
      point( x1, y1, 5);
      stroke(brown);
      strokeWeight(5);
      point(x1, y1, (float)omega1);
      point(x2, y2, (-(float)omega2));
  }
}